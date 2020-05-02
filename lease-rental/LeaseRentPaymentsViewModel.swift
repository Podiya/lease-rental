//
//  LeaseRentPaymentsViewModel.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd"
        return df.date(from: self)
    }
}

extension Date {
    public func next(_ weekday: Weekday,
                     direction: Calendar.SearchDirection = .forward,
                     considerToday: Bool = false) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(weekday: weekday.rawValue)

        if considerToday &&
            calendar.component(.weekday, from: self) == weekday.rawValue {
            return self
        }

        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction)!
    }

    public enum Weekday: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    public func toString(format: String = "yyyy-MM-dd") -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: self)
    }
}

enum PaymentDay: String, Codable {
    case monday, tuesday, wednesday, thursday, friday
    
    var day: Int {
        switch self {
        case .monday:
            return 2
        case .tuesday:
            return 3
        case .wednesday:
            return 4
        case .thursday:
            return 5
        case .friday:
            return 6
        }
    }
}

enum PaymentFrequency: String, Codable {
    case weekly, fortnightly, monthly
    
    var value: Int {
        switch self {
        case .weekly:
            return 7
        case .fortnightly:
            return 14
        case .monthly:
            return 28
        }
    }
}

struct LeaseDetail: Codable {
    let id, startDate, endDate: String
    let rent: Double
    let frequency: PaymentFrequency
    let paymentDay: PaymentDay
    var start: Date? {
        return startDate.toDate()
    }
    var end: Date? {
        return endDate.toDate()
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate = "start_date"
        case endDate = "end_date"
        case rent, frequency
        case paymentDay = "payment_day"
    }
}

struct LeaseRental {
    var from: Date
    var to: Date
    var days: Int
    var rentalPerDay: Double
    var amount: Double {
        return Double(days) * rentalPerDay
    }
}


class LeaseRentPaymentsViewModel: BaseViewModel {
    let service = LeaseService()
    var leaseDetail: Dynamic<LeaseDetail?> = Dynamic(nil)
    var leaseRentals: Dynamic<[LeaseRental]> = Dynamic([])

    func getLeaseDetail(id: String) {
        status.value = .fetching
        service.getLeaseDetail(id: id) { (detail, error) in
            self.status.value = .done
            if let error = error {
                self.leaseDetail.value = nil
            } else if let detail = detail {
                self.leaseDetail.value = detail
            }
        }
    }
    
    func diffDays(from: Date, to: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: from, to: to).day
    }
    
    /**
            calculate lease rentals from lease detail
     */
    func calculate() {
        var leaasRentals = [LeaseRental]()
        guard let leaseDetail = self.leaseDetail.value else {
            leaseRentals.value = []
            return
        }
        guard let startDate = leaseDetail.start,
            let endDate = leaseDetail.end,
            let weekDay = Date.Weekday(rawValue: leaseDetail.paymentDay.day)
            else { leaseRentals.value = []; return }
        let calendar = Calendar.current
        
        var nextStartDate = startDate.next(weekDay, considerToday: true)
        guard let startDiff = diffDays(from: startDate, to: nextStartDate) else {
            leaseRentals.value = []
            return
        }
        add(leaasRentals: &leaasRentals, leaasRental:
            LeaseRental(from: startDate,
                        to: nextStartDate.addingTimeInterval(-(24 * 60 * 60)),
                        days: startDiff,
                        rentalPerDay: (leaseDetail.rent / 7)))
        let frequencyDateComponents = DateComponents(day: leaseDetail.frequency.value)
        while endDate > nextStartDate {
            let newDate = calendar.date(byAdding: frequencyDateComponents, to: nextStartDate)!
            if newDate > endDate {
                guard let endDiff = diffDays(from: nextStartDate, to: endDate) else {
                    leaseRentals.value = []
                    return
                }
                add(leaasRentals: &leaasRentals, leaasRental:
                    LeaseRental(from: nextStartDate,
                                to: endDate,
                                days: endDiff + 1,
                                rentalPerDay: (leaseDetail.rent / 7)))
                break
            }
            guard let nextDiff = diffDays(from: nextStartDate, to: newDate) else {
                leaseRentals.value = []
                return
            }
            add(leaasRentals: &leaasRentals, leaasRental:
                LeaseRental(from: nextStartDate,
                            to: newDate.addingTimeInterval(-(24 * 60 * 60)),
                            days: nextDiff,
                            rentalPerDay: (leaseDetail.rent / 7)))
            
            nextStartDate = newDate
        }
        self.leaseRentals.value = leaasRentals
    }
    
    func add(leaasRentals: inout [LeaseRental], leaasRental: LeaseRental) {
        leaasRentals.append(leaasRental)
    }
}
