//
//  LeaseDetail.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 3/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

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
