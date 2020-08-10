//
//  JobResults.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation

struct JobResults: Codable {
    let id: String
    let type: String
    let url: String
    let createdAt: String
    let company: String
    let companyUrl: String?
    let location: String?
    let title: String
    let welcomeDescription: String?
    let howToApply: String
    let companyLogo: String?
}
