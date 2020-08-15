//
//  MessagesTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-14.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessagesTableViewController: UITableViewController {

    var tasksMessagesList: [CustomerMessages] = []
    var filteredMessages: [CustomerMessages] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initials()
    }

    func initials(){
        tasksMessagesList = DataStorage.getInstance().getAllMessages()
        for item in tasksMessagesList{
            if item.userUID == Auth.auth().currentUser!.uid || item.taskEmail == Auth.auth().currentUser!.email{
                self.filteredMessages.append(item)
                   }
               }
    }
    override func viewWillAppear(_ animated: Bool) {
        tasksMessagesList.removeAll()
        filteredMessages.removeAll()
       initials()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
    
    @IBAction func reloadTable(_ sender: UIBarButtonItem) {
       
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filteredMessages.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell", for: indexPath)

        let task = self.filteredMessages[indexPath.row]
        
        cell.textLabel?.text = task.taskTitle
        cell.detailTextLabel?.text = task.taskPostingDate

        return cell
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.filteredMessages[indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "ChatVC") as? ChatViewController {
            if (task.taskEmail != Auth.auth().currentUser!.email){
                viewController.user2Name = task.taskTitle + " || " + task.taskEmail
            }
            else{
                viewController.user2Name = task.taskTitle + " || " + task.userEmail
            }
            viewController.user2UID = task.taskUID
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
