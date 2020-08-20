//
//  GetLocation.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-18.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import CoreLocation

public class GetLocation: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var locationCallback: ((CLLocation?) -> Void)!
    var locationServicesEnabled = false
    var didFailWithError: Error?

    public func run(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled { manager.startUpdatingLocation() }
        else { locationCallback(nil) }
    }

   public func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        locationCallback(locations.last!)
        manager.stopUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        locationCallback(nil)
        manager.stopUpdatingLocation()
    }

    deinit {
        manager.stopUpdatingLocation()
    }
    
    public func distanceBetween(userlatitude: Double, userlongitude: Double, taskLatitude: Double, tasklongitude: Double, radius: Int) -> Bool {

        let taskLocation: CLLocation = CLLocation(latitude: taskLatitude,
                                                       longitude: tasklongitude)

        let usersCurrentLocation: CLLocation = CLLocation(latitude: userlatitude, longitude: userlongitude)

        var inOrOut: Bool
                                                              
        let distanceInMeters: CLLocationDistance = usersCurrentLocation.distance(from: taskLocation)
        
        var distance: Double
        
        distance = Double(radius * 1000)

        if distanceInMeters < distance {

            inOrOut = true
        } else {

           inOrOut = false
        }
        return inOrOut
    }
    
}
