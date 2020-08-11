//
//  ViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import SwiftUI

class RootViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initials()
    }

    func initials(){
//        loginBtn.layer.borderWidth = 1.0
//        loginBtn.layer.cornerRadius = 8.0
//        loginBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.cornerRadius = 8.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        
    }
    
    @IBSegueAction func signUpAction(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SignUpFormView())
    }
    
    
}
