//
//  UserProfileViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-23.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import Braintree

class UserProfileViewController: UIViewController {
    
    var braintreeClient: BTAPIClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeClient = BTAPIClient(authorization: "sandbox_hcwxk8yn_yk2kgrnb4ncwqzmw")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payBtn(_ sender: UIButton) {
        
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
                            payPalDriver.viewControllerPresentingDelegate = self
                            payPalDriver.appSwitchDelegate = self // Optional
                     
                     // Specify the transaction amount here. "2.32" is used in this example.
                     let request = BTPayPalRequest(amount: "2.32")
                     request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options

                     payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                         if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                             print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                             // Access additional information
                             let email = tokenizedPayPalAccount.email
                             let firstName = tokenizedPayPalAccount.firstName
                             let lastName = tokenizedPayPalAccount.lastName
                             let phone = tokenizedPayPalAccount.phone

                             // See BTPostalAddress.h for details
                             let billingAddress = tokenizedPayPalAccount.billingAddress
                             let shippingAddress = tokenizedPayPalAccount.shippingAddress
                         } else if let error = error {
                             // Handle error here...
                         } else {
                             // Buyer canceled payment approval
                         }
                     }
              
          }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

extension UserProfileViewController : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
         
    }
    
    
}

extension UserProfileViewController : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
           
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
          
    }
    
    
}

