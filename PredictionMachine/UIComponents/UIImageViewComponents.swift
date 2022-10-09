//
//  UIImageComponents.swift
//
//  Created by Eric Ziegler
//

import UIKit

enum PlaceholderImage {

    case user
    case group

    var image: UIImage? {
        var imageName = ""
        switch self {
        case .user:
            imageName = "UserAvatar"
        case .group:
            imageName = "GroupAvatar"
        }
        return UIImage(named: imageName)
    }

}
