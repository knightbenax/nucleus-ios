//
//  RoundedLabel.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 01/12/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedLabel: UILabel {
    
    var edgeInsets: UIEdgeInsets {
        if autoPadding {
            if cornerRadius == 0 {
                return UIEdgeInsets.zero
            } else {
                return UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 4)
            }
        } else {
            return UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        }
    }
    
    @IBInspectable var horizontalPadding: CGFloat = 0
    @IBInspectable var verticalPadding: CGFloat = 0
    @IBInspectable var autoPadding: Bool = true
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        
        let edgeInsets = self.edgeInsets
        size.width += edgeInsets.left + edgeInsets.right
        size.height += edgeInsets.top + edgeInsets.bottom
        
        return size
    }
    
}
