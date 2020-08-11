//
//  SignUpViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource  {
  
 
    @IBOutlet weak var city: UITextField!
    
    
    let countryArray = ["Brampton", "Toronto", "Mississauga", "Etobicoke", "Scarbourough", "Vaughan", "Windsor"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let cityPicker = UIPickerView()
        city.inputView = cityPicker
        cityPicker.delegate = self
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countryArray.count
      }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       let row = countryArray[row]
       return row
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city.text = countryArray[row]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
