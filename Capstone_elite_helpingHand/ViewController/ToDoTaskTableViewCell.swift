//
//  ToDoTaskTableViewCell.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-24.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit


protocol ToDoTaskTableViewCellDelegate:class {
    func toDoCell(cell:ToDoTaskTableViewCell, didTappedThe button:UIButton?)
}

class ToDoTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var btnTaskStart: UIButton!
    @IBOutlet weak var btnTaskDone: UIButton!
    @IBOutlet weak var requestPaymentButton: UIButton!
    @IBOutlet weak var taskAmount: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    @IBOutlet weak var taskEmail: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     weak var toDoTaskCellDelegate:ToDoTaskTableViewCellDelegate?
    
    @IBAction func startTask(_ sender: UIButton) {
        toDoTaskCellDelegate?.toDoCell(cell: self, didTappedThe: sender as? UIButton)
    }
    
    @IBAction func endTask(_ sender: UIButton) {
          toDoTaskCellDelegate?.toDoCell(cell: self, didTappedThe: sender as? UIButton)
    }
    
    @IBAction func requestPayment(_ sender: UIButton) {
        toDoTaskCellDelegate?.toDoCell(cell: self, didTappedThe: sender as? UIButton)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
