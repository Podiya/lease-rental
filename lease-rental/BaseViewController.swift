//
//  BaseViewController.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private let hud = UIView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hud.isHidden = true
        self.hud.backgroundColor = .blue
        self.view.addSubview(hud)
        self.view.bringSubviewToFront(hud)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func showHud() {
        DispatchQueue.main.async {
            self.hud.isHidden = false
        }
    }
    
    func hideHud() {
        DispatchQueue.main.async {
            self.hud.isHidden = true
        }
    }
}
