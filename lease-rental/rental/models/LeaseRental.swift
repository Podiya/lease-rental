//
//  LeaseRental.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 3/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

struct LeaseRental {
    var from: Date
    var to: Date
    var days: Int
    var rentalPerDay: Double
    var amount: Double {
        return Double(days) * rentalPerDay
    }
    var rental: String {
        return String(format: "%.2f", ceil(amount * 100) / 100)
    }
}
