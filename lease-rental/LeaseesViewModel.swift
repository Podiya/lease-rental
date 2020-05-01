//
//  LeasesViewModel.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

enum Status {
    case fetching
    case done
}

class BaseViewModel {
    var status: Dynamic<Status> = Dynamic(Status.done)
}

class LeaseesViewModel: BaseViewModel {
    let service = LeaseService()
    var leasees: Dynamic<[Leasees]> = Dynamic([])
    
    func fetchLeasees() {
        status.value = .fetching
        service.fetchLeasees { (leases, error) in
            self.status.value = .done
            if let error = error {
                self.leasees.value = []
            } else if let leases = leases {
                self.leasees.value = leases
            }
        }
    }
}
