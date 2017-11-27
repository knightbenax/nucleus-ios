//
//  ViewController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    let gradientLayer = CAGradientLayer()

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var mainParent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAndTintImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            alpha: CGFloat(1.0)
        )
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func getAndTintImage(){
        let bgImage = UIImage(named: "deinere")
        
        let firstColor = hexStringToUIColor(hex: "498207")
        let secondColor = hexStringToUIColor(hex: "FBEA58")
        
        let colorArray = [firstColor.cgColor, secondColor.cgColor]
        
        let newBgImage = bgImage?.tintedWithLinearGradientColors(colorsArr: colorArray)
        
        self.bgImage.image = newBgImage;
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

