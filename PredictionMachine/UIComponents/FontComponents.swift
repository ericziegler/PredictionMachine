//
//  FontComponents.swift
//
//  Created by Eric Ziegler
//

import UIKit

extension UIFont {

    class func appFontOfSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size)!
    }

    class func appMediumFontOfSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size)!
    }

    class func appBoldFontOfSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }

    class func appLightFontOfSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size)!
    }

}
