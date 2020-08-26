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


class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var personImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contact: UILabel!
    
    var userName: String?
    var ref = Database.database().reference()
    var userList: [User] = []
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
           
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
        self.address.text = user?.street ?? "No address"
        self.contact.text = user?.mobileNumber ?? "No mobile number"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
