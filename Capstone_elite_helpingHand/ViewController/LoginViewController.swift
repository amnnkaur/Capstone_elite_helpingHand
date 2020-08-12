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
                     return
                 }
                 
                 print("success")
//                 UserDefaults.standard.set(true, forKey: "status")
//                 NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
             }
         }
         else{
             
//             self.error = "Please fill all the contents properly"
//             self.alert.toggle()
         }
     }
    
    @IBAction func loginAction(_ sender: UIButton) {
        verify()
    }
    
    @IBSegueAction func loginToTaskHostVC(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: JobListView())
    }
}
