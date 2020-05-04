//
//  UITableExtension.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

extension UITableView {
    public func generalSetup(nibName: String, cellReuseIdentifier: String, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableFooterView = UIView()
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    public func addRefreshController(completion: (UIRefreshControl) -> Void) {
        let controller = UIRefreshControl()
        self.addSubview(controller)
        completion(controller)
    }
    
    public func endRefreshing() {
        DispatchQueue.main.async {
            for controller in self.subviews where controller is UIRefreshControl {
                (controller as! UIRefreshControl).endRefreshing()
            }
        }
    }
}

