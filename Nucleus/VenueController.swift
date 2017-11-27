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
    
    var latitude: CLLocationDegrees = 6.676057699999999
    var longitude: CLLocationDegrees = 3.1714785000000347
    
    @IBAction func directionClick(_ sender: Any) {
        goToMap()
    }
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
        let camera = GMSCameraPosition.camera(withLatitude: 6.678, longitude: 3.1714785000000347, zoom: 15.5)
        
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
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 6.676057699999999, longitude: 3.1714785000000347)
        //marker.title = "Faith Academy, Canaanland, Ota"
        //marker.snippet = "Venue of CJ 2017"
        marker.icon = UIImage(named: "marker")
        marker.map = mapView
        
        
        mapView.isBuildingsEnabled = true
        mapView.isIndoorEnabled = true
        mapView.isTrafficEnabled = true
        mapView.isMyLocationEnabled = true

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //draw distance from you to Ota
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        let routes = json["routes"] as? [Any]
                        let overview_polyline = routes?[0] as?[String:Any]
                        let polyString = overview_polyline?["points"] as?String
                        
                        //Call this method to draw path on map
                        self.showPath(polyStr: polyString!)
                    }
                    
                }catch{
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.white
        polyline.map = mapView // Your map view
    }
    
}
