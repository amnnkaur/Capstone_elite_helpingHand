//
//  ViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class ViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initials()
    }

    func initials(){
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.cornerRadius = 8.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        
    }
    
    
}

