//
//  MyTaskTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-20.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
//import FirebaseAuth

class MyTaskTableViewController: UITableViewController {
    
    var userTasks: [Task] = []
    @IBOutlet weak var postedBy: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobDesc: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTasks = DataStorage.getInstance().getAllUserTask()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        userTasks.removeAll()
        userTasks = DataStorage.getInstance().getAllUserTask()
        self.tableView.reloadData()
       }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                   section: Int) -> String? {
          return "Tasks posted by you:"
       }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.userTasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "myTaskCell") as! TaskTableViewCell
        
        let task = self.userTasks[indexPath.row]
        
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundColorView
//        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowRadius = 5

        cell.layer.cornerRadius = 20
//        cell.layer.shadowOpacity = 0.40
        cell.layer.masksToBounds = true;
        cell.clipsToBounds = false;
        
        cell.postedBy.text = task.taskEmail
        cell.jobTitle.text = task.taskTitle
        cell.jobDesc.text = task.taskDesc
        cell.postedDate.text = task.taskDueDate
        
        return cell
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = userTasks[indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "myTasksRepliesVC") as? MyTaskRepliesTableViewController{
            viewController.task = task
            present(viewController, animated: true, completion: nil)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
