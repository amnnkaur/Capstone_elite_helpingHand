//
//  PayTableViewCell.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-26.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

protocol PayTableViewCellDelegate:class {
    func toDoPayCell(cell:PayTableViewCell, didTappedThe button:UIButton?)
}

class PayTableViewCell: UITableViewCell {
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     weak var payTableViewCellDelegate:PayTableViewCellDelegate?
    
    @IBAction func payNowBtn(_ sender: Any) {
        payTableViewCellDelegate?.toDoPayCell(cell:  self, didTappedThe: sender as? UIButton)
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
