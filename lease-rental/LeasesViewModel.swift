//
//  LeasesViewModel.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

class LeasesViewModel {
    let service = LeaseService()
    var leases: Dynamic<[Lease]> = Dynamic([])
    
    func fetchLeases() {
        service.fetchLeases { (leases, error) in
            if let error = error {
                self.leases.value = []
            } else if let leases = leases {
                self.leases.value = leases
            }
        }
    }
}
