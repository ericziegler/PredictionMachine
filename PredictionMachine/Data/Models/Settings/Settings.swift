//
//  Settings.swift
//
//  Created by Eric Ziegler on 9/10/22.
//

import Foundation

// MARK: - Constants

fileprivate let SettingsHapticsOnKey = "SettingsHapticsOnKey"
fileprivate let SettingsInterfaceStyleKey = "SettingsInterfaceStyleKey"

// MARK: - Enums

enum InterfaceStyle: Int {
    case dark
    case light
    case auto
    
    var displayName: String {
        switch self {
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        default:
            return "Auto"
        }
    }
}

class Settings {

    // MARK: - Properties

    var hapticsOn: Bool {
        get {
            let hapticsValue = UserDefaults.standard.object(forKey: SettingsHapticsOnKey) as? NSNumber
            if let hapticsValue = hapticsValue {
                return hapticsValue.boolValue
            } else {
                // first load. default to true
                UserDefaults.standard.set(NSNumber(booleanLiteral: true), forKey: SettingsHapticsOnKey)
                return true
            }
        }
        set {
            UserDefaults.standard.setValue(NSNumber(booleanLiteral: newValue), forKey: SettingsHapticsOnKey)
        }
    }
    
    var selectedInterfaceStyle: InterfaceStyle {
        get {
            let styleValue = UserDefaults.standard.object(forKey: SettingsInterfaceStyleKey) as? NSNumber
            if let styleValue = styleValue, let interfaceStyle = InterfaceStyle(rawValue: styleValue.intValue) {
                return interfaceStyle
            } else {
                // first load. default to dark
                let darkStyle = InterfaceStyle.dark
                UserDefaults.standard.set(NSNumber(integerLiteral: darkStyle.rawValue), forKey: SettingsInterfaceStyleKey)
                UserDefaults.standard.synchronize()
                return darkStyle
            }
        }
        set {
            UserDefaults.standard.setValue(NSNumber(value: newValue.rawValue), forKey: SettingsInterfaceStyleKey)
        }
    }

    // MARK: - Init

    static let shared = Settings()

}
