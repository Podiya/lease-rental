//
//  DateExtension.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 2/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

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
