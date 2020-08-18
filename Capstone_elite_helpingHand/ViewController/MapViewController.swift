//
//  MapViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-17.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var destinationCoordinates : CLLocationCoordinate2D!
    let button = UIButton()
    var finalAddress = ""
    var finalCity = ""
    var finalPostalCode = ""
    var finalLat : String = ""
    var finalLong : String = ""
    @IBOutlet weak var zoomStepper: UIStepper!
     var stepperComparingValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isZoomEnabled = false
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
                      tap.numberOfTapsRequired = 2
                      mapView.addGestureRecognizer(tap)

    }
    
    @IBAction func zoomStepperChanged(_ sender: UIStepper) {
        
        let stepperValue = zoomStepper.value
        if(stepperValue > self.stepperComparingValue){

            var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
            mapView.setRegion(region, animated: true)
            self.stepperComparingValue = stepperValue
        }else if(stepperValue < self.stepperComparingValue){

            var region: MKCoordinateRegion = mapView.region
              region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
              region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
              mapView.setRegion(region, animated: true)
            self.stepperComparingValue = stepperValue
        }
    }
    
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
                
               let mapAnnotations  = self.mapView.annotations
               self.mapView.removeAnnotations(mapAnnotations)
               let tapLocation = recognizer.location(in: mapView)
               self.destinationCoordinates = mapView.convert(tapLocation, toCoordinateFrom: mapView)
                   
                   
                   if recognizer.state == .ended
                   {
                       
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = self.destinationCoordinates!
                        let geocoder = CLGeocoder()
                        geocoder.reverseGeocodeLocation(CLLocation(latitude: destinationCoordinates.latitude, longitude: destinationCoordinates.longitude)) { (placemarks, error) in
                        if let places = placemarks {
                            for place in places {
                                annotation.title = place.name
                                annotation.subtitle = "\(place.locality ?? " ") ,  \(place.postalCode ?? " ")"
                                self.finalAddress = "\(place.name ?? " "), \(place.subLocality ?? " ")"
                                self.finalCity = place.locality ?? " "
                                self.finalPostalCode = place.postalCode ?? " "
                            }
                        }
                    }
                    self.finalLat = "\(destinationCoordinates.latitude)"
                    self.finalLong = "\(destinationCoordinates.longitude)"
                    
                    self.mapView.addAnnotation(annotation)
                   }
               }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                  let userLocation = locations[0]
                  
                  let latitude = userLocation.coordinate.latitude
                  let longitude = userLocation.coordinate.longitude
                   
                  let latDelta: CLLocationDegrees = 0.05
                  let longDelta: CLLocationDegrees = 0.05
                   
                   // 3 - Creating the span, location coordinate and region
                  let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                  let customLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                  let region = MKCoordinateRegion(center: customLocation, span: span)
                         
                   // 4 - assign region to map
                  mapView.setRegion(region, animated: true)
               }

     func geocode()  {
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: destinationCoordinates.latitude, longitude: destinationCoordinates.longitude)) {  placemark, error in
               if let error = error as? CLError {
                   print("CLError:", error)
                   return
                }
               else if let placemark = placemark?[0] {
                
                var placeName = ""
                var neighbourhood = ""
                var city = ""
                var state = ""
                var postalCode = ""
                var country = ""
                
                
                if let name = placemark.name {
                    placeName += name
                            }
                if let sublocality = placemark.subLocality {
                    neighbourhood += sublocality
                            }
                if let locality = placemark.subLocality {
                     city += locality
                            }
                if let area = placemark.administrativeArea {
                              state += area
                          }
                if let code = placemark.postalCode {
                              postalCode += code
                          }
                if let cntry = placemark.country {
                                        country += cntry
                                    }
                }
            
            }
        }
}

extension MapViewController {
    
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
            if annotation is MKUserLocation {
                return nil
            }
                let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
                pinAnnotation.markerTintColor = .systemPink
                pinAnnotation.glyphTintColor = .white
                pinAnnotation.canShowCallout = true
        
                button.setImage(UIImage(systemName: "plus"), for: .normal)
                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                pinAnnotation.rightCalloutAccessoryView = button
                return pinAnnotation
        }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
         let alertController = UIAlertController(title: "Use this Location", message:
            "Do you want to use this location?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Yes", style:  .default, handler: { (UIAlertAction) in
            self.geocode()
        
                print(self.finalAddress)
                print(self.finalLat)
                print(self.finalLong)
                
                self.performSegue(withIdentifier: "moveToIdentifier", sender: self)
                
                self.dismiss(animated: true, completion: nil)
    
            }))
    
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alertController, animated: true, completion: nil)
                    
    }
}

