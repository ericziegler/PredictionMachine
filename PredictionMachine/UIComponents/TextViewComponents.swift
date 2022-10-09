//
//  TextViewComponents.swift
//
//  Created by Eric Ziegler
//

import UIKit

// MARK: - StyledTextView

class StyledTextView : UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }

    func commonInit() {
        styleBorderWithColor()
    }

    func styleBorderWithColor(color: UIColor = UIColor(hex: 0xdddddd), cornerRadius: CGFloat = 10, borderWidth: CGFloat = 1.5) {
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
    
}
