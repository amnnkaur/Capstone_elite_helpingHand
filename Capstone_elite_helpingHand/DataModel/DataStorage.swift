//
//  DataStorage.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-12.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataStorage{
    var ref = Database.database().reference()
    private static let instance = DataStorage()
    private lazy var userList: [User] = []
    private lazy var taskList: [Task] = []
    private lazy var taskMessageList: [CustomerMessages] = []
    private init (){}
    
    static func getInstance() -> DataStorage{
        return instance
    }
    //MARK: Add into list
    //User
    func addUser(user: User){
        self.userList.append(user)
    }
    
    //tasks
    func addTask(task: Task){
        self.taskList.append(task)
    }
    
    func addTaskMessage(customerMessage: CustomerMessages){
        self.taskMessageList.append(customerMessage)
    }
    
    //MARK: get list
    //user
    func getAllUsers() -> [User]{
        return self.userList
    }
    
    //task
    func getAllTasks() -> [Task] {
        return self.taskList
    }
    
    func getAllMessages() -> [CustomerMessages]{
        return self.taskMessageList
    }
    
    // Getting data from Firebase
    
    func loadData() {
        let userRefer = self.ref.child("users")
        userRefer.observeSingleEvent(of: .value, with: {(snapshot)
            in
            if let userDict = snapshot.value as? [String: [String: String]]{
                for value in userDict.values{
                        self.userList.append(User(id: "1", firstName: value["firstName"] ?? "", lastName: value["lastName"] ?? "", mobileNumber: value["contact"] ?? "", emailId: value["email"] ?? "", password: value["password"] ?? "", state: value["state"] ?? "", street: value["street"] ?? "", postal: value["postal"] ?? "", city: value["city"] ?? ""))
                }
            }
        })
        
        let taskRefer = self.ref.child("tasks")
        taskRefer.observeSingleEvent(of: .value, with: {(snapshot)
            in
            if let taskDict = snapshot.value as? [String: [String: String]]{
                for value in taskDict.values{
                    self.taskList.append(Task(taskID: "2", taskTitle: value["taskName"] ?? "", taskDesc: value["taskDescription"] ?? "", taskPostingDate: value["date"] ?? "", tasktype: value["type"] ?? "", taskLocation: "L6X4N3", taskPay: value["amount"] ?? "", taskTime: value["contact"] ?? ""))
                }
            }
        })
        
        let messageRefer = self.ref.child("messages")
              messageRefer.observeSingleEvent(of: .value, with: {(snapshot)
                  in
                  if let messageDict = snapshot.value as? [String: [String: String]]{
                      for value in messageDict.values{
                          self.taskMessageList.append(CustomerMessages(taskUID: value["taskUID"] ?? "", taskTitle: value["taskTitle"] ?? "", taskPostingDate: value["date"] ?? "", taskEmail: value["taskEmail"] ?? "", userUID: value["userUID"] ?? "" , userEmail: value["userEmail"] ?? ""))
                      }
                  }
              })
    }
    
    func loadTasks(){
      /*  let taskRefer = self.ref.child("tasks")
              taskRefer.observeSingleEvent(of: .value, with: {(snapshot)
                  in
                  if let taskDict = snapshot.value as? [String: [String: String]]{
                      for value in taskDict.values{
                          self.taskList.append(Task(taskID: "2", taskTitle: value["taskName"] ?? "", taskDesc: value["taskDescription"] ?? "", taskPostingDate: value["date"] ?? "", tasktype: value["type"] ?? "", taskLocation: "L6X4N3", taskPay: value["amount"] ?? "", taskTime: value["contact"] ?? ""))
                      }
                  }
              }) */
        let taskrefer = self.ref.child("tasks")
        taskrefer.observe(DataEventType.childAdded) { (snapshot) in
            print("child added: \(snapshot.childrenCount)")
            
        }
    }
}
