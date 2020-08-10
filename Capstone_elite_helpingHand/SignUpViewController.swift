//
//  SignUpViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FlexibleSteppedProgressBar

class SignUpViewController: UIViewController, FlexibleSteppedProgressBarDelegate {
    
    var progressBarWithoutLastState: FlexibleSteppedProgressBar!
    
    var backgroundColor = UIColor.orange
    var progressColor = UIColor.orange
    var textColorHere = UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    
    var maxIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgressBarWithoutLastState()

    }
    
    func setupProgressBarWithoutLastState() {
           progressBarWithoutLastState = FlexibleSteppedProgressBar()
           progressBarWithoutLastState.translatesAutoresizingMaskIntoConstraints = false
           self.view.addSubview(progressBarWithoutLastState)
           
           // iOS9+ auto layout code
           let horizontalConstraint = progressBarWithoutLastState.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
           let verticalConstraint = progressBarWithoutLastState.topAnchor.constraint(
               equalTo: view.topAnchor,
               constant: 150
           )
           let widthConstraint = progressBarWithoutLastState.widthAnchor.constraint(equalToConstant: 360)
           let heightConstraint = progressBarWithoutLastState.heightAnchor.constraint(equalToConstant: 100)
           NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
           
           // Customise the progress bar here
           progressBarWithoutLastState.numberOfPoints = 4
           progressBarWithoutLastState.lineHeight = 3
           progressBarWithoutLastState.radius = 20
           progressBarWithoutLastState.progressRadius = 25
           progressBarWithoutLastState.progressLineHeight = 3
           progressBarWithoutLastState.delegate = self
           progressBarWithoutLastState.selectedBackgoundColor = progressColor
           progressBarWithoutLastState.selectedOuterCircleStrokeColor = backgroundColor
           progressBarWithoutLastState.currentSelectedCenterColor = progressColor
           progressBarWithoutLastState.stepTextColor = textColorHere
           progressBarWithoutLastState.currentSelectedTextColor = progressColor
           
           progressBarWithoutLastState.currentIndex = 0
           
       }
       
       
       func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                        didSelectItemAtIndex index: Int) {
           progressBar.currentIndex = index
           if index > maxIndex {
               maxIndex = index
               progressBar.completedTillIndex = maxIndex
            

           }
       }
       
       func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                        canSelectItemAtIndex index: Int) -> Bool {
           return true
       }
       
       func progressBar(_ progressBar: FlexibleSteppedProgressBar,
                        textAtIndex index: Int, position: FlexibleSteppedProgressBarTextLocation) -> String {
           if progressBar == self.progressBarWithoutLastState {
               if position == FlexibleSteppedProgressBarTextLocation.top {
                   switch index {
                       
                   case 0: return "Details"
                   case 1: return "Select Skills"
                   case 2: return "Select Location"
                   case 3: return "Verify Info"
                   default: return "Step"
                       
                   }
               } else if position == FlexibleSteppedProgressBarTextLocation.center {
                   switch index {
                       
                   case 0: return "1"
                   case 1: return "2"
                   case 2: return "3"
                   case 3: return "4"
                   default: return "0"
                       
                   }
               }
           }
           return ""
       }

}
