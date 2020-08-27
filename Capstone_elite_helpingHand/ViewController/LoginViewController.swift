//
//  LoginViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    let getLocation = GetLocation()
    var taskList: [Task] = []
    var userList: [User] = []
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initials()
        // Do any additional setup after loading the view.
         rememberMe.addTarget(self, action: #selector(self.stateChanged), for: .valueChanged)
                let defaults: UserDefaults? = UserDefaults.standard

        // check if defaults already saved the details

        if (defaults?.bool(forKey: "ISRemember"))! {
            userNameField.text = defaults?.value(forKey: "SavedUserName") as! String
            passwordField.text = defaults?.value(forKey: "SavedPassword") as! String
                    rememberMe.setOn(true, animated: false)
                }
                else {
                    rememberMe.setOn(false, animated: false)
                }
    }

    func initials() {
        let defaults: UserDefaults? = UserDefaults.standard
        
        userList = DataStorage.getInstance().getAllUsers()
        taskList = DataStorage.getInstance().getAllTasks()
        getLocation.run {
                  if let location = $0 {
                      self.userLatitude = location.coordinate.latitude
                      self.userLongitude = location.coordinate.longitude
                    defaults?.set(location.coordinate.latitude, forKey: "currentlatitude")
                    defaults?.set(location.coordinate.longitude, forKey: "currentLongitude")
                     
                  } else {
                      print("Get Location failed \(self.getLocation.didFailWithError)")
                  }
              }
    }
    
    @IBAction func faceIDLogin(_ sender: UIButton) {
        beginFaceID()
    }
    
    func beginFaceID() {

        guard #available(iOS 8.0, *) else {
            return print("Not supported")
        }

        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error)
        }

        let reason = "Face ID authentication"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { isAuthorized, error in
            guard isAuthorized == true else {
                return print(error)
            }

            print("success")
//            var username = ""
//            var password = ""
//            self.userNameField.text = ""
//            self.passwordField.text = ""
//            let defaults: UserDefaults? = UserDefaults.standard
//            defaults?.set(username, forKey: "SavedUserName")
//            defaults?.set(password, forKey: "SavedPassword")
//            self.userNameField.text = username
//            self.passwordField.text = password
            DispatchQueue.main.async {
                 self.verify()
            }
        }

    }
    
    
    func filterTaskArrayOverGeolocation(radius: Int) {
        var filteredTaskList: [Task] = []
        for item in taskList{
            if (getLocation.distanceBetween(userlatitude: self.userLatitude, userlongitude: self.userLongitude, taskLatitude: (item.taskLat as NSString).doubleValue, tasklongitude: (item.taskLong as NSString).doubleValue, radius: radius)){
                    filteredTaskList.append(item)
            }
        }
        
        DataStorage.getInstance().removeAllTasks()
        for item in filteredTaskList{
            DataStorage.getInstance().addTask(task: item)
        }
        
        filteredTaskList.removeAll()
    }
    
    @objc func stateChanged(_ switchState: UISwitch) {

                let defaults: UserDefaults? = UserDefaults.standard
        if switchState.isOn {
                    defaults?.set(true, forKey: "ISRemember")
                    defaults?.set(userNameField.text, forKey: "SavedUserName")
                    defaults?.set(passwordField.text, forKey: "SavedPassword")
                }
                else {
                    defaults?.set(false, forKey: "ISRemember")
                    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func verify(){
        let userName = self.userNameField.text!
        let password = self.passwordField.text!
         
        if userName != "" && password != ""{
             
             Auth.auth().signIn(withEmail: userName, password: password) { (res, err) in
                 
                 if err != nil{
                     
                    print(err!.localizedDescription)
                    self.displayAlert(title: "Error!", message: "\(err!.localizedDescription)")
                     return
                 }
                 else{
                 print("success")
                    self.performSegue(withIdentifier: "rootIdentifier", sender: self)
                    let defaults = UserDefaults.standard
                    defaults.set(userName, forKey: "userName")

                    self.filterAccordingSpecificUser(userName: userName)
                    DataStorage.getInstance().loadUserList(userName: userName)
                    DataStorage.getInstance().loadUserFavTasks(userName: userName)
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "appTabBar") as! UITabBarController
//                    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.present(viewController, animated: true, completion: nil)
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                          UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = viewController
                }
            }
        }
    }
}
    
    @IBAction func loginAction(_ sender: UIButton) {
        verify()
    }
    
    func displayAlert(title: String, message: String){
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func filterAccordingSpecificUser(userName: String){
        var radius: String
        for item in self.userList{
                  if item.emailId == userName{
                    radius = item.radius
                    radius = radius.replacingOccurrences(of: "km", with: "")
                    self.filterTaskArrayOverGeolocation(radius: (radius as NSString).integerValue)
            }
           
        
    }
    }
}
