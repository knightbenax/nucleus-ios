//
//  LoginController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
import Alamofire
import MKRingProgressView

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signInPanel: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var surnameText: CustomEditText!
    @IBOutlet weak var genderText: CustomEditText!
    @IBOutlet weak var phoneText: CustomEditText!
    @IBOutlet weak var emailText: CustomEditText!
    @IBOutlet weak var hearText: CustomEditText!
    @IBOutlet weak var careerText: CustomEditText!
    @IBOutlet weak var firstTimeText: CustomEditText!
    
    @IBAction func regSubmitButtonClick(_ sender: Any) {
    
        registerParticipant()
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    let this_headers: HTTPHeaders = [
        //"Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        //"Accept": "application/json"
        "TOK": "blah"
    ]
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
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
        
        surnameText.delegate = self
        surnameText.tag = 1
        
        genderText.delegate = self
        genderText.tag = 2
        
        phoneText.delegate = self
        phoneText.tag = 3
        
        emailText.delegate = self
        emailText.tag = 4
        
        hearText.delegate = self
        hearText.tag = 5
        
        careerText.delegate = self
        careerText.tag = 6
        
        firstTimeText.delegate = self
        firstTimeText.tag = 7
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func registerParticipant(){
        if (surnameText.text == ""){
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out your name yet.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if (genderText.text == "") {
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out your gender yet. Hope all is well?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        } else if (phoneText.text == ""){
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out your phone number.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if (emailText.text == ""){
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out your email yet.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if (hearText.text == ""){
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out how you heard about Camp Joseph.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if (careerText.text == ""){
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out what you do for a living.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else if (firstTimeText.text == ""){
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out if this is your first time.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        
        } else {
            
            registerPanel.isHidden = true
            
            let spinner = ALThreeCircleSpinner(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            
            spinner.tintColor = UIColor.white
            spinner.hidesWhenStopped = false
            
            
            view.addSubview(spinner)
            
            spinner.center = view.center
            spinner.startAnimating()
            
            let _: HTTPHeaders = [
                "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                "Accept": "application/json"
            ]
            
            //self.appDelegate.api_url
            //let rating_int = Int64(ratingVC.cosmosStarRating.rating)
            //let comment = ""
            
            let parameters: Parameters = [
                "name": surnameText.text!, "phone" : phoneText.text!, "email": emailText.text!, "hear" : hearText.text!, "career" : careerText.text!, "first" : firstTimeText.text!, "gender" : genderText.text!
            ]
            
            Alamofire.request("http://campjoseph.ydiworld.org/register/new", method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
                //print("Request: \(response.request)")
                //print("Response: \(response.response)")
                //print("Error: \(response.error)")
                
                let data = response.data
                let utf8Text = String(data: data!, encoding: .utf8)
                
                print("Data: \(String(describing: utf8Text))")
                
                /*if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }*/
            }
            
        }
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
