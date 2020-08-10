//
//  NetworkManager.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-10.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var jobReults = [JobResults(id: "", type: "", url: "", createdAt: "", company: "", companyUrl: "", location: "", title: "", welcomeDescription: "", howToApply: "", companyLogo: "")]
    
    let urlString = "https://jobs.github.com/positions.json?description=mobile&full_time=true&location=sf"
    
    init() {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([JobResults].self, from: data)
                
                DispatchQueue.main.async {
                    self.jobReults = result
                }
            } catch {
                print("Oops... \(error)")
            }
        }.resume()
    }
}

