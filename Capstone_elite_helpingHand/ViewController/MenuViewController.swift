//
//  MenuViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-19.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case home
    case myTasks
    case toDoTasks
    case logout
}

class MenuViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var userName: String?
//    var ref = Database.database().reference()
    var userList: [User] = []
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var didTapMenuType: ((MenuType) -> Void)?

    @IBOutlet weak var menuView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()

                 gradientLayer.frame = menuView.bounds
                 gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
                 gradientLayer.startPoint = CGPoint(x: 0, y: 0.4)
                 gradientLayer.opacity = 0.7
                self.menuView.layer.insertSublayer(gradientLayer, at: 0)
        
        userName = defaults.string(forKey: "userName") ?? "noUserFound"
        userList = DataStorage.getInstance().getAllUsers()
        for item in userList{
            if item.emailId == userName{
                self.nameLabel.text = "\(item.firstName.capitalizingFirstLetter()) \(item.lastName.capitalizingFirstLetter())"
                self.addressLabel.text = item.street
                self.cityLabel.text = "\(item.city), \(item.postal)"
            }
        }

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
