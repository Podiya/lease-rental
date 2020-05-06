//
//  Dynamic.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 3/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

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
