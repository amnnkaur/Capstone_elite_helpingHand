//
//  PaymentDue.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-25.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol PaymentDocumentSerializable  {
    init(dictionary:[String:Any])
}


struct PaymentDue {
    var taskName:String
    var taskId: String
    var taskEmail: String
    var userEmail: String
    var status: String
    var taskDueDate: String
    var taskHours: String
    var taskAmount: String
    var calculatedAmount: String
    var paymentStatus: String
    
    var dictionary:[String:Any] {
        return [
            "taskName":taskName,
            "taskId": taskId,
            "taskEmail": taskEmail,
            "userEmail": userEmail,
            "status" : status,
            "taskDueDate": taskDueDate,
            "taskHours": taskHours,
            "taskAmount": taskAmount,
            "calculatedAmount": calculatedAmount,
            "paymentStatus": paymentStatus
        ]
    }
    
}

extension PaymentDue : PaymentDocumentSerializable {
    init(dictionary: [String : Any]) {
        self.init(taskName: dictionary["taskName"] as! String, taskId: dictionary["taskId"] as! String, taskEmail: dictionary["taskEmail"] as! String, userEmail: dictionary["userEmail"] as! String, status: dictionary["status"] as! String, taskDueDate: dictionary["taskDueDate"] as! String, taskHours: dictionary["taskHours"] as! String, taskAmount:  dictionary["taskAmount"] as! String, calculatedAmount: dictionary["calculatedAmount"] as! String, paymentStatus: dictionary["paymentStatus"] as! String)
    }
}

