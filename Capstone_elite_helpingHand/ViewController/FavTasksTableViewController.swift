//
//  FavTasksTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-21.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FavTasksTableViewController: UITableViewController {
    
//    var favTaskList: [FavoiteTasks] = []
    
    var db = Firestore.firestore()
    var taskStatusArray = [TaskStatus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        favTaskList = DataStorage.getInstance().getAllFavoriteTask()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadData()
        checkForUpdates()
       
    }
    
    func loadData(){
        db.collection("taskStatus").getDocuments() {
                  (querySnapshot, error) in
                  if let error = error {
                      print("\(error.localizedDescription)")
                  }else{
                    guard let queryCount = querySnapshot?.documents.count else { return }
                    if queryCount == 0{
                        print("No task in progress")
                    }else if queryCount >= 1{
                    for doc in querySnapshot!.documents{
                        print("Dic: \(doc.data())")
                        let taskStatus = TaskStatus(dictionary: doc.data())
                        self.taskStatusArray.append(taskStatus)
                        }
                    }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                      }
                  }
              }
    }
    
    func checkForUpdates(){
        
        db.collection("taskStatus").whereField("timeStamp", isGreaterThan: Date())
                 .addSnapshotListener {
                     querySnapshot, error in
                     
                     guard let snapshot = querySnapshot else {return}
                     
                     snapshot.documentChanges.forEach {
                         diff in
                         
                         if diff.type == .added {
                             self.taskStatusArray.append(TaskStatus(dictionary: diff.document.data()))
                             DispatchQueue.main.async {
                                 self.tableView.reloadData()
                             }
                         }
                     }
                     
             }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskStatusArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favTaskCell", for: indexPath) as! ToDoTaskTableViewCell

        let taskStatus = self.taskStatusArray[indexPath.row]
        // Configure the cell...
//        cell.textLabel?.text = "\(taskStatus.taskName), \(taskStatus.taskEmail) "
//        cell.detailTextLabel?.text = "\(taskStatus.timeStamp)"
        cell.taskTitle.text = taskStatus.taskName
        cell.taskEmail.text = taskStatus.taskEmail
        
//        let taskDate = taskStatus.timeStamp
//        let todayDate = Date()
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let taskDate = dateFormatter.date(from: taskStatus.timeStamp)!
//
//        let calendar = Calendar.current
//        let currentDate = calendar.startOfDay(for: todayDate)
//        let assignedDate = calendar.startOfDay(for: taskDate)
//
//        let components = calendar.dateComponents([.day], from: currentDate, to: assignedDate)
//
//        cell.daysLeft.text = "\(components.day)"
        

        return cell
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your in-progress tasks:"
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
