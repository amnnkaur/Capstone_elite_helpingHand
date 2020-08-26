//
//  MyTaskRepliesTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-21.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MyTaskRepliesTableViewController: UITableViewController {
    
    var task: Task?
    var repliesMessageList: [CustomerMessages] = []
    var filteredList: [CustomerMessages] = []
    var userList: [User] = []
    
    var db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initials()
        self.navigationItem.title = "\(task?.taskTitle ?? "No Title")"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneBarButton))
}
@objc func doneBarButton(){
            self.dismiss(animated: true, completion: nil)
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
        return filteredList.count
    }
/*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                      section: Int) -> String? {
        return "Replies for: \(task?.taskTitle ?? "No such task name is there")"
          }
   */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repliesCell", for: indexPath) as! MessageTableViewCell

        let replies = filteredList[indexPath.row]
        // Configure the cell...
        for item in self.userList {
            if replies.userEmail  == item.emailId {
                cell.senderLabel.text = "\(item.firstName.capitalizingFirstLetter()) \(item.lastName.capitalizingFirstLetter())"
                cell.repliedForLabel.text = item.emailId
                
                let name1 = item.firstName
                let name2 = item.lastName
                cell.avatarLabel.text = String(name1[name1.startIndex])+String( name2[name2.startIndex])
                cell.avatarLabel.backgroundColor = pickColor(alphabet: name1[name1.startIndex])
                cell.avatarLabel.textAlignment = NSTextAlignment.center
                cell.avatarLabel.frame.size = CGSize(width: 52.0, height: 52.0)
                cell.avatarLabel.shadowColor = UIColor.black
                cell.avatarLabel.isHighlighted = true
                cell.avatarLabel.highlightedTextColor = UIColor.white
                cell.avatarLabel.layer.cornerRadius = 30
                cell.avatarLabel.layer.masksToBounds = true
                cell.avatarLabel.isEnabled = true
            }
        }
     
        return cell
    }
    
    func pickColor(alphabet: Character) -> UIColor {
           let alphabetColors = [0x9A89B5, 0xB2B7BB, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0x5C9BBC, 0xF5888D, 0x9A89B5, 0x407887, 0x5A8770, 0x5A8770, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0xF18636, 0x0087BF, 0xB2B7BB, 0x72ACAE, 0x9C8AB4, 0x5A8770, 0xEEB424, 0x407887]
           let str = String(alphabet).unicodeScalars
           let unicode = Int(str[str.startIndex].value)
           if 65...90 ~= unicode {
               let hex = alphabetColors[unicode - 65]
               return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
           }
           return UIColor.black
       }

   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let replies = self.filteredList[indexPath.row]
               
               if let viewController = storyboard?.instantiateViewController(identifier: "ChatVC") as? ChatViewController {
                 
                viewController.user2Name = replies.taskTitle + " || " + replies.userEmail
                    viewController.user2UID = replies.userUID
                   
                   navigationController?.pushViewController(viewController, animated: true)
//                   present(viewController, animated: true, completion: nil)
               }
    }

    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
              let replies = filteredList[indexPath.row]
        var userEmail: String = ""
        var userId: String = ""
            for item in self.userList {
                if replies.userEmail  == item.emailId {
                    userEmail = item.emailId
                    userId = item.id
            }
        }
        let message = UIAction(title: "Assign task to this user", image: UIImage(systemName: "person.fill"), attributes: .init()) { _ in
            let taskStatus = TaskStatus(taskName: self.task!.taskTitle, taskId: self.task!.taskID, taskEmail: self.task!.taskEmail, userEmail: userEmail, userId: userId, timeStamp: Date().description, status: "inProgress", taskDueDate: self.task!.taskDueDate, taskHours: "0", taskAmount: self.task!.taskPay)
         
      /*
            self.db.collection("taskStatus").whereField("userEmail", isEqualTo: userEmail).whereField("taskEmail", isEqualTo: taskStatus.taskEmail).whereField("taskDueDate", isEqualTo: taskStatus.taskDueDate).whereField("taskName", isEqualTo: taskStatus.taskName).whereField("taskId", isEqualTo: taskStatus.taskId).getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                self.displayAlert(title: "Error", message: "\(err.localizedDescription)", flag: 0)
                             print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    if (document.exists){
                                        print(document.data())
                                        self.displayAlert(title: "Already Assigned", message: "This task is already assigned to helper. Helper is on its way to rescue you😇", flag: 0)
                                     return
                                    }
                  }
            }

        }*/
            
            self.saveToTaskStatusCollection(taskStatus: taskStatus)
         
        }
        return UIContextMenuConfiguration(identifier: nil,
                       previewProvider: nil) { _ in
                          UIMenu(title: "Actions", children: [ message])
               }
    }
    
    func displayAlert(title: String, message: String, flag: Int){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    
    func saveToTaskStatusCollection(taskStatus: TaskStatus) {
        print("saveTo")
        var ref: DocumentReference? = nil
        ref = self.db.collection("taskStatus").addDocument(data: taskStatus.dictionary){
                     error in
                     if let error = error {
                         print("Error adding document: \(error.localizedDescription)")
                     }else{
                         print("Document added with ID: \(ref!.documentID)")
                     }
                 }
        
    }
}
