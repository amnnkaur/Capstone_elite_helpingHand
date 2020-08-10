//
//  ButtonStyle.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import UIKit

class ButtonStyle: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        backgroundColor     = UIColor.orange
        titleLabel?.font    = UIFont(name: Fonts.avenirNextCondensedDemiBold, size: 22)
        layer.cornerRadius  = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}
