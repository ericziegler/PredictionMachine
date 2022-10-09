//
//  UIWindowExtensions.swift
//
//  Created by Eric Ziegler on 7/10/22.
//

import UIKit

extension UIWindow {
 
    static var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.keyWindow?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
    
}
