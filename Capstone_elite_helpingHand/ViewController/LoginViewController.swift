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

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var rememberMe: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

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
                 
                 print("success")
//                self.displayAlert(title: "Success", message: "You are successfully logged in")
                self.dismiss(animated: true) {
//                    let sb = UIStoryboard(name: "Main", bundle: nil)
//                    let VC = sb.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
//                    let navRootView = UINavigationController(rootViewController: VC)
//                    self.present(navRootView, animated: true, completion: nil)
                    
                    let defaults = UserDefaults.standard
                    defaults.set(userName, forKey: "userName")
//
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "appTabBar") as! UITabBarController
//                    UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController!.present(viewController, animated: true, completion: nil)
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                }
       
//                 UserDefaults.standard.set(true, forKey: "status")
//                 NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
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
    
}
