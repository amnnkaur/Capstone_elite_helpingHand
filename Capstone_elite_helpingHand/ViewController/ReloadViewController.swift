//
//  ReloadViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-22.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class ReloadViewController: UIViewController {

    @IBOutlet weak var reloadDataActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initials()
    }
    
    func initials() {
        reloadDataActivityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.dismiss(animated: true, completion: nil)
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

}
