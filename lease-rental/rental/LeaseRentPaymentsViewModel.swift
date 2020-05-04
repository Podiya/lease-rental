//
//  LeaseRentPaymentsViewModel.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

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
                self.error.value = error.errorDescription
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
        
        // Getting first pay date
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
        
        // Calcualting other pay days
        while endDate > nextStartDate {
            let newDate = calendar.date(byAdding: frequencyDateComponents, to: nextStartDate)!
            if newDate > endDate {
                // Getting last pay date
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
