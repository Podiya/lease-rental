//
//  UIImageViewExtension.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 3/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import UIKit

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
