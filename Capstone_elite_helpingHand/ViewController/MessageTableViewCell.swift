//
//  MessageTableViewCell.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-20.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var repliedForLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

        
}
