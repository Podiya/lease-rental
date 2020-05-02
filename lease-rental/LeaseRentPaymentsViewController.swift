//
//  LeaseRentPaymentsViewController.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

class LeaseRentPaymentsViewController: BaseViewController {
    let viewModel = LeaseRentPaymentsViewModel()
    var leasee: Leasee? = nil
    var leaseDetail: LeaseDetail? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModelListners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let leasee = self.leasee else { return }
        self.viewModel.getLeaseDetail(id: leasee.id)
    }
    
    private func setupViewModelListners() {
        self.viewModel.status.bind { status in
            status == .fetching ? self.showHud() : self.hideHud()
        }
        self.viewModel.leaseDetail.bind { leaseDetail in
            self.leaseDetail = leaseDetail
            self.viewModel.calculate()
        }
        self.viewModel.leaseRentals.bind { rentals in
            for rental in rentals {
                print("\n===========================\n")
                print("\(rental.from.toString()) / \(rental.to.toString()) / \(rental.days) / \(rental.amount)")
            }
        }
    }
}


