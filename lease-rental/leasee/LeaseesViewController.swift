//
//  LeaseesViewController.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

class LeaseesViewController: BaseViewController {
    @IBOutlet weak var tableViewParent: UIView!
    @IBOutlet weak var leaseesTableView: UITableView!
    private let viewModel = LeaseesViewModel()
    private let cellIdentifier = "leasee_Cell"
    fileprivate var leasees: [Leasee] = [] {
        didSet {
            DispatchQueue.main.async {
                self.leaseesTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelListners()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getLeasees()
    }
    
    @objc func refreshTable() {
        self.viewModel.getLeasees(isCheckingStatus: false)
    }
}

extension LeaseesViewController: UIViewControllerSetup {
    func setupViewModelListners() {
        self.viewModel.status.bind { status in
            status == .fetching ? self.showHud() : self.hideHud()
        }
        self.viewModel.leasees.bind { leasees in
            self.leaseesTableView.endRefreshing()
            self.leasees = leasees
        }
        self.viewModel.error.bind { error in
            guard let error = error else { return }
            self.showAlert(text: error, type: FloatingAlertType.error)
        }
    }
    
    func setupUI() {
        leaseesTableView.generalSetup(
            nibName: String(describing: LeaseeTableViewCell.self),
            cellReuseIdentifier: cellIdentifier,
            delegate: self,
            dataSource: self)
        leaseesTableView.addRefreshController { controller in
            controller.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)
        }
    }
}

extension LeaseesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let controller = LeaseRentPaymentsViewController()
            controller.leasee = self.leasees[indexPath.row]
            controller.isModalInPresentation = true
            self.present(controller, animated: true)
        }
    }
}

extension LeaseesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leasees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! LeaseeTableViewCell
        cell.leaseeName.text = self.leasees[indexPath.row].tenant
        return cell
    }
}

