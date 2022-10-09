//
//  DataExtensions.swift
//
//  Created by Eric Ziegler on 9/28/21.
//

import Foundation

extension Data {
   
    mutating func appendString(string: String) {
        guard let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) else {
            return
        }
        self.append(data)
    }
    
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
    
}
