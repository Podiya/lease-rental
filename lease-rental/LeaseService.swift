//
//  LeaseService.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

class LeaseService {
    func fetchLeasees(completion: @escaping ([Leasees]?, RESTError?)->Void) {
        let leassesResource = Resource<[Leasees]>(method: .get, route: "/leases")
        HttpClient.load(resource: leassesResource) { (status, obj, error) in
            completion(obj, error)
        }
    }
}
