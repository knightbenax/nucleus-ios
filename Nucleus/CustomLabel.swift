//
//  CustomLabel.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 01/12/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
class CustomLabel: UILabel {
    
    let padding = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 10
        
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 5
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 10
        
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 5
    }

    
}

