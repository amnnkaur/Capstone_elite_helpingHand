//
//  User.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-12.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
class User{
    var id : String
    var firstName : String
    var lastName : String
    var city : String
    var mobileNumber : String
    var emailId : String
    var password: String
    var street : String
    var radius : String
    var postal : String
    
    init(id: String, firstName : String, lastName : String, mobileNumber : String, emailId : String, password: String, radius : String, street : String, postal: String, city : String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.emailId = emailId
        self.password = password
        self.radius = radius
        self.street = street
        self.postal = postal
        self.city = city
    }
 
}
