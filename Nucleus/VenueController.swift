//
//  VenueController.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 26/11/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMaps

class VenueController: UIViewController {
    
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
    @IBOutlet weak var mapView: GMSMapView!
    
    func goToMap(){
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.open(NSURL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")! as URL, options: [:], completionHandler: nil)
        } else {
            //NSLog("Can't use comgooglemaps://");
            //let latitude: CLLocationDegrees =  latitude
            //let longitude: CLLocationDegrees = longitude
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "CJ 2017 - Faith Academy, Canaanland, Ota"
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeAttr()
         //AIzaSyArNf1B72BOCukW8C5FI5PgJvMKeMN-KQ0 
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func removeAttr(){
        let camera = GMSCameraPosition.camera(withLatitude: 6.676057699999999, longitude: 3.1714785000000347, zoom: 15.5)
        mapView.camera = camera
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "dark_style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }

        
    }
    
}
