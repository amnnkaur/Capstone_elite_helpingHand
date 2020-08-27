//
//  UserProfileViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-23.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class UserProfileViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var personImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var userName: String?
    var ref = Database.database().reference()
    var userList: [User] = []
    var user: User?
        
    var circle:MKCircle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        mapView.isZoomEnabled = false
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
           
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = profileView.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.4)
        gradientLayer.opacity = 0.7
        self.profileView.layer.insertSublayer(gradientLayer, at: 0)
        
        personImg.layer.cornerRadius = 50
        
        userList = DataStorage.getInstance().getAllUsers()
        
        for item in userList{
            if item.emailId == Auth.auth().currentUser?.email{
                self.user = item
                  }
              }
        initials()
        
    }
    
    func initials() {
        self.name.text = "\(user?.firstName ?? "No first name") \(user?.lastName ?? "No last name")"
        self.email.text = user?.emailId ?? "No email id"
//        self.address.text = user?.street ?? "No address"
//        self.contact.text = user?.mobileNumber ?? "No mobile number"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //       let userLocation = locations[0]
           
           let latitude = 43.6532
           let longitude = -79.3832
        
           let latDelta: CLLocationDegrees = 0.05
           let longDelta: CLLocationDegrees = 0.05
            
            // 3 - Creating the span, location coordinate and region
           let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
            let customLocation = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
           let region = MKCoordinateRegion(center: customLocation, span: span)
            
            let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { (placemarks, error) in
                    if let places = placemarks {
                        for place in places {
                            annotation.title = place.name
                            annotation.subtitle = "\(place.locality!) ,  \(place.postalCode!)"
                        }
                    }
                self.mapView.addAnnotation(annotation)
                self.mapView.setRegion(region, animated: true)
                self.loadOverlayForRegionWithLatitude(latitude: latitude, andLongitude: longitude)
            }
            
        }
    
    
     func loadOverlayForRegionWithLatitude(latitude: Double, andLongitude longitude: Double) {

        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        circle = MKCircle(center: coordinates, radius: 6000)
        self.mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        self.mapView.addOverlay(circle)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
        circleRenderer.strokeColor = UIColor.blue
        circleRenderer.lineWidth = 1
        return circleRenderer
    }
}
