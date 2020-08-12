//
//  TaskListViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
   
     var tasks : [Task]?
    @IBOutlet weak var jobTableView: UITableView!
    
    @IBOutlet weak var srchView: UIView!
    var image = UIImage(named: "searchicon.png")
    
    @IBOutlet weak var searchTxt: UITextField!
    override func viewDidLoad() {
      
    jobTableView.delegate = self
    jobTableView.dataSource = self
                
    let leftImageView = UIImageView()
    leftImageView.image = image
    let leftView = UIView()
    leftView.addSubview(leftImageView)

    searchTxt.leftView = leftView
                
    leftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    leftImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
    searchTxt.leftViewMode = .always
    searchTxt.leftView = leftView
                
    let gradientLayer = CAGradientLayer()

    gradientLayer.frame = srchView.bounds
    gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.4)
    gradientLayer.opacity = 0.7
    self.srchView.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
            
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                // this will turn on `masksToBounds` just before showing the cell
                cell.contentView.layer.masksToBounds = true
                let radius = cell.contentView.layer.cornerRadius
                cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
            }
            
           func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
              let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

                let label = UILabel()
                label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-20, height: headerView.frame.height-20)
            
                label.text = "Recent Jobs"
                headerView.addSubview(label)

               return headerView
            }
            
            func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return 50
            }

            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                
        //        let task = self.tasks![indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") as! TaskTableViewCell
                
                cell.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowRadius = 5

                cell.layer.cornerRadius = 20
                cell.layer.shadowOpacity = 0.40
                cell.layer.masksToBounds = true;
                cell.clipsToBounds = false;
                
                cell.postedBy.text = "John Doe"
                cell.jobTitle.text = "Software Engineer"
                cell.jobDesc.text = "Sftehkaghdga hagkdhjgashgd jgaskjhdgahsd jkgyd"
                cell.postedDate.text = "Aug 24, 2020"
                
                cell.postedBy.text = "John Doe"
                cell.jobTitle.text = "Software Engineer"
                cell.jobDesc.text = "Sftehkaghdga hagkdhjgashgd jgaskjhdgahsd jkgyd"
                cell.postedDate.text = "Aug 24, 2020"
                
                return cell
            }
            
            func tableView(_ tableView: UITableView,
                     contextMenuConfigurationForRowAt indexPath: IndexPath,
                     point: CGPoint) -> UIContextMenuConfiguration? {
            
                    let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"),
                       attributes: .destructive) { _ in
                                     }
                
                    let save = UIAction(title: "Save", image: UIImage(systemName: "trash"),
                                    attributes: .init()) { _ in
                              }
                
                     return UIContextMenuConfiguration(identifier: nil,
                       previewProvider: nil) { _ in
                       UIMenu(title: "Actions", children: [ delete, save])
                     }
                   }

        }
