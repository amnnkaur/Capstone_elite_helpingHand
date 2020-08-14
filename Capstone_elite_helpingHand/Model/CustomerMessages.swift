//
//  CustomerMessages.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-14.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
class CustomerMessages {

var taskUID : String
var taskTitle : String
var taskPostingDate : String
var taskEmail: String
    var userUID: String
    var userEmail: String
    
    init(taskUID: String, taskTitle: String, taskPostingDate: String, taskEmail: String, userUID: String, userEmail: String) {
        self.taskUID = taskUID
        self.taskTitle = taskTitle
        self.taskPostingDate = taskPostingDate
        self.taskEmail = taskEmail
        self.userUID = userUID
        self.userEmail = userEmail
    }

}
