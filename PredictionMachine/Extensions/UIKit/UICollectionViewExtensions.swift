//
//  UICollectionViewExtensions.swift
//
//  Created by Eric Ziegler on 10/1/21.
//

import UIKit

extension UICollectionView {
 
    func displayEmptyMessage(message: String, font: UIFont, color: UIColor) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = color
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = font
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func removeEmptyState() {
        self.backgroundView = nil
    }
    
}
