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
        mapView.userTrackingMode = MKUserTrackingMode.follow
        geoFireRef = FIRDatabase.database().reference()
        geoFire = GeoFire(firebaseRef:geoFireRef)
        collectionView.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }

    func centerMapOnLocation(_ location:CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            if !mapHasCenteredOnce {
                centerMapOnLocation(loc)
                mapHasCenteredOnce = true
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKAnnotationView?
        let annoIdentifier = "Crime"
        
        if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoIdentifier) {
            annotationView = deqAnno
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
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
            btn.setImage(UIImage(named:"map"), for: UIControlState())
            annotationView.rightCalloutAccessoryView = btn
        }
        return annotationView
    }
    
    func createSighting(forLocation location: CLLocation, withCrimeType crimeName:String) {
        geoFire.setLocation(location, forKey: crimeName)
    }
    
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        showSittingOnMap(loc)
    }
    
    func showSittingOnMap(_ location:CLLocation) {
        let circleQuery = geoFire!.query(at: location, withRadius: 2.5)
       _ = circleQuery?.observe(GFEventType.keyEntered, with: { (key, location) in
            if let key = key, let location = location {
                let anno = CrimeAnnotation(coordinate: location.coordinate, crimeName: key)
                self.mapView.addAnnotation(anno)
            }
       })
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let anno = view.annotation as? CrimeAnnotation {
        }
    }
    
    @IBAction func spottedCrime(_ _sender:UIButton) {
        //Get the name of the crime to create a sighting
        darkbackground.isHidden = false
        darkbackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.view.layoutIfNeeded()
        }) 
    }
    
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.darkbackground.isHidden = true
            self.collectionView.isHidden = true
        }) 
    }
   
    @IBAction func goBacktoTimeline (_ _sender:UIButton) {
        dismiss(animated: true, completion: {})
    }
    
    
}
