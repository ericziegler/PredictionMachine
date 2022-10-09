//
//  NumberFormatterExtensions.swift
//  RackScan
//
//  Created by Eric Ziegler on 9/13/22.
//

import Foundation

extension NumberFormatter {
 
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter
    }
    
}
