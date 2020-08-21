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
    private lazy var userTaskList: [Task] = []
    private lazy var taskMessageList: [CustomerMessages] = []
    private lazy var favoriteTasksList: [FavoiteTasks] = []
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
    
    func addUserTask(userTask: Task){
        self.userTaskList.append(userTask)
    }
    
    func addFavoriteTask(favTask: FavoiteTasks){
        self.favoriteTasksList.append(favTask)
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
    
    func getAllUserTask() -> [Task] {
        return self.userTaskList
    }
    
    func getAllFavoriteTask() -> [FavoiteTasks] {
        return self.favoriteTasksList
    }
    
    func removeAllTasks() {
        self.taskList.removeAll()
    }
    
    func removeAllUserTask() {
        self.userTaskList.removeAll()
    }
    
    func removeUserFavTaskList(){
        self.favoriteTasksList.removeAll()
    }
    
    func removeAllData(){
        self.userList.removeAll()
        self.taskList.removeAll()
        self.taskMessageList.removeAll()
        self.favoriteTasksList.removeAll()
    }
    // Getting data from Firebase
    
    func loadData() {
        let userRefer = self.ref.child("users")
        userRefer.observeSingleEvent(of: .value, with: {(snapshot)
            in
            if let userDict = snapshot.value as? [String: [String: String]]{
                for value in userDict.values{
                    self.userList.append(User(id: "1", firstName: value["firstName"] ?? "", lastName: value["lastName"] ?? "", mobileNumber: value["contact"] ?? "", emailId: value["email"] ?? "", password: value["password"] ?? "", radius: value["radius"] ?? "0km", street: value["street"] ?? "", postal: value["postal"] ?? "", city: value["city"] ?? ""))
                }
            }
        })
        
        let taskRefer = self.ref.child("tasks")
        taskRefer.observeSingleEvent(of: .value, with: {(snapshot)
            in
            if let taskDict = snapshot.value as? [String: [String: String]]{
                for value in taskDict.values{
                    self.taskList.append(Task(taskID: value["taskID"] ?? "", taskTitle: value["taskName"] ?? "", taskDesc: value["taskDescription"] ?? "", taskDueDate: value["date"] ?? "", tasktype: value["type"] ?? "", taskAddress: value["address"] ?? "", taskPay: value["amount"] ?? "", taskEmail: value["taskEmail"] ?? "", taskLat: value["taskLat"] ?? "0.0", taskLong: value["taskLong"] ?? "0.0", taskContact: value["contact"] ?? "", taskCity: value["city"] ?? "", taskPostalCode: value["postalCode"] ?? ""))
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
    
    func loadUserList(userName: String){
        let userTaskRefer = self.ref.child("tasks")
             userTaskRefer.observeSingleEvent(of: .value, with: {(snapshot)
                 in
                 if let userTaskDict = snapshot.value as? [String: [String: String]]{
                     for value in userTaskDict.values{
                        if(value["taskEmail"] == userName){
                         self.userTaskList.append(Task(taskID: value["taskID"] ?? "", taskTitle: value["taskName"] ?? "", taskDesc: value["taskDescription"] ?? "", taskDueDate: value["date"] ?? "", tasktype: value["type"] ?? "", taskAddress: value["address"] ?? "", taskPay: value["amount"] ?? "", taskEmail: value["taskEmail"] ?? "", taskLat: value["taskLat"] ?? "0.0", taskLong: value["taskLong"] ?? "0.0", taskContact: value["contact"] ?? "", taskCity: value["city"] ?? "", taskPostalCode: value["postalCode"] ?? ""))
                    }
                }
            }
        })
    }
    
    func loadUserFavTasks(userName: String){
        let favTasksRefer = self.ref.child("favoriteTasks")
            favTasksRefer.observeSingleEvent(of: .value, with: {(snapshot) in
                if let favTasksDict = snapshot.value as? [String: [String: String]]{
                    for value in favTasksDict.values{
                         if(value["userEmail"] == userName){
                        self.favoriteTasksList.append(FavoiteTasks(taskID: value["taskID"] ?? "", taskTitle: value["taskName"] ?? "", taskDueDate: value["dueDate"] ?? "", taskEmail: value["taskEmail"] ?? "", userId: value["userID"] ?? "", userEmail: value["userEmail"] ?? ""))
                 
                        }
                    }
                }
            })
    }
}
