//
//  TaskDetailViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-19.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import MapKit

class TaskDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var task: Task = Task(taskID: "", taskTitle: "", taskDesc: "", taskDueDate: "", tasktype: "", taskAddress: "", taskPay: "", taskEmail: "", taskLat: "", taskLong: "", taskContact: "", taskCity: "", taskPostalCode: "")

    @IBOutlet weak var detailMapView: MKMapView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var taskDetailView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDesc: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    let gradientLayer = CAGradientLayer()
    var ref = Database.database().reference()
    var locationManager = CLLocationManager()
    var destinationCoordinates : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initials()
        detailMapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//       let userLocation = locations[0]
       
       let latitude = (task.taskLat as NSString).doubleValue
       let longitude = (task.taskLong as NSString).doubleValue
        
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
                self.detailMapView.addAnnotation(annotation)
            self.detailMapView.setRegion(region, animated: true)
        }
        
    }
    
    func initials() {
        gradientLayer.frame = taskDetailView.bounds
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.4)
        gradientLayer.opacity = 0.7
        self.taskDetailView.layer.insertSublayer(gradientLayer, at: 0)

        favBtn.layer.cornerRadius = 20
        favBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        msgBtn.contentVerticalAlignment = .fill
        msgBtn.contentHorizontalAlignment = .fill
        msgBtn.layer.cornerRadius = 20
        msgBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        labelValues()
    }

    func labelValues() {
        self.taskTitle.text = task.taskTitle
        self.taskDesc.text = task.taskDesc
        self.address.text = "\(task.taskAddress), \(task.taskCity), \(task.taskPostalCode)"
        self.contact.text = task.taskContact
        self.date.text = task.taskDueDate
        self.amount.text? = "Amount: \(task.taskPay)"
    }
    
    
    
    @IBAction func favoriteTasks(_ sender: UIButton) {
        self.displayAlert(title: "♥️ To-do Tasks", message: "Do you want to save this task in your to-do task list and get reminder one day prior of task due date?", flag: 0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func displayAlert(title: String, message: String, flag: Int){
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if flag == 0{
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.saveToFavoriteToDo()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
         
          self.present(alert, animated: true)
      }
    
    func saveToFavoriteToDo(){
        
        DataStorage.getInstance().addFavoriteTask(favTask: FavoiteTasks(taskID: self.task.taskID, taskTitle: self.task.taskTitle, taskDueDate: self.task.taskDueDate, taskEmail: self.task.taskEmail, userId: Auth.auth().currentUser?.uid ?? "no uid found", userEmail: Auth.auth().currentUser?.email ?? "no email found"))
        
        let insert = ["taskName": self.task.taskTitle , "dueDate":  self.task.taskDueDate, "taskID": self.task.taskID, "taskEmail": self.task.taskEmail, "userEmail": Auth.auth().currentUser?.email ?? "no email found", "userID": Auth.auth().currentUser?.uid ?? "no uid found"]
            guard let key = self.ref.child("favoriteTasks").childByAutoId().key else {return}
            let childUpdates = ["/favoriteTasks/\(key)": insert]
            self.ref.updateChildValues(childUpdates)
    }
    
}

extension TaskDetailViewController {

   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation is MKUserLocation {
            return nil
        }
            let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            pinAnnotation.markerTintColor = .systemPink
            pinAnnotation.glyphTintColor = .white
            pinAnnotation.canShowCallout = true
    
//            button.setImage(UIImage(systemName: "plus"), for: .normal)
//            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//            pinAnnotation.rightCalloutAccessoryView = button
            return pinAnnotation
    }
}
