//
//  ViewController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
import Alamofire
import PopupDialog

class ProfileController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var associateLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var firstHeardLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    
    var avatarImage: UIImage!
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var mainParent: UIView!
    
    @IBAction func locationBtn(_ sender: Any) {
        //let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "venueView") as! VenueController
        //self.navigationController?.pushViewController(nextController, animated: false)
        //self.dismiss(animated: false)
        
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "venueView") as! VenueController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var checkInBtn: UIButton!
    var alert_gee: UIAlertController!
    
    @IBAction func checkInBtnClick(_ sender: Any) {
        
        let popup = PopupDialog(title: "Are you sure?", message: "You are about to check in and mark yourself as arrived at Camp Joseph 2017.  After this you can proceed to collect your Welcome Pack.", gestureDismissal: true)
        
        let buttonTwo = DefaultButton(title: "Check In") {
            //self.label.text = "What a beauty!"
            popup.dismiss()
            self.alert_gee = self.displaySignUpPendingAlert()
        }
        
        let buttonOne = DefaultButton(title: "Not Yet") {
            //self.label.text = "What a beauty!"
            
        }
        
        popup.addButtons([buttonTwo, buttonOne])
        
        let pc = PopupDialogDefaultView.appearance();
        pc.backgroundColor = hexStringToUIColor(hex: "769700")
        pc.titleFont = UIFont.init(name: "Cabin-SemiBold", size: 18)!
        pc.titleColor = UIColor.white
        pc.messageFont = UIFont.init(name: "Cabin-Regular", size: 16)!
        pc.messageColor = UIColor.white
        
        let db = DefaultButton.appearance()
        db.titleFont = UIFont.init(name: "Cabin-SemiBold", size: 18)!
        db.titleColor = UIColor.black
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var ticketImage: UIImageView!
    
    @IBAction func progBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "programmeView") as! ProgrammeController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func offici(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "detailsView") as! OfficialsController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func speakerBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "speakersView") as! SpeakersController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var checkInTop: NSLayoutConstraint!
    
    @IBOutlet weak var checkInHeight: NSLayoutConstraint!
    
    func displaySignUpPendingAlert() -> UIAlertController {
        //create an alert controller
        let pending = UIAlertController(title: "Marking As Arrived", message: nil, preferredStyle: .alert)
        
        let spinner = ALThreeCircleSpinner(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        spinner.tintColor = UIColor.white
        spinner.hidesWhenStopped = false
        
        
        //pending.view.addSubview(spinner)
        
        spinner.center = pending.view.center
        spinner.startAnimating()
        
        let id = UserDefaults.standard.object(forKey: "savedID") as? Int
        
        let parameters: Parameters = [
            "id": id!
        ]
        
        //add the activity indicator as a subview of the alert controller's view
        Alamofire.request("http://campjoseph.ydiworld.org/api/register/markasarrived", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        let statusText: Bool = JSON.object(forKey: "success")! as! Bool
                        
                        //print(JSON)
                        
                        if (statusText == true){
                            //let tribe = JSON.object(forKey: "tribe") as! String!
                            let saved = "Yes"
                            UserDefaults.standard.set(saved, forKey: "savedArrival")
                            self.alert_gee.dismiss(animated: true, completion: nil)
                            
                            self.checkInBtn.isHidden = true
                            self.checkInTop.constant = 0
                            self.checkInHeight.constant = 0
                            let ticket = UIImage(named: "ticket_admitted")
                            self.ticketImage.image = ticket
                            
                            
                        }
                    }
                default:
                    print("error with response status: \(status)")
                }
                
            }
            
        }

        
        self.present(pending, animated: true, completion: nil)
        
        return pending
    }
    
    func setButtons(){
        checkInBtn.layer.shadowColor = UIColor.black.cgColor
        checkInBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        checkInBtn.layer.shadowRadius = 10
        
        checkInBtn.layer.shadowOpacity = 0.6
        checkInBtn.layer.cornerRadius = 5
        
    }
    
    
    func checkBtnToShow(){
        
        let date = Date()
        let year = DateFormatter()
        let month = DateFormatter()
        let day = DateFormatter()
        
        year.dateFormat = "yyyy"
        month.dateFormat = "MM"
        day.dateFormat = "dd"
        
        let yearResult = year.string(from: date)
        let monthResult = month.string(from: date)
        let dayResult = day.string(from: date)
        
        if (yearResult == "2017"){
            
            if (monthResult == "12"){
                
                if (dayResult == "27" || dayResult == "28" || dayResult == "29" || dayResult == "30"){
                    
                    if (UserDefaults.standard.object(forKey: "savedArrival") == nil){
                        
                        //user hasn't arrived
                        checkInBtn.isHidden = false
                        let ticket = UIImage(named: "ticket")
                        checkInTop.constant = 30
                        checkInHeight.constant = 48
                        ticketImage.image = ticket
                        
                    } else {
                        
                        //this means that the user has already arrived
                        checkInBtn.isHidden = true
                        checkInTop.constant = 0
                        checkInHeight.constant = 0
                        let ticket = UIImage(named: "ticket_admitted")
                        
                         ticketImage.image = ticket
                    }
                    
                } else {
                    checkInBtn.isHidden = true
                    checkInTop.constant = 0
                    checkInHeight.constant = 0
                    //checkInBtn.frame.height = 0
                }
                
            } else {
                checkInBtn.isHidden = true
                checkInTop.constant = 0
                checkInHeight.constant = 0
                //checkInBtn.frame.height = 0
            }
            
        } else {
            checkInBtn.isHidden = true
            checkInTop.constant = 0
            checkInHeight.constant = 0
            //checkInBtn.frame.height = 0
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
        
        checkBtnToShow()
        
        let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData
        avatarImage = UIImage(data: data as Data)
        
        var nameText = UserDefaults.standard.object(forKey: "savedName") as? String
        
        nameText = nameText?.capitalized
        
        nameLabel.text = nameText
        
        let associateText = UserDefaults.standard.object(forKey: "savedCareer") as? String
        
        var genderText =  UserDefaults.standard.object(forKey: "savedGender") as? String
        
        genderText = "(" + (genderText?.capitalizingFirstLetter())! + ")"
        
        let phoneText = UserDefaults.standard.object(forKey: "savedPhone") as? String
        let tribe = UserDefaults.standard.object(forKey: "savedTribe") as? String
        let emailText = UserDefaults.standard.object(forKey: "savedEmail") as? String
        
        var hearText = UserDefaults.standard.object(forKey: "savedHear") as? String
        var firstText = UserDefaults.standard.object(forKey: "savedFirst") as? String
        
        contactLabel.text = phoneText! + "\n" + emailText! + "\nTribe: " + tribe!
        associateLabel.text = associateText! + " - " + genderText!
        
        hearText = hearText?.capitalizingFirstLetter()
        firstText = firstText?.capitalizingFirstLetter()
        
        firstHeardLabel.text = "How did you first hear about Camp Joseph: "  + hearText!
        firstTimeLabel.text = "First time at Camp Joseph: " + firstText!
        
        getAndTintImage()
        
        Alamofire.request("http://campjoseph.ydiworld.org/api/register/details", method: .post, encoding: JSONEncoding.default).responseJSON { response in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        let statusText: Bool = JSON.object(forKey: "success")! as! Bool
                        
                        //print(JSON)
                        
                        if (statusText == true){
                            //let tribe = JSON.object(forKey: "tribe") as! String!
                            let events = JSON.object(forKey: "events") as! NSArray
                            let officials = JSON.object(forKey: "officials") as! NSArray
                            
                            UserDefaults.standard.set(events, forKey: "savedEvents")
                            UserDefaults.standard.set(officials, forKey: "savedOfficials")
                        }
                    }
                default:
                    print("error with response status: \(status)")
                }
                
            }
            
        }
        
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
        let bgImage = avatarImage //UIImage(named: "deinere")
        
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

