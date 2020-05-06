//
//  lease_rental_tests.swift
//  lease-rental-tests
//
//  Created by Ravindu Senevirathna on 6/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import XCTest
@testable import Lease_Rental

class lease_rental_tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIGetLeasees() {
        let e = expectation(description: "Loading leasees via HttpClient")
        let leassesResource = Resource<[Leasee]>(method: .get, route: "/leases")
        HttpClient.load(resource: leassesResource) { (status, obj, error) in
            XCTAssertNotNil(obj)
            e.fulfill()
        }
        waitForExpectations(timeout: 20) { error in
          if let error = error {
            XCTFail("waitForExpectationsWithTimeout errored: \(error)")
          }
        }
    }

    func testCalculateLeaseRentals() {
        let lrpvm = LeaseRentPaymentsViewModel()
        lrpvm.leaseDetail.value = LeaseDetail(id: "lease-a",
                                              startDate: "2018-08-09",
                                              endDate: "2018-12-28",
                                              rent: 510.0,
                                              frequency: PaymentFrequency.fortnightly,
                                              paymentDay: PaymentDay.tuesday)
        let rentals = lrpvm.calculate()
        XCTAssert(rentals.count != 0)
        XCTAssert(rentals.last?.days == 11)
    }
}
