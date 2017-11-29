//
//  ProgrammeController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 29/11/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit

class ProgrammeController: UIViewController {
    
    @IBOutlet weak var oneBtn: TransView!
    @IBOutlet weak var twoBtn: TransView!
    @IBOutlet weak var threeBtn: TransView!
    @IBOutlet weak var fourBtn: TransView!
    
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    @IBAction func venueBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "venueView") as! VenueController
        self.present(nextController, animated: true, completion: nil)
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.present(nextController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oneBtn.haveFocus()
        twoBtn.loseFocus()
        threeBtn.loseFocus()
        fourBtn.loseFocus()
        //getAndTintImage()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
