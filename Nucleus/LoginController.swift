//
//  LoginController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signInPanel: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBAction func registerClick(_ sender: Any) {
        
        startPanel.isHidden = true
        registerPanel.isHidden = false
        signInPanel.isHidden = true
        //self.view.endEditing(true)
    }
    
    @IBAction func signInClick(_ sender: Any) {
        startPanel.isHidden = true
        registerPanel.isHidden = true
        signInPanel.isHidden = false
    }
    
    @IBAction func signInBackBtnClick(_ sender: Any) {
        startPanel.isHidden = false
        signInPanel.isHidden = true
        registerPanel.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var regSubmitButton: UIButton!
    @IBOutlet weak var signInSubmitBtn: UIButton!
    
    @IBOutlet weak var registerPanel: UIView!
    
    @IBOutlet weak var startPanel: UIView!

    @IBAction func regBackBtnClick(_ sender: Any) {
        startPanel.isHidden = false
        signInPanel.isHidden = true
        registerPanel.isHidden = true
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerPanel.isHidden = true
        signInPanel.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        setBg()
        setButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func setButtons(){
        registerBtn.layer.shadowColor = UIColor.black.cgColor
        registerBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        registerBtn.layer.shadowRadius = 20
        
        registerBtn.layer.shadowOpacity = 0.3
        registerBtn.layer.cornerRadius = 5
        
        regSubmitButton.layer.shadowColor = UIColor.black.cgColor
        regSubmitButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        regSubmitButton.layer.shadowRadius = 20
        
        regSubmitButton.layer.shadowOpacity = 0.3
        regSubmitButton.layer.cornerRadius = 5
        
        signInSubmitBtn.layer.shadowColor = UIColor.black.cgColor
        signInSubmitBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        signInSubmitBtn.layer.shadowRadius = 20
        
        signInSubmitBtn.layer.shadowOpacity = 0.3
        signInSubmitBtn.layer.cornerRadius = 5
    }
    
    func setBg(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        
        if DeviceType.IS_IPHONE_X {
            backgroundImage.image = UIImage(named: "iPhoneX")
            //print("== ()")
        } else if DeviceType.IS_IPHONE_6P {
            backgroundImage.image = UIImage(named: "iphone_6p")
        } else if DeviceType.IS_IPHONE_6 {
            backgroundImage.image = UIImage(named: "iphone_6")
        } else if DeviceType.IS_IPHONE_5 {
            backgroundImage.image = UIImage(named: "iphone_5")
        } else if DeviceType.IS_IPHONE_4_OR_LESS {
            backgroundImage.image = UIImage(named: "iphone_4")
        }
        
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    enum UIUserInterfaceIdiom : Int
    {
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        //4, 4s and below
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        //covers 5, 5s, 5c, SE
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        //covers 6, 6s, 7, 8
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        //covers 6p, 6sp, 7p, 8p
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    
    
    
}
