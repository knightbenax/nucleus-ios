//
//  LoginController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
import Alamofire
import ImagePicker

class LoginController: UIViewController, UITextFieldDelegate, ImagePickerDelegate {
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        avatarImage = images[0]
        
        let imageData:NSData = UIImagePNGRepresentation(avatarImage)! as NSData
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.present(nextController, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        avatarImage = images[0]
        
        let imageData:NSData = UIImagePNGRepresentation(avatarImage)! as NSData
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.present(nextController, animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
       imagePicker.dismiss(animated: true, completion: nil)
    }
    
    var avatarImage : UIImage!
    
    @IBOutlet weak var chooseButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signInPanel: UIView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var avatarPanel: UIView!
    
    @IBOutlet weak var surnameText: CustomEditText!
    @IBOutlet weak var genderText: CustomEditText!
    @IBOutlet weak var phoneText: CustomEditText!
    @IBOutlet weak var emailText: CustomEditText!
    @IBOutlet weak var hearText: CustomEditText!
    @IBOutlet weak var careerText: CustomEditText!
    @IBOutlet weak var firstTimeText: CustomEditText!
    
    @IBAction func chooseBtnClick(_ sender: Any) {
        selectImage()
    }
    
    @IBAction func regSubmitButtonClick(_ sender: Any) {
    
        registerParticipant()
    
    }
    
    @IBAction func signSubmitButtonClick(_ sender: Any) {
     
        signInParticipant()
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
        avatarPanel.isHidden = true
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
    
    @IBOutlet weak var emailSignText: CustomEditText!
    
    
    func signInParticipant(){
        
        if(emailSignText.text == ""){
            
            let alert = UIAlertController(title: "Field empty", message: "You haven't filled out your email yet. Expecting magic?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
        } else {
            
            self.signInPanel.isHidden = true
            self.view.endEditing(true)
            
            let spinner = ALThreeCircleSpinner(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            
            spinner.tintColor = UIColor.white
            spinner.hidesWhenStopped = false
            
            view.addSubview(spinner)
            
            spinner.center = view.center
            spinner.startAnimating()
            
            let parameters: Parameters = [
                 "email": emailSignText.text!
            ]
            
            Alamofire.request("http://campjoseph.ydiworld.org/api/register/participant", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        spinner.removeFromSuperview()
                        
                        if let result = response.result.value {
                            let JSON = result as! NSDictionary
                            let statusText: Bool = JSON.object(forKey: "success")! as! Bool
                            
                            print(JSON)
                            
                            if (statusText == true){
                                //let tribe = JSON.object(forKey: "tribe") as! String!
                                let participant = JSON.object(forKey: "participant") as! NSDictionary
                                let events = JSON.object(forKey: "events") as! NSArray
                                let officials = JSON.object(forKey: "officials") as! NSArray
                                
                                let name = participant.object(forKey: "Fullname")! as! String
                                let id = participant.object(forKey: "ID")! as! Int
                                let tribe = participant.object(forKey: "Tribe")! as! String
                                let career = participant.object(forKey: "Career")! as! String
                                let email = participant.object(forKey: "Email")! as! String
                                let phone = participant.object(forKey: "Phone")! as! String
                                let gender = participant.object(forKey: "Gender")! as! String
                                let hear = participant.object(forKey: "Hear about Camp")! as! String
                                let first = participant.object(forKey: "First time at Camp")! as! String
                                //print(name)
                                
                                UserDefaults.standard.set(name, forKey: "savedName")
                                UserDefaults.standard.set(id, forKey: "savedID")
                                UserDefaults.standard.set(tribe, forKey: "savedTribe")
                                UserDefaults.standard.set(career, forKey: "savedCareer")
                                UserDefaults.standard.set(email, forKey: "savedEmail")
                                UserDefaults.standard.set(phone, forKey: "savedPhone")
                                UserDefaults.standard.set(gender, forKey: "savedGender")
                                UserDefaults.standard.set(hear, forKey: "savedHear")
                                UserDefaults.standard.set(first, forKey: "savedFirst")
                                UserDefaults.standard.set(events, forKey: "savedEvents")
                                UserDefaults.standard.set(officials, forKey: "savedOfficials")
                                
                                self.avatarPanel.isHidden = false
                                
                                //UserDefaults.standard.set(tribe, forKey: "savedTribe")
                                //UserDefaults.standard.set(self.firstTimeText.text, forKey: "savedFirst")
                            } else if (statusText == false){
                                
                                let reason = JSON.object(forKey: "reason")! as! String
                                
                                if (reason == "no exist"){
                                    
                                    let alert = UIAlertController(title: "Account not found", message: "No registration data was found with this email.", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                    
                                    self.present(alert, animated: true)
                                    
                                    self.signInPanel.isHidden = false
                                }
                                
                            }
                            
                        }
                        //print("Data: \(String(describing: utf8Text))")
                    //print("example success")
                    default:
                        spinner.removeFromSuperview()
                        
                        print("error with response status: \(status)")
                    }
                    
                }
            }
            
        }
        
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
            self.view.endEditing(true)
            
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
            
            Alamofire.request("http://campjoseph.ydiworld.org/api/register/new", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                //print("Request: \(response.request)")
                //print("Response: \(response.response)")
                //print("Error: \(response.error)")
                
                if let status = response.response?.statusCode {
                    switch(status){
                    case 200:
                        spinner.removeFromSuperview()
                        
                        if let result = response.result.value {
                            let JSON = result as! NSDictionary
                            let statusText: Bool = JSON.object(forKey: "success")! as! Bool
                            
                            print(JSON)
                            
                            if (statusText == true){
                                let id = JSON.object(forKey: "last_insert_id") as! Int!
                                let tribe = JSON.object(forKey: "tribe") as! String!
                                let events = JSON.object(forKey: "events") as! NSArray
                                let officials = JSON.object(forKey: "officials") as! NSArray
                                
                                self.avatarPanel.isHidden = false
                                
                                UserDefaults.standard.set(self.surnameText.text, forKey: "savedName")
                                UserDefaults.standard.set(id, forKey: "savedID")
                                UserDefaults.standard.set(tribe, forKey: "savedTribe")
                                UserDefaults.standard.set(self.careerText.text, forKey: "savedCareer")
                                UserDefaults.standard.set(self.emailText.text, forKey: "savedEmail")
                                UserDefaults.standard.set(self.phoneText.text, forKey: "savedPhone")
                                UserDefaults.standard.set(self.genderText.text, forKey: "savedGender")
                                UserDefaults.standard.set(self.hearText.text, forKey: "savedHear")
                                UserDefaults.standard.set(self.firstTimeText.text, forKey: "savedFirst")
                                UserDefaults.standard.set(events, forKey: "savedEvents")
                                UserDefaults.standard.set(officials, forKey: "savedOfficials")
                                //UserDefaults.standard.set(self.firstTimeText.text, forKey: "savedFirst")
                            } else if (statusText == false){
                                
                                let reason = JSON.object(forKey: "reason")! as! String
                                
                                if (reason == "exists"){
                                    
                                    let alert = UIAlertController(title: "Account exists", message: "This email has already been registered for this event. Sign in with this email or use another email.", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                    
                                    self.present(alert, animated: true)
                                    
                                    self.registerPanel.isHidden = false
                                }
                                
                            }
                            
                        }
                        //print("Data: \(String(describing: utf8Text))")
                        //print("example success")
                    default:
                        spinner.removeFromSuperview()
                        
                        print("error with response status: \(status)")
                    }
                }
                
                
                /*if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }*/
            }
            
        }
    }
    
    func selectImage(){
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func setButtons(){
        chooseButton.layer.shadowColor = UIColor.black.cgColor
        chooseButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        chooseButton.layer.shadowRadius = 20
        
        chooseButton.layer.shadowOpacity = 0.3
        chooseButton.layer.cornerRadius = 5
        
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
