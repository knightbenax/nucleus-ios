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
import UberRides

class VenueController: UIViewController,  CLLocationManagerDelegate {
    
    var latitude: CLLocationDegrees = 6.676057699999999
    var longitude: CLLocationDegrees = 3.1714785000000347
    
    @IBOutlet weak var uberBtn: UIButton!
    let button = RideRequestButton()
    
    @IBAction func uberBtnClick(_ sender: Any) {
        button.sendActions(for: .touchUpInside)
    }
    
    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    
    @IBOutlet weak var directionsBtn: UIButton!
    
    @IBAction func directionClick(_ sender: Any) {
        goToMap()
    }
    
    @IBAction func officialsBtn(_ sender: Any) {
    
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "detailsView") as! OfficialsController
        self.present(nextController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func progBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "programmeView") as! ProgrammeController
        self.present(nextController, animated: true, completion: nil)
    }
    
    
    @IBAction func speakersBtn(_ sender: Any) {
        
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "speakersView") as! SpeakersController
        self.present(nextController, animated: true, completion: nil)
        
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        let nextController = mainStoryBoard.instantiateViewController(withIdentifier: "profileView") as! ProfileController
        self.present(nextController, animated: true, completion: nil)
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
        setButtons()
        
        let dropoffLocation = CLLocation(latitude: latitude, longitude: longitude)
        let builder = RideParametersBuilder()
        builder.dropoffLocation = dropoffLocation
        builder.dropoffNickname = "CJ 2017 - Faith Academy, Canaanland, Ota"
        
        button.rideParameters = builder.build()
        button.center = view.center
        button.isHidden = true
        //put the button in the view
        view.addSubview(button)
        
        //uberBtn.rideParameters = builder.build()
        //determineMyCurrentLocation()
         //AIzaSyArNf1B72BOCukW8C5FI5PgJvMKeMN-KQ0 
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setButtons(){
        uberBtn.layer.shadowColor = UIColor.black.cgColor
        uberBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        uberBtn.layer.shadowRadius = 20
        
        uberBtn.layer.shadowOpacity = 0.3
        uberBtn.layer.cornerRadius = 5
        
        directionsBtn.layer.shadowColor = UIColor.black.cgColor
        directionsBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        directionsBtn.layer.shadowRadius = 20
        
        directionsBtn.layer.shadowOpacity = 0.3
        directionsBtn.layer.cornerRadius = 5
    
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
    
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    func determineMyCurrentLocation() {
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
        
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        currentLocation = userLocation
        locManager.stopUpdatingLocation()
        latitude = currentLocation.coordinate.latitude
        longitude = currentLocation.coordinate.longitude
        
        getPolylineRoute(from: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), to: CLLocationCoordinate2D(latitude: 6.676057699999999, longitude: 3.1714785000000347))
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        //print("user latitude = \(userLocation.coordinate.latitude)")
        //print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
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
