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
var taskPostingDate : String
var tasktype : String
var taskLocation : String
var taskPay : String
var taskTime : String
    
    init(taskID: String, taskTitle: String, taskDesc: String, taskPostingDate: String, tasktype: String, taskLocation: String, taskPay: String, taskTime: String  ) {
        self.taskID = taskID
        self.taskTitle = taskTitle
        self.taskDesc = taskDesc
        self.taskPostingDate = taskPostingDate
        self.tasktype = tasktype
        self.taskLocation = taskLocation
        self.taskPay = taskPay
        self.taskTime = taskTime
    }

}