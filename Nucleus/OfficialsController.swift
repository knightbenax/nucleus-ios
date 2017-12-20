//
//  OfficialsController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 20/12/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit

class OfficialsController: UIViewController {
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    let officials = UserDefaults.standard.object(forKey: "savedOfficials") as? NSArray
    
    @IBOutlet weak var eventsText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for dataObject : Any in officials!
        {
            if let data = dataObject as? NSDictionary
            {
                
                let title = data.object(forKey: "title") as! String
                let body = data.object(forKey: "body") as! String
                
                eventsText.text = eventsText.text! + title + body + "\n\n"
                
            }
            
        }
        

    }
    
    @IBAction func venueBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "venueView") as! VenueController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func programmeBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "programmeView") as! ProgrammeController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func speakerBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "speakersView") as! SpeakersController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.present(nextController, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
