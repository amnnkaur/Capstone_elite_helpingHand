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

class NewTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
   
    var finalAddress = ""
    var finalLat = ""
    var finalLong = ""
    var finalCity = ""
    var finalPostalCode = ""
    let datePicker:UIDatePicker = UIDatePicker()
    var jobTypePicker = UIPickerView()
    
    let jobTypeArray = ["Furniture assembly", "Minor home repair", "Hauling", "Car washing", "Heavy lifting", "Yard work", "General cleaning", "Plumbing", "Mounting", "Installations", "Electrical help", "Carpentry help", "Other"]

    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDescField: UITextField!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var postalCodeField: UITextField!
    var taskID: String = ""
    var taskEmail: String = ""
     var ref = Database.database().reference()
    override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
        self.taskID = Auth.auth().currentUser?.uid ?? "no uid found"
        self.taskEmail = Auth.auth().currentUser?.email ?? "no email found"
        
        createDatePicker()
        jobTypePicker.delegate = self
        jobTypePicker.dataSource = self
        typeField.inputView = jobTypePicker
     }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeField.text = jobTypeArray[row]
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jobTypeArray.count
       }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = jobTypeArray[row]
       return row
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createDatePicker(){
            
          datePicker.datePickerMode = UIDatePicker.Mode.date

            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //bar button
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
            toolbar.setItems([doneBtn], animated: true)
            
            dateField.inputAccessoryView = toolbar
            dateField.inputView = datePicker
        }
        
        @objc func donePressed() {
           
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            dateField.text = formatter.string(from: datePicker.date)
    //        self.datePicker.endEditing(true)
            self.dateField.endEditing(true)
        }
        

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
            self.finalCity = sourceViewController.finalCity
            self.finalPostalCode = sourceViewController.finalPostalCode
            
            self.finalLat = sourceViewController.finalLat
            self.finalLong = sourceViewController.finalLong

            print("TaskVCFianlAddress \(self.finalAddress)")
            self.addressField.text = self.finalAddress
            self.cityField.text = self.finalCity
            self.postalCodeField.text = self.finalPostalCode
//            }
        }

        
}
