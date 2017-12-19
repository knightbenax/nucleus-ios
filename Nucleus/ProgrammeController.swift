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
        setProg()
        //getAndTintImage()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var eventsText: UILabel!
    
    func setProg(){
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        let events = UserDefaults.standard.object(forKey: "savedEvents") as? NSArray
        
        if(result == "27.12.2017"){
            
            
            
        } else {
            
            let data = events?.object(at: 0) as! NSDictionary
            
            let content = data.object(forKey: "content") as! NSArray;
            
            for dataObject : Any in content
            {
                if let event_data = dataObject as? NSDictionary
                {
                    
                    let time = event_data.object(forKey: "time") as! String
                    let this_event = event_data.object(forKey: "event") as! String
                    
                    eventsText.text = eventsText.text! + time + "\n" + this_event + "\n\n"
                    
                }
            }
            
        }
        
        
        /*for dataObject : Any in events!
        {
            if let data = dataObject as? NSDictionary
            {
                // Do stuff with data
                let this_data = data.object(forKey: "date") as! String;
                
                if (this_data == "first" && result == "27.12.2017"){
                    
                    let content = data.object(forKey: "content") as! NSArray;
                    
                    for dataObject : Any in content
                    {
                        if let event_data = dataObject as? NSDictionary
                        {
                            
                            let time = event_data.object(forKey: "time") as! String
                            let event = event_data.object(forKey: "event") as! String
                            
                            eventsText.text = time + "\n" + event + "\n\n"
                            
                        }
                    }
                } else {
                    
                    
                   
                    
                }
                
                //print(this_data!);
            }
        }*/
    }
    
}
