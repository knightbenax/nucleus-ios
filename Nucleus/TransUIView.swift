//
//  TransUIView.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 29/11/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
class TransView: UIView {
    
    override func layoutSubviews() {
        // resize your layers based on the view's new frame
        super.layoutSubviews()
        //self.layer.addSublayer(gradientLayer)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 20
        
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 5
        
    }
    
    func haveFocus(){
        self.layer.backgroundColor? = UIColor(white: 1, alpha: 1).cgColor
    }
    
    func loseFocus(){
        self.layer.backgroundColor? = UIColor(white: 1, alpha: 0.5).cgColor
    }
    
}
