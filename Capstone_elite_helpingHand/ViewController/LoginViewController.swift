//
//  LoginViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
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
