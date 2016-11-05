//
//  MapVC.swift
//  GrizCrimeApp
//
//  Created by KENNETH GRANDBERRY on 9/21/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate, UICollectionViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var darkbackground: UIView!
    

    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    var geoFire:GeoFire!
    var geoFireRef: FIRDatabaseReference!
    
    var crimeImages = ["Auto-theif.png","Assalt.png","Vandalism.png","Shooting.png","Shoplifting.png","Burgulary.png"]
    var crimeNames = ["Auto-theif","Assalt", "Vandalism", "Shooting", "Shoplifting","Burgulary"]
    var smallAnnotationImages = ["smallCar.png","smallFist.png","smallSpray.png","smallTarget.png","smallGrocery.png",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        geoFireRef = FIRDatabase.database().reference()
        geoFire = GeoFire(firebaseRef:geoFireRef)
        collectionView.layer.cornerRadius = 5.0
    
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }

    func centerMapOnLocation(location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            if !mapHasCenteredOnce {
                centerMapOnLocation(loc)
                mapHasCenteredOnce = true
            }
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        let annoIdentifier = "Crime"
        
        if let deqAnno = mapView.dequeueReusableAnnotationViewWithIdentifier(annoIdentifier) {
            annotationView = deqAnno
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView, let anno = annotation as? CrimeAnnotation {
            annotationView.canShowCallout = true
            
            if anno.crimeName == "Auto-theif" {
                annotationView.image = UIImage(named: "smallCar.png")
            } else if anno.crimeName == "Assalt" {
                annotationView.image = UIImage(named: "smallFist.png")
            } else if anno.crimeName == "Vandalism" {
                annotationView.image = UIImage(named: "smallSpray.png")
            } else if anno.crimeName == "Shooting" {
                annotationView.image = UIImage(named: "smallTarget.png")
            } else if anno.crimeName == "Shoplifting" {
                annotationView.image = UIImage(named: "smallGrocery.png")
            } else {
                annotationView.image = UIImage(named: "smallTheif.png")
            }
            
            let btn = UIButton()
            btn.frame = CGRect(x:0, y:0, width: 33, height: 32)
            btn.setImage(UIImage(named:"map"), forState: .Normal)
            annotationView.rightCalloutAccessoryView = btn
        }
        return annotationView
    }
    
    func createSighting(forLocation location: CLLocation, withCrimeType crimeName:String) {
        geoFire.setLocation(location, forKey: crimeName)
    }
    
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        showSittingOnMap(loc)
    }
    
    func showSittingOnMap(location:CLLocation) {
        let circleQuery = geoFire!.queryAtLocation(location, withRadius: 2.5)
       _ = circleQuery?.observeEventType(GFEventType.KeyEntered, withBlock: { (key, location) in
            if let key = key, let location = location {
                let anno = CrimeAnnotation(coordinate: location.coordinate, crimeName: key)
                self.mapView.addAnnotation(anno)
            }
       })
    
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let anno = view.annotation as? CrimeAnnotation {
  
        }
    }
    
    @IBAction func spottedCrime(_sender:UIButton) {
        //Get the name of the crime to create a sighting
        darkbackground.hidden = false
        darkbackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.collectionView.reloadData()
            self.collectionView.hidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    
    func handleDismiss() {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.darkbackground.hidden = true
            self.collectionView.hidden = true
        }
    }
   
    @IBAction func goBacktoTimeline (_sender:UIButton) {
        dismissViewControllerAnimated(true, completion: {})
    }
    
    
}
