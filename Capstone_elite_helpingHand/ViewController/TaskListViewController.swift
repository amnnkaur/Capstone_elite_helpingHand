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
import CoreLocation

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let transiton = SlideInTransition()
    var topView: UIView?
    
    var filteredTasks: [Task] = []
    var filtered: [Task] = []
    var sortedArray: [Task] = []
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var jobTableView: UITableView!
    
    @IBOutlet weak var sortBtn: UIButton!
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
        searchTxt.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        filtered = filteredTasks
        
    }
    
  @objc func searchTextChanged(textField: UITextField) {
    if(textField.text == ""){
        filtered = filteredTasks
        self.jobTableView.reloadData()
    }else{
        let search = textField.text ?? ""
        filterContentForSearchText(search)
        
    }
    }
    
    @IBAction func didTapBtn(_ sender: UIButton) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
               menuViewController.didTapMenuType = { menuType in
                   self.transitionToNew(menuType)
               }
               menuViewController.modalPresentationStyle = .overCurrentContext
               menuViewController.transitioningDelegate = self
               present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType {
        case .myTasks:
            break
        case .toDoTasks:
            break
        case .logout:
             performLogout()
           break
        default:
            break
        }
    }
    
    func performLogout(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "rootVC") as! RootViewController
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = viewController
            do {
                try Auth.auth().signOut()
            } catch let error {
                // handle error here
            print("Error trying to sign out of Firebase: \(error.localizedDescription)")
            }
        //UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filtered.removeAll()
        filtered = filteredTasks.filter { thing in
            return "\(thing.taskTitle.lowercased())".contains(searchText.lowercased())
        }
        print(filtered.count)
        print(filteredTasks.count)
        jobTableView.reloadData()
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
    
    @IBAction func sortByBtn(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Sort By...", message: "", preferredStyle: .actionSheet)
        let titleAction = UIAlertAction(title: "Title", style: .default) { (action) in
            // sort by title
            self.sortByTitle()
        }
        let dateAction = UIAlertAction(title: "Date", style: .default) { (action) in
            //sort by date
            self.sortByDate()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(titleAction)
        actionSheet.addAction(dateAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }
    
    func sortByDate() {
        sortedArray = filtered.sorted{
                    $0.taskDueDate < $1.taskDueDate}
        print(sortedArray)
        filtered = sortedArray
        self.jobTableView.reloadData()
       }
    
    func sortByTitle() {
           sortedArray = filtered.sorted{
                       $0.taskTitle < $1.taskTitle}
           print(sortedArray)
           filtered = sortedArray
           self.jobTableView.reloadData()
          }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtered.count
        
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
                
                let task = self.filtered[indexPath.row]
                
                let backgroundColorView = UIView()
                backgroundColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = backgroundColorView
                cell.layer.shadowOffset = CGSize(width: 0, height: 2)
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowRadius = 5

                cell.layer.cornerRadius = 20
                cell.layer.shadowOpacity = 0.40
                cell.layer.masksToBounds = true;
                cell.clipsToBounds = false;
                
                cell.postedBy.text = task.taskEmail
                cell.jobTitle.text = task.taskTitle
                cell.jobDesc.text = task.taskDesc
                cell.postedDate.text = task.taskDueDate
                
                return cell
            }
            
    func tableView(_ tableView: UITableView,
                     contextMenuConfigurationForRowAt indexPath: IndexPath,
                     point: CGPoint) -> UIContextMenuConfiguration? {
            
                    let message = UIAction(title: "Ignite this", image: UIImage(systemName: "message"),
                                           attributes: .init()) { _ in
                                            DataStorage.getInstance().addTaskMessage(customerMessage: CustomerMessages(taskUID: self.filteredTasks [indexPath.row].taskID, taskTitle: self.filteredTasks[indexPath.row].taskTitle, taskPostingDate: self.filteredTasks[indexPath.row].taskDueDate, taskEmail: self.filteredTasks[indexPath.row].taskEmail, userUID: Auth.auth().currentUser?.uid ?? "no uid found", userEmail: Auth.auth().currentUser?.email ?? "no email found"))
                        let insert = ["taskTitle": self.filteredTasks[indexPath.row].taskTitle, "taskUID":self.filteredTasks[indexPath.row].taskID, "taskEmail": self.filteredTasks[indexPath.row].taskEmail, "date": self.filteredTasks[indexPath.row].taskDueDate, "userUID": Auth.auth().currentUser?.uid ?? "no uid found", "userEmail": Auth.auth().currentUser?.email ?? "no email found"]
                          guard let key = self.ref.child("messages").childByAutoId().key else {return}
                          let childUpdates = ["/messages/\(key)": insert]
                          self.ref.updateChildValues(childUpdates)
                
                }
                return UIContextMenuConfiguration(identifier: nil,
                    previewProvider: nil) { _ in
                       UIMenu(title: "Actions", children: [ message])
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.filtered[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "TaskDetailVC") as! TaskDetailViewController
        viewController.task = task
        print("cityyyy: \(viewController.task.taskCity)")
//            navigationController?.pushViewController(viewController, animated: true)
        present(viewController, animated: true, completion: nil)
    
    }
}
extension TaskListViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
