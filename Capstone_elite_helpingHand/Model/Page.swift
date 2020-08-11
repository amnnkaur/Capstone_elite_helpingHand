//
//  Page.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation

struct Page: Identifiable {
    
    let id: UUID
    let image: String
    let heading: String
    let subSubheading: String

    let placeholder : [String]
    
    let noOfFields : Int
    
    static var getAll: [Page] {
        [
            Page(id: UUID(), image: "screen-1", heading: "Basic Details", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",placeholder:["First name", "Last Name" ,"Email Address", "Contact No.", "Address"],noOfFields: 4),
            Page(id: UUID(), image: "screen-2", heading: "Skills", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",placeholder:["name", "Last Name" ,"Email Address", "Contact No.", "Address"], noOfFields: 3),
            Page(id: UUID(), image: "screen-3", heading: "Setup your goals", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.", placeholder:["First ", "Last Name" ,"Email Address", "Contact No.", "Address"],noOfFields: 2),
            Page(id: UUID(), image: "screen-4", heading: "Verify your details", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.", placeholder:["Firme", "Last Name" ,"Email Address", "Contact No.", "Address"], noOfFields: 1)
            
        ]
    }
}

