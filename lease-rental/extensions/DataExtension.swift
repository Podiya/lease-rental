//
//  DataExtension.swift
//  lease-rental
//
//  Created by Ravindu Senevirathna on 1/5/20.
//  Copyright © 2020 MIHCM. All rights reserved.
//

import Foundation

extension Data {
    public var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
    
    public func responseDataDebug(url: URL?, statusCode: Int) {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
        print(url ?? "No URL")
        if let jsonString = self.prettyPrintedJSONString {
            print(jsonString)
        } else {
            print(String(data: self, encoding: .utf8)!)
        }
        print("\(statusCode)")
        print("==============================================")
    }
    
    public var base64En: String {
        return self.base64EncodedString()
    }
    
    public var base76En: String {
        return self.base64EncodedString(options: Data.Base64EncodingOptions.lineLength76Characters)
    }
}
