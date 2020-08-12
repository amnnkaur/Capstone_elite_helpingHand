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
    private init (){}
    
    static func getInstance() -> DataStorage{
        return instance
    }
    
    //User
    
    func addUser(user: User){
        self.userList.append(user)
    }
    // Fetch all Persons
    
    func getAllUsers() -> [User]{
        return self.userList
    }
    
    // Getting data from Firebase
    
    func loadUser() {
        let userRefer = self.ref.child("users")
        userRefer.observeSingleEvent(of: .value, with: {(snapshot)
            in
            if let userDict = snapshot.value as? [String: [String: String]]{
                for value in userDict.values{
                        self.userList.append(User(id: "1", firstName: value["firstName"] ?? "", lastName: value["lastName"] ?? "", mobileNumber: value["contact"] ?? "", emailId: value["email"] ?? "", password: value["password"] ?? "", state: value["state"] ?? "", street: value["street"] ?? "", postal: value["postal"] ?? "", city: value["city"] ?? ""))
                }
            }
        })
    }
}
