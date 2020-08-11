//
//  SignUpViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource  {
  
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var postalAddress: UITextField!
    
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    var cityPicker = UIPickerView()
    var statePicker = UIPickerView()
    private var _currentSelection: Int = 0
    
    let stateArray = ["Ontario", "Alberta", "British Columbia", "Manitoba"]
    
    
    let cityArrayON = [["Brampton", "Toronto", "Mississauga", "Ottawa", "Hamilton", "Kitchener", "Vaughan", "Windsor", "Markham", "London"],
                       ["Calgary", "Edmonton", "Lethbridge", "Brooks"],
                       ["Abbotsford", "Burnaby", "Vancouver", "Surrey","Richmond", "Kimberley" ,"Duncan"],
                       ["Brandon", "Winnipeg", "Thompson", "Winkler"]]
    
    var currentSelection: Int {
        get {
            return _currentSelection
        }
        set {
            _currentSelection = newValue
            cityPicker .reloadAllComponents()
            statePicker .reloadAllComponents()

            state.text = stateArray[_currentSelection]
            city.text = cityArrayON[_currentSelection][0]

        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSelection = 0;

        statePicker.delegate = self
        statePicker.dataSource = self
        statePicker.tag = 0
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityPicker.tag = 1
        
        state.inputView = statePicker
        city.inputView = cityPicker
        
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         if pickerView.tag == 0 {
               return stateArray.count
           } else {
               return cityArrayON[currentSelection].count
           }
      }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       if pickerView.tag == 0 {
           return stateArray[row]
       } else {
           return cityArrayON[currentSelection][row]
       }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
                currentSelection = row

               state.text = stateArray[row]
                state.resignFirstResponder()
            
            } else if pickerView.tag == 1 {
                city.text = cityArrayON[currentSelection][row]
                city.resignFirstResponder()
            }
        
    }

    @IBAction func signUpTofirebase(_ sender: UIButton) {
        let fName = self.firstName.text
        let lName = self.lastName.text
        let email = self.emailAddress.text
        let psswrd = self.password.text
        let confirmPsswrd = self.confirmPassword.text
        let contact = self.contactNumber.text
        let street = self.streetAddress.text
        let cityValue = self.city.text
        let stateValue = self.state.text
        let postalCode = self.postalAddress.text
        
        print(fName + "," + lName + "," + email + "," + psswrd + "," + confirmPsswrd + "," + contact + "," + street + "," + cityValue + "," + stateValue + "," + postalCode)
        
    }
}
