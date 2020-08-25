//
//  TaskStatus.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-24.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable  {
    init(dictionary:[String:Any])
}


struct TaskStatus {
    var taskName:String
    var taskId: String
    var taskEmail: String
    var userEmail: String
    var userId: String
    var timeStamp:String
    var status: String
    var taskDueDate: String
    var taskHours: String
    var taskAmount: String
    
    var dictionary:[String:Any] {
        return [
            "taskName":taskName,
            "taskId": taskId,
            "taskEmail": taskEmail,
            "userEmail": userEmail,
            "userId": userId,
            "timeStamp" : timeStamp,
            "status" : status,
            "taskDueDate": taskDueDate,
            "taskHours": taskHours,
            "taskAmount": taskAmount
        ]
    }
    
}

extension TaskStatus : DocumentSerializable {
    init(dictionary: [String : Any]) {
        self.init(taskName: dictionary["taskName"] as! String, taskId: dictionary["taskId"] as! String, taskEmail: dictionary["taskEmail"] as! String, userEmail: dictionary["userEmail"] as! String, userId: dictionary["userId"] as! String, timeStamp: dictionary ["timeStamp"] as! String, status: dictionary["status"] as! String, taskDueDate: dictionary["taskDueDate"] as! String, taskHours: dictionary["taskHours"] as! String, taskAmount:  dictionary["taskAmount"] as! String)
    }
}


/*
 init?(dictionary: [String : Any]) {
       guard let taskName = dictionary["taskName"] as? String,
           let taskId = dictionary["taskId"] as? String,
           let taskEmail = dictionary["taskEmail"] as? String,
           let userEmail = dictionary["userEmail"] as? String,
           let userId = dictionary["userId"] as? String,
           let timeStamp = dictionary ["timeStamp"] as? Date else {return nil}
       
       self.init(taskName: taskName, taskId: taskId, taskEmail: taskEmail, userEmail: userEmail, userId: userId, timeStamp: timeStamp)
   }
 */
