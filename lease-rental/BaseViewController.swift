//
//  BaseViewController.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    private var hud: PulsateHUD!
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private let logoView = UIImageView(image: UIImage(named: "logo"))
    private let alert = FloatingAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hud = PulsateHUD(frame: UIScreen.main.bounds)
        self.view.addSubview(self.hud)
        self.view.addSubview(alert)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupHUD() {
    }
    
    func showHud() {
        hud.showHud()
    }
    
    func hideHud() {
        hud.hideHud()
    }
    
    func showAlert(text: String, type: FloatingAlertType) {
        alert.show(text: text, type: type)
    }
}





