//
//  FavoriteTasks.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-21.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation

class FavoiteTasks{
    var taskID : String
    var taskTitle : String
    var taskDueDate : String
    var taskEmail: String
    var userId: String
    var userEmail: String

    init(taskID : String, taskTitle : String, taskDueDate : String, taskEmail: String, userId: String, userEmail: String){
        self.taskID = taskID
        self.taskTitle = taskTitle
        self.taskDueDate = taskDueDate
        self.taskEmail = taskEmail
        self.userId = userId
        self.userEmail = userEmail
    }
}
