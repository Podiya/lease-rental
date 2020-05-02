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
    
    private func setupUI() {
        leaseesTableView.generalSetup(
            nibName: "LeaseeTableViewCell",
            cellReuseIdentifier: "leasee_Cell",
            delegate: self,
            dataSource: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getLeasees()
    }
    
    private func setupViewModelListners() {
        self.viewModel.status.bind { status in
            status == .fetching ? self.showHud() : self.hideHud()
        }
        self.viewModel.leasees.bind { leasees in
            self.leasees = leasees
        }
    }
}


extension LeaseesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let controller = LeaseRentPaymentsViewController()
            controller.leasee = self.leasees[indexPath.row]
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "leasee_Cell") as! LeaseeTableViewCell
        cell.leaseeName.text = self.leasees[indexPath.row].tenant
        return cell
    }
}















/**
        coppied from Dino Bartosak
        https://www.toptal.com/ios/swift-tutorial-introduction-to-mvvm
 */
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}

struct Leasee: Codable {
    let id: String
    let tenant: String
}
