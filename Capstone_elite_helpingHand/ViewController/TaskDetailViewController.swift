//
//  TaskDetailViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-19.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var task: Task = Task(taskID: "", taskTitle: "", taskDesc: "", taskDueDate: "", tasktype: "", taskAddress: "", taskPay: "", taskEmail: "", taskLat: "", taskLong: "", taskContact: "", taskCity: "", taskPostalCode: "")

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var taskDetailView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDesc: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    let gradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initials()
        
    }
    
    func initials() {
        gradientLayer.frame = taskDetailView.bounds
        gradientLayer.colors = [UIColor.red.cgColor,UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.4)
        gradientLayer.opacity = 0.7
        self.taskDetailView.layer.insertSublayer(gradientLayer, at: 0)

        favBtn.layer.cornerRadius = 20
        favBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
            msgBtn.contentVerticalAlignment = .fill
            msgBtn.contentHorizontalAlignment = .fill
        
        labelValues()
    }

    func labelValues() {
        self.taskTitle.text = task.taskTitle
        self.taskDesc.text = task.taskDesc
        self.address.text = "\(task.taskAddress), \(task.taskCity), \(task.taskPostalCode)"
        self.contact.text = task.taskContact
        self.date.text = task.taskDueDate
        self.amount.text? = "Amount: \(task.taskPay)"
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
