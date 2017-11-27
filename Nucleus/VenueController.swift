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
import Mapbox

class VenueController: UIViewController {
    
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    @IBOutlet weak var mapView: MGLMapView!
    
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
    
    func removeAttr(){
        mapView.attributionButton.isHidden = true
    }
    
}
