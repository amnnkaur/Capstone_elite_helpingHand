//
//  MyTaskRepliesTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-21.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class MyTaskRepliesTableViewController: UITableViewController {
    
    var task: Task?
    var repliesMessageList: [CustomerMessages] = []
    var filteredList: [CustomerMessages] = []
    var userList: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initials()
        
        
    }
    
    func initials() {
        userList = DataStorage.getInstance().getAllUsers()
        repliesMessageList = DataStorage.getInstance().getAllMessages()
        for item in repliesMessageList {
            if (item.taskEmail == task?.taskEmail && item.taskTitle == task?.taskTitle && item.taskPostingDate == task?.taskDueDate){
                self.filteredList.append(item)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredList.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                      section: Int) -> String? {
        return "Replies for: \(task?.taskTitle ?? "No such task name is there")"
          }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repliesCell", for: indexPath)

        let replies = filteredList[indexPath.row]
        // Configure the cell...
        for item in self.userList {
            if replies.userEmail  == item.emailId {
                cell.textLabel?.text = "\(item.firstName.capitalizingFirstLetter()) \(item.lastName.capitalizingFirstLetter())"
                cell.detailTextLabel?.text = item.emailId
            }
        }
     
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let replies = self.filteredList[indexPath.row]
               
               if let viewController = storyboard?.instantiateViewController(identifier: "ChatVC") as? ChatViewController {
                 
                    viewController.user2Name = replies.taskTitle + " || " + replies.taskEmail
                    viewController.user2UID = replies.userUID
                   
                   
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
