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

class VenueController: UIViewController {
    
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
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
    
}
