//
//  LeaseRentPaymentsViewController.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

class LeaseRentPaymentsViewController: BaseViewController {
    @IBOutlet weak var leaseRentalTableView: UITableView!
    @IBOutlet weak var leaseeNameLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var basisLabel: UILabel!
    @IBOutlet weak var paymentDayLabel: UILabel!
    let viewModel = LeaseRentPaymentsViewModel()
    var leasee: Leasee? = nil
    var leaseDetail: LeaseDetail? = nil
    var rentals: [LeaseRental] = [] {
        didSet {
            DispatchQueue.main.async {
                self.leaseRentalTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModelListners()
        self.setupUI()
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
            self.updateLeaseDetailUI()
            self.viewModel.calculate()
        }
        self.viewModel.leaseRentals.bind { rentals in
            self.rentals = rentals
        }
    }
    
    private func setupUI() {
        leaseRentalTableView.generalSetup(nibName: "RentalTableViewCell", cellReuseIdentifier: "rental_cell", delegate: self, dataSource: self)
        leaseeNameLabel.text = self.leasee?.tenant ?? ""
    }
    
    private func updateLeaseDetailUI() {
        DispatchQueue.main.async {
            self.startDateLabel.text = self.leaseDetail?.startDate ?? ""
            self.endDateLabel.text = self.leaseDetail?.endDate ?? ""
            self.basisLabel.text = self.leaseDetail?.frequency.rawValue.firstUppercased ?? ""
            self.paymentDayLabel.text = self.leaseDetail?.paymentDay.rawValue.firstUppercased ?? ""
        }
    }
    
    
    @IBAction func didPressClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LeaseRentPaymentsViewController: UITableViewDelegate {
    
}

extension LeaseRentPaymentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rental_cell") as! RentalTableViewCell
        cell.from.text = self.rentals[indexPath.row].from.toString()
        cell.to.text = self.rentals[indexPath.row].to.toString()
        cell.days.text = "\(self.rentals[indexPath.row].days)"
        cell.rental.text = String(format: "%.2f", ceil(self.rentals[indexPath.row].amount * 100) / 100)
        
        return cell
    }
    
    
}

