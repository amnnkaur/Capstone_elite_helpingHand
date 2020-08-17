//
//  TaskListViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-11.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
//     var tasks : [Task] = []
//    var savedTask: [Task] = []
    var filteredTasks: [Task] = []
    @IBOutlet weak var jobTableView: UITableView!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var srchView: UIView!
    var image = UIImage(named: "searchicon.png")
    
    @IBOutlet weak var searchTxt: UITextField!
    
    let defaults = UserDefaults.standard
    var userName: String?
    var ref = Database.database().reference()
     var userList: [User] = []
    var taskList: [Task] = []
    
    //MARK: View did load()
    override func viewDidLoad() {
        super.viewDidLoad()
        initials()
        
        

    }
    
    func initials(){
        
        print("Current user: \(Auth.auth().currentUser?.email)")
        userName = defaults.string(forKey: "userName") ?? "noUserFound"
        userList = DataStorage.getInstance().getAllUsers()
        taskList = DataStorage.getInstance().getAllTasks()
        for item in userList{
            if item.emailId == userName{
                self.headerLabel.text = " Welcome, \(item.firstName.capitalizingFirstLetter())"
            }
        }
    
        for item in taskList{
                  if item.taskEmail != Auth.auth().currentUser!.email{
                      self.filteredTasks.append(item)
                }
        }
             
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
        searchTxt.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
            

    }
    
   @objc func searchTextChanged(_ sender: UITextField) {
        let search = sender.text ?? ""
        filterContentForSearchText(search)
    }

    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
//        filtered.removeAll()
//        filtered = original.filter { thing in
//            return "\(thing.value.lowercased())".contains(searchText.lowercased())
//        }
//        jobTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskList.removeAll()
         filteredTasks.removeAll()
    taskList = DataStorage.getInstance().getAllTasks()
       for item in taskList{
                  if item.taskEmail != Auth.auth().currentUser!.email{
                      self.filteredTasks.append(item)
                }
        }
         self.jobTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
        
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
                
                let task = self.filteredTasks[indexPath.row]
                
                
                cell.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowRadius = 5

                cell.layer.cornerRadius = 20
                cell.layer.shadowOpacity = 0.40
                cell.layer.masksToBounds = true;
                cell.clipsToBounds = false;
                
                cell.postedBy.text = task.taskTime
                cell.jobTitle.text = task.taskTitle
                cell.jobDesc.text = task.taskDesc
                cell.postedDate.text = task.taskPostingDate
                
                return cell
            }
            
            func tableView(_ tableView: UITableView,
                     contextMenuConfigurationForRowAt indexPath: IndexPath,
                     point: CGPoint) -> UIContextMenuConfiguration? {
            
                    let message = UIAction(title: "Ignite this", image: UIImage(systemName: "message"),
                                           attributes: .init()) { _ in
                                            DataStorage.getInstance().addTaskMessage(customerMessage: CustomerMessages(taskUID: self.filteredTasks [indexPath.row].taskID, taskTitle: self.filteredTasks[indexPath.row].taskTitle, taskPostingDate: self.filteredTasks[indexPath.row].taskPostingDate, taskEmail: self.filteredTasks[indexPath.row].taskEmail, userUID: Auth.auth().currentUser?.uid ?? "no uid found", userEmail: Auth.auth().currentUser?.email ?? "no email found"))
                        let insert = ["taskTitle": self.filteredTasks[indexPath.row].taskTitle, "taskUID":self.filteredTasks[indexPath.row].taskID, "taskEmail": self.filteredTasks[indexPath.row].taskEmail, "date": self.filteredTasks[indexPath.row].taskPostingDate, "userUID": Auth.auth().currentUser?.uid ?? "no uid found", "userEmail": Auth.auth().currentUser?.email ?? "no email found"]
                          guard let key = self.ref.child("messages").childByAutoId().key else {return}
                          let childUpdates = ["/messages/\(key)": insert]
                          self.ref.updateChildValues(childUpdates)
                
                }
                
//                    let save = UIAction(title: "Save", image: UIImage(systemName: "trash"),
//                                    attributes: .init()) { _ in
//                              }
                
                     return UIContextMenuConfiguration(identifier: nil,
                       previewProvider: nil) { _ in
                       UIMenu(title: "Actions", children: [ message])
                     }
                   }

    
        }
