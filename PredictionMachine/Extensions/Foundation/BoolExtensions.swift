//
//  BoolExtensions.swift
//  RackScan
//
//  Created by Eric Ziegler on 9/8/22.
//

import Foundation

extension Bool {
 
    var stringValue: String {
        return self == true ? "true" : "false"
    }
    
    var intValue: Int {
        return self == true ? 1 : 0
    }
    
}
