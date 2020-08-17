//
//  NewTaskViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewTaskViewController: UIViewController {
    
    var finalAddress = ""
    var finalLat = ""
    var finalLong = ""
    

    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDescField: UITextField!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    var taskID: String = ""
    var taskEmail: String = ""
     var ref = Database.database().reference()
    override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
        self.taskID = Auth.auth().currentUser?.uid ?? "no uid found"
        self.taskEmail = Auth.auth().currentUser?.email ?? "no email found"
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addToFirebase(_ sender: Any) {
        let insert = ["taskName": taskNameField.text ?? "", "taskDescription":taskDescField.text ?? "", "contact": contactField.text ?? "", "date": dateField.text ?? "", "type": typeField.text ?? "", "amount": amountField.text ?? "", "taskID": self.taskID, "taskEmail": self.taskEmail]
        guard let key = self.ref.child("tasks").childByAutoId().key else {return}
        let childUpdates = ["/tasks/\(key)": insert]
        self.ref.updateChildValues(childUpdates)
    }
    
    
        
        @IBAction func unwindToTaskVC(_ unwindSegue: UIStoryboardSegue) {
            
//            if unwindSegue.identifier == "moveToIdentifier" {
                let sourceViewController = unwindSegue.source as! MapViewController
                           // Use data from the view controller which initiated the unwind segue
                   
                           self.finalAddress = sourceViewController.finalAddress
                           self.finalLat = sourceViewController.finalLat
                           self.finalLong = sourceViewController.finalLong

                           print("TaskVCFianlAddress \(self.finalAddress)")
            self.contactField.text = self.finalAddress
//            }
        }

        
}
