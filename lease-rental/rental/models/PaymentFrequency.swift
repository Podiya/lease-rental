//
//  PaymentFrequency.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 3/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

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
