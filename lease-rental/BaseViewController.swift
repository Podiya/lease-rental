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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hud = PulsateHUD(frame: UIScreen.main.bounds)
        self.view.addSubview(self.hud)
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
}


extension UIImageView {
    func pulsate() {

        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .greatestFiniteMagnitude
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0

        layer.add(pulse, forKey: "pulse")
    }
}

class PulsateHUD: UIView {
    private var effectView: UIVisualEffectView!
    private let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private let logoView = UIImageView(image: UIImage(named: "logo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.effectView = UIVisualEffectView(effect: blurEffect)
        self.isHidden = true
        self.effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(effectView)
        self.bringSubviewToFront(effectView)
        
        self.effectView.contentView.addSubview(logoView)
        
        self.effectView.frame = self.bounds
        logoView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        logoView.center = self.effectView.center
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func showHud() {
        DispatchQueue.main.async {
            self.isHidden = false
            self.logoView.pulsate()
        }
    }
    
    func hideHud() {
        DispatchQueue.main.async {
            self.isHidden = true
        }
    }
}
