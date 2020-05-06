//
//  PaymentDay.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 3/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

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
