//
//  ToDoTaskTableViewCell.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-24.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class ToDoTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var btnTaskDone: UIButton!
    @IBOutlet weak var daysLeft: UILabel!
    @IBOutlet weak var taskEmail: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
