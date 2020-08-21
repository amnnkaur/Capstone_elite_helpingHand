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
    case toDoTasks
    case myTasks
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
    @IBOutlet weak var avatarLabel: UILabel!
    
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
            
                setDefaultImage(name1:item.firstName.capitalizingFirstLetter(),name2: item.lastName.capitalizingFirstLetter())
            }
        }
    }
    
            
    func setDefaultImage(name1: String, name2: String)  {
        avatarLabel.text = String(name1[name1.startIndex])+String( name2[name2.startIndex])
        avatarLabel.backgroundColor = pickColor(alphabet: name1[name1.startIndex])
        avatarLabel.textAlignment = NSTextAlignment.center
        avatarLabel.frame.size = CGSize(width: 50.0, height: 50.0)
        avatarLabel.shadowColor = UIColor.black
        avatarLabel.shadowOffset = CGSize(width: 5, height: 5)
        avatarLabel.isHighlighted = true
        avatarLabel.highlightedTextColor = UIColor.yellow
        avatarLabel.layer.borderWidth = 3
        avatarLabel.layer.borderColor = UIColor.white.cgColor
        avatarLabel.layer.cornerRadius = 50
        avatarLabel.layer.masksToBounds = true
        avatarLabel.isEnabled = true

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
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
        self?.didTapMenuType?(menuType)
        }
    }
}
