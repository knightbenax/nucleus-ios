//
//  CustomUIView.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
class CustomUIView: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        // resize your layers based on the view's new frame
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
        let color1 = hexStringToUIColor(hex: "498207").cgColor //UIColor(red: 0.00392157, green: 0.862745, blue: 0.384314, alpha: 1).cgColor
        let color2 = hexStringToUIColor(hex: "FBEA58").cgColor//UIColor(red: 0.0470588, green: 0.486275, blue: 0.839216, alpha: 1).cgColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: self.bounds.height)
        self.layer.insertSublayer(gradientLayer, at: 0)
        //self.layer.addSublayer(gradientLayer)
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.7)
        )
    }
    
    
    func UIColorFromRGB(color: String) -> UIColor {
        return UIColorFromRGB(color: color, alpha: 1.0)
    }
    
    func UIColorFromRGB(color: String, alpha: Double) -> UIColor {
        assert(alpha <= 1.0, "The alpha channel cannot be above 1")
        assert(alpha >= 0, "The alpha channel cannot be below 0")
        var rgbValue : UInt32 = 0
        let scanner = Scanner(string: color)
        scanner.scanLocation = 1
        
        if scanner.scanHexInt32(&rgbValue) {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0xFF) / 255.0
            
            return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
        }
        
        return UIColor.black
    }

    
}

