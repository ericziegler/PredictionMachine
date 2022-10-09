//
//  AppUtilities.swift
//
//  Created by Eric Ziegler on 3/26/22.
//

import UIKit
import AudioToolbox

// MARK: - Errors

enum AppError: LocalizedError {
    case scheduleLoad
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .scheduleLoad:
            return "Failed to load schedule."
        case .unknown:
            return "An unknown error as occurred."
        }
    }
}

// MARK: - Notifications

extension Notification.Name {
    static let userInterfaceStyleChanged = Notification.Name("userInterfaceStyleChanged")
    static let userLoggedIn = Notification.Name("userLoggedIn")
    static let userLoggedOut = Notification.Name("userLoggedOut")
    static let authenticationFailed = Notification.Name("authenticationFailed")
    static let metadataLoaded = Notification.Name("metadataLoaded")
}

// MARK: - App Versions

var appVersion: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

var appBuild: String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}

// MARK: Global UI Properties

func applyGlobalNavigationProperties() {
    UINavigationBar.appearance().tintColor = UIColor.tintColor
}

func navTitleTextAttributes(for traitCollection: UITraitCollection) -> [NSAttributedString.Key : Any] {
    return [NSAttributedString.Key.font : UIFont.appMediumFontOfSize(20), .foregroundColor : UIColor.label]
}

// MARK: - Haptics

func playHaptic() {
    AudioServicesPlaySystemSound(1519)
}
