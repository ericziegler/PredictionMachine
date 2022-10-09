//
//  NumberInputViewModel.swift
//
//  Created by Eric Ziegler on 9/13/22.
//

import Foundation

class NumberInputViewModel {
 
    // MARK: - Properties
    
    private let formatter = NumberFormatter()
    var number: NSNumber?
    var numberAsText: String? {
        guard let number = number else {
            return nil
        }
        return formatter.string(from: number)
    }
    var placeholder: String?
    var isDecimal: Bool
    var isCurrency: Bool
    
    init(number: NSNumber? = nil, placeholder: String? = nil, isDecimal: Bool = true, isCurrency: Bool = false) {
        self.number = number
        self.placeholder = placeholder
        self.isDecimal = isDecimal
        self.isCurrency = isCurrency
        setupNumberFormatter()
    }
    
    private func setupNumberFormatter() {
        if isCurrency || isDecimal {
            formatter.numberStyle = .decimal
            if isCurrency {
                formatter.maximumFractionDigits = 2
                formatter.minimumFractionDigits = 2
            } else {
                formatter.minimumFractionDigits = 1
            }
        } else {
            formatter.numberStyle = .none
        }
    }
    
    // MARK: - Validation
    
    func textToNumber(_ text: String?) -> NSNumber? {
        if text.isEmptyOrNil(.whitespaces) || text?.isNumber == false {
            return nil
        }
        
        let textAsDouble = Double(text!)!
        return NSNumber(value: textAsDouble)
    }
    
    func changesMade(curText: String?) -> Bool {
        guard let textNumber = textToNumber(curText) else {
            return false
        }
        
        return textNumber.doubleValue != number?.doubleValue
    }
    
    func checkValidInput(text: String?) -> Bool {
        // allow nil or empty value
        if text.isEmptyOrNil(.whitespaces) == true {
            return true
        }

        // force unwrap because we checked nil above
        return text!.isNumber
    }
    
}
