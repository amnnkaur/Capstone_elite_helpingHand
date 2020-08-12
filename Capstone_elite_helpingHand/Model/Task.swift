//
//  Task.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation

class Task {

var taskID : Int
var taskTitle : String
var taskDesc : String
var taskPostingDate : String
var tasktype : String
var taskLocation : String
var taskPay : Double
var taskTime : Int
    
    init(taskID: Int, taskTitle: String, taskDesc: String, taskPostingDate: String, tasktype: String, taskLocation: String, taskPay: Double, taskTime: Int  ) {
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
