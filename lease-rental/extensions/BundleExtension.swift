//
//  BundleExtension.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

/**
    This is directly coppied from
    https://basememara.com/reading-values-plist-bundle-swift/
 */

extension Bundle {
    
    /**
     Gets the contents of the specified plist file.
     
     - parameter plistName: property list where defaults are declared
     - parameter bundle: bundle where defaults reside
     
     - returns: dictionary of values
     */
    static func contentsOfFile(plistName: String, bundle: Bundle? = nil) -> [String : AnyObject] {
        let fileParts = plistName.components(separatedBy: ".")
        
        guard fileParts.count == 2,
            let resourcePath = (bundle ?? Bundle.main).path(forResource: fileParts[0], ofType: fileParts[1]),
            let contents = NSDictionary(contentsOfFile: resourcePath) as? [String : AnyObject]
            else { return [:] }
        
        return contents
    }
    
}
