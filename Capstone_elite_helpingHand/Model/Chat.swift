//
//  Chat.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-13.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation
import UIKit

struct Chat {
    
    var users: [String]
    
    var dictionary: [String: Any] {
        return [
            "users": users
        ]
    }
}

extension Chat {
    
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
    
}
