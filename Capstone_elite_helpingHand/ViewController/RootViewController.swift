//
//  ViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import SwiftUI
import UserNotifications


class RootViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initials()
}

    func initials(){
       
        loginActivityIndicator.stopAnimating()
        loginActivityIndicator.hidesWhenStopped = true
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.cornerRadius = 8.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor

        
    }
    
 

    
    @IBAction func unwindToRootVC(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! LoginViewController
        // Use data from the view controller which initiated the unwind segue
        self.loginActivityIndicator.startAnimating()
    }

}

