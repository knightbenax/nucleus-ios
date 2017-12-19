//
//  ViewController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 27/10/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
import Alamofire

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
    
    @IBAction func progBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "programmeView") as! ProgrammeController
        self.present(nextController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        
                        if (statusText == true){
                            //let tribe = JSON.object(forKey: "tribe") as! String!
                            let events = JSON.object(forKey: "events") as! NSArray
                            
                            UserDefaults.standard.set(events, forKey: "savedEvents")
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

