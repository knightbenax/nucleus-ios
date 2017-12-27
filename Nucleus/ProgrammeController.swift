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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    let events = UserDefaults.standard.object(forKey: "savedEvents") as? NSArray

    @IBAction func venueBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "venueView") as! VenueController
        self.present(nextController, animated: true, completion: nil)
    }
 
    @IBAction func officialsBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "detailsView") as! OfficialsController
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*oneBtn.haveFocus()
        twoBtn.loseFocus()
        threeBtn.loseFocus()
        fourBtn.loseFocus()*/
        
        // or for swift 2 +
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        oneBtn.addGestureRecognizer(gesture)
        
        let gestureTwo = UITapGestureRecognizer(target: self, action:  #selector (self.someActionTwo (_:)))
        twoBtn.addGestureRecognizer(gestureTwo)
        
        let gestureThree = UITapGestureRecognizer(target: self, action:  #selector (self.someActionThree (_:)))
        threeBtn.addGestureRecognizer(gestureThree)
        
        let gestureFour = UITapGestureRecognizer(target: self, action:  #selector (self.someActionFour (_:)))
        fourBtn.addGestureRecognizer(gestureFour)
        
        setProg()
        //getAndTintImage()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        // do other task
        oneBtn.haveFocus()
        twoBtn.loseFocus()
        threeBtn.loseFocus()
        fourBtn.loseFocus()
        
        eventsText.text = ""
        
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
    
    @objc func someActionTwo(_ sender:UITapGestureRecognizer){
        // do other task
        oneBtn.loseFocus()
        twoBtn.haveFocus()
        threeBtn.loseFocus()
        fourBtn.loseFocus()
        
        eventsText.text = ""
        
        let data = events?.object(at: 1) as! NSDictionary
        
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
    
    @objc func someActionThree(_ sender:UITapGestureRecognizer){
        // do other task
        oneBtn.loseFocus()
        twoBtn.loseFocus()
        threeBtn.haveFocus()
        fourBtn.loseFocus()
        
        eventsText.text = ""
        
        let data = events?.object(at: 2) as! NSDictionary
        
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
    
    @objc func someActionFour(_ sender:UITapGestureRecognizer){
        // do other task
        oneBtn.loseFocus()
        twoBtn.loseFocus()
        threeBtn.loseFocus()
        fourBtn.haveFocus()
        
        eventsText.text = ""
        
        let data = events?.object(at: 3) as! NSDictionary
        
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
    
    @IBOutlet weak var eventsText: UILabel!
    
    func setProg(){
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        if(result == "27.12.2017"){
            
            oneBtn.haveFocus()
            twoBtn.loseFocus()
            threeBtn.loseFocus()
            fourBtn.loseFocus()
            
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
            
        } else if (result == "28.12.2017"){
            
            oneBtn.loseFocus()
            twoBtn.haveFocus()
            threeBtn.loseFocus()
            fourBtn.loseFocus()
            
            let data = events?.object(at: 1) as! NSDictionary
            
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
            
        } else if (result == "29.12.2017"){
            
            oneBtn.loseFocus()
            twoBtn.loseFocus()
            threeBtn.haveFocus()
            fourBtn.loseFocus()
            
            scrollView.scrollToView(view: threeBtn, animated: true)
            
            let data = events?.object(at: 2) as! NSDictionary
            
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
            
        } else if (result == "30.12.2017"){
            
            oneBtn.loseFocus()
            twoBtn.loseFocus()
            threeBtn.loseFocus()
            fourBtn.haveFocus()
            
            scrollView.scrollToView(view: threeBtn, animated: true)
            
            let data = events?.object(at: 3) as! NSDictionary
            
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
            
        } else {
            
            
            
            oneBtn.haveFocus()
            twoBtn.loseFocus()
            threeBtn.loseFocus()
            fourBtn.loseFocus()
            
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
