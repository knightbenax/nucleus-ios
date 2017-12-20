//
//  SpeakersController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 20/12/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
import WebKit

class SpeakersController: UIViewController{
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    
    
    @IBAction func venueBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "venueView") as! VenueController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func progBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "programmeView") as! ProgrammeController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func officialsBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "detailsView") as! OfficialsController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.present(nextController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
