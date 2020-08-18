//
//  Task.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation

class Task {

    var taskID : String
    var taskTitle : String
    var taskDesc : String
    var taskDueDate : String
    var tasktype : String
    var taskAddress : String
    var taskPay : String
    var taskEmail: String
    var taskLat: String
    var taskLong: String
    var taskContact: String
    var taskCity: String
    var taskPostalCode: String
    
    init(taskID: String, taskTitle: String, taskDesc: String, taskDueDate: String, tasktype: String, taskAddress: String, taskPay: String,
         taskEmail: String, taskLat: String, taskLong: String, taskContact: String, taskCity: String, taskPostalCode: String) {
        self.taskID = taskID
        self.taskTitle = taskTitle
        self.taskDesc = taskDesc
        self.taskDueDate = taskDueDate
        self.tasktype = tasktype
        self.taskAddress = taskAddress
        self.taskPay = taskPay
        self.taskEmail = taskEmail
        self.taskLat = taskLat
        self.taskLong = taskLong
        self.taskContact = taskContact
        self.taskCity = taskCity
        self.taskPostalCode = taskPostalCode
    }

}
