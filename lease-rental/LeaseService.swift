//
//  LeaseService.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

class LeaseService {
    func fetchLeases(completion: @escaping ([Lease]?, RESTError?)->Void) {
        let leassesResource = Resource<[Lease]>(method: .get, route: "/leases")
        HttpClient.load(resource: leassesResource) { (status, obj, error) in
            completion(obj, error)
        }
    }
}
