//
//  LeaseService.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

class LeaseService {
    func getLeasees(completion: @escaping ([Leasee]?, RESTError?) -> Void) {
        let leassesResource = Resource<[Leasee]>(method: .get, route: "/leases")
        HttpClient.load(resource: leassesResource) { (status, obj, error) in
            completion(obj, error)
        }
    }
    
    func getLeaseDetail(id: String, completion: @escaping (LeaseDetail?,RESTError?) -> Void) {
        let leassesResource = Resource<LeaseDetail>(method: .get, route: "/leases/\(id)")
        HttpClient.load(resource: leassesResource) { (status, obj, error) in
            completion(obj, error)
        }
    }
}
