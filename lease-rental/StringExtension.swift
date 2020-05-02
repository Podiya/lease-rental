//
//  StringExtension.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 2/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

extension String {
    public func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd"
        return df.date(from: self)
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
