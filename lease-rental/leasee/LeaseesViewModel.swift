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
    var error: Dynamic<String?> = Dynamic(nil)
}

class LeaseesViewModel: BaseViewModel {
    let service = LeaseService()
    var leasees: Dynamic<[Leasee]> = Dynamic([])
    
    func getLeasees(isCheckingStatus: Bool = true) {
        status.value = isCheckingStatus ? .fetching : .done
        service.getLeasees { (leases, error) in
            self.status.value = .done
            if let error = error {
                self.leasees.value = []
                self.error.value = error.errorDescription
            } else if let leases = leases {
                self.leasees.value = leases
            }
        }
    }
}
