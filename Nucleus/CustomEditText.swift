//
//  CustomEditText.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 23/11/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
class CustomEditText: UITextField {
    
    let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        // resize your layers based on the view's new frame
        super.layoutSubviews()
        //gradientLayer.frame = self.bounds;
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.bounds.size.height - width, width:  self.bounds.size.width, height: self.bounds.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
  
    }

}
