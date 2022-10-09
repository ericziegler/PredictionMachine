//
//  DateFormatterExtensions.swift
//  RackScan
//
//  Created by Eric Ziegler on 9/13/22.
//

import Foundation

extension DateFormatter {
 
    static var standardDisplayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yy"
        return formatter
    }
    
}
