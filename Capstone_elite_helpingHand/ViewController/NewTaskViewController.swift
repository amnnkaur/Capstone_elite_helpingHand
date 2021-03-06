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
    var amountPicker = UIPickerView()
    var amountArray = Array(0...100)
    
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
        createJobPicker()
        createAmountPicker()
        
        self.hideKeyboardWhenTappedAround()
        
            contactField.addTarget(self, action: #selector(convertStringToContactNumber(textfield:)), for: UIControl.Event.editingDidEnd)
            contactField.keyboardType = .asciiCapableNumberPad
        
     }
   
    @objc func convertStringToContactNumber(textfield: UITextField){
        textfield.text = textfield.text!.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0 {
            return typeField.text = jobTypeArray[row]
        }
         else if pickerView.tag == 1 {
               return amountField.text = "$ \(amountArray[row])/hr"
           }
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
         if pickerView.tag == 0 {
               return jobTypeArray.count
         }
         else if pickerView.tag == 1{
               return amountArray.count
        }
        return 0
       }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return jobTypeArray[row]
        }
        else if pickerView.tag == 1{
            return "$ \(amountArray[row])/hr"
        }

        return " "
    }

    func createJobPicker(){
        jobTypePicker.delegate = self
        jobTypePicker.dataSource = self
        typeField.inputView = jobTypePicker
        jobTypePicker.tag = 0
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
                   
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(jobDonePressed))
        toolbar.setItems([doneBtn], animated: true)
                   
        typeField.inputAccessoryView = toolbar
    }
    
    @objc func jobDonePressed() {
        self.typeField.endEditing(true)
        }
    
    func createAmountPicker(){
        amountPicker.delegate = self
        amountPicker.dataSource = self
        amountField.inputView = amountPicker
        amountPicker.tag = 1
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
                   
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(amountDonePressed))
        toolbar.setItems([doneBtn], animated: true)
                   
        amountField.inputAccessoryView = toolbar
    }
    
    @objc func amountDonePressed() {
        self.amountField.endEditing(true)
        }
    
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
    
        

    @IBAction func addToFirebase(_ sender: Any)
    {
        let taskName = taskNameField.text ?? ""
        let taskDesc = taskDescField.text ?? ""
        let contact = contactField.text ?? ""
        let date = dateField.text ?? ""
        let type = typeField.text ?? ""
        let amount = amountField.text ?? ""
        let address = addressField.text ?? ""
        let city = cityField.text ?? ""
        let postalCode = postalCodeField.text ?? ""
        
        if(taskName.isEmpty == true || taskDesc.isEmpty == true || contact.isEmpty == true || date.isEmpty == true || type.isEmpty == true || amount.isEmpty == true || address.isEmpty == true || city.isEmpty == true || postalCode.isEmpty == true){
            displayAlert(title: "Error!! ❌", message: "All fields are mandatory", flag: 0)
        }else if(!contact.isNumber()){
             displayAlert(title: "Contact ❌", message: "Contact number should be in this format: xxx-xxx-xxxx", flag: 0)
        }else{
       
        DataStorage.getInstance().addUserTask(userTask: Task(taskID: self.taskID, taskTitle: taskName, taskDesc: taskDesc, taskDueDate: date, tasktype: type, taskAddress: address, taskPay: amount, taskEmail: self.taskEmail, taskLat: self.finalLat, taskLong: self.finalLong, taskContact: contact, taskCity: city, taskPostalCode: postalCode))
        
        let insert = ["taskName": taskName , "taskDescription":taskDesc, "contact": contact, "date": date, "type": type, "amount": amount, "taskID": self.taskID, "taskEmail": self.taskEmail, "address": address, "city": city, "postalCode": postalCode, "taskLat": self.finalLat, "taskLong": self.finalLong]
        guard let key = self.ref.child("tasks").childByAutoId().key else {return}
        let childUpdates = ["/tasks/\(key)": insert]
        self.ref.updateChildValues(childUpdates)
        displayAlert(title: "Success ✅", message: "Your task is saved and distributed over other users. Hopes high for quick reply😇", flag: 1)
        }
    }
    
    
    func displayAlert(title: String, message: String, flag: Int){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if(flag == 0){
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
        }else if (flag == 1){
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.taskNameField.text = ""
                self.taskDescField.text = ""
                self.contactField.text = ""
                self.dateField.text = ""
                self.typeField.text = ""
                self.amountField.text = ""
                self.addressField.text = ""
                self.cityField.text = ""
                self.postalCodeField.text = ""
                
                self.taskNameField.becomeFirstResponder()
            }))
        }
            self.present(alert, animated: true)
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

extension NewTaskViewController {
    
    //MARK: hide keyboard by swiping down
    func hideKeyboardWhenTappedAround() {
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(NewTaskViewController.dismissKeyboard))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)


    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
  
}
