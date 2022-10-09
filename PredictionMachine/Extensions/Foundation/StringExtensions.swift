//
//  StringExtensions.swift
//
//  Created by Eric Ziegler
//

import UIKit

extension String {

    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }

        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }

        return String(self[substringStartIndex ..< substringEndIndex])
    }

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    var containsLetter: Bool {
        let regEx = ".*[a-zA-Z].*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    var containsNumber: Bool {
        let regEx = ".*[0-9].*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }

    func stringAtIndex(index: Int) -> String? {
        if index < 0 || index >= self.count {
            return nil
        }

        let char = self[index]
        return String(char)
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var isNumber: Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^[0-9]*\\.?[0-9]*$")
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    var colorValue: UIColor {
        if self == "clear" {
            return UIColor.clear
        }
        
        var cString: String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var int = UInt64()
        Scanner(string: cString).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch cString.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        let color = UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        return color
    }

}

extension Optional where Wrapped == String {

    func isEmptyOrNil(_ trimType: CharacterSet?) -> Bool {
        if var string = self {
            if let trimType = trimType {
                string = string.trimmingCharacters(in: trimType)
            }
            return string.isEmpty
        } else {
            return true
        }
    }

}

// MARK: - StringProtocol

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
