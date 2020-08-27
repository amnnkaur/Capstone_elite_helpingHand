//
//  FavTasksTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Anmol singh on 2020-08-21.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ToDoTasksTableViewController: UITableViewController {
    
//    var favTaskList: [FavoiteTasks] = []
    
    var db = Firestore.firestore()
    var taskStatusArray = [TaskStatus]()
    
    @IBOutlet weak var endTaskBtn: UIButton!
    @IBOutlet weak var startTaskBtn: UIButton!
    var startTimeString: String = ""
    var totalWorkingHours: String = ""
    var totalAmountAccHours: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        favTaskList = DataStorage.getInstance().getAllFavoriteTask()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadData()
        checkForUpdates()
    self.navigationItem.title = "To-Do Tasks"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneBarButton))
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewwilldis")
        self.startTimeString = ""
        self.totalWorkingHours = ""
        self.totalAmountAccHours = ""
    }

  
    
    @objc func doneBarButton(){
               self.dismiss(animated: true, completion: nil)
           }
    func loadData(){
        db.collection("taskStatus").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").getDocuments() {
                  (querySnapshot, error) in
                  if let error = error {
                      print("\(error.localizedDescription)")
                  }else{
                    guard let queryCount = querySnapshot?.documents.count else { return }
                    if queryCount == 0{
                        self.displayAlert(title: "Hurray🎊", message: "All tasks are sorted. You have no in due tasks", flag: 0)

                    }else if queryCount >= 1{
                    for doc in querySnapshot!.documents{

                        let taskStatus = TaskStatus(dictionary: doc.data())
                        self.taskStatusArray.append(taskStatus)
                        }
                    }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                      }
                  }
              }
    }
    
    func checkForUpdates(){
        
        db.collection("taskStatus").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").whereField("timeStamp", isLessThan: Date())
                 .addSnapshotListener {
                     querySnapshot, error in
                     
                     guard let snapshot = querySnapshot else {return}
                     
                     snapshot.documentChanges.forEach {
                         diff in
                         
                         if diff.type == .added {
                             self.taskStatusArray.append(TaskStatus(dictionary: diff.document.data()))
                             DispatchQueue.main.async {
                                 self.tableView.reloadData()
                             }
                         }
                     }
                     
             }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskStatusArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favTaskCell", for: indexPath) as! ToDoTaskTableViewCell

        let taskStatus = self.taskStatusArray[indexPath.row]
        // Configure the cell...
//        cell.textLabel?.text = "\(taskStatus.taskName), \(taskStatus.taskEmail) "
//        cell.detailTextLabel?.text = "\(taskStatus.timeStamp)"
        if(taskStatus.status == "inProgress"){
            cell.btnTaskStart.isHidden = false
            cell.btnTaskDone.isHidden = true
            cell.requestPaymentButton.isHidden = true
        }else if (taskStatus.status == "started"){
            cell.btnTaskStart.isHidden = true
            cell.btnTaskDone.isHidden = false
            cell.requestPaymentButton.isHidden = true
        }else if(taskStatus.status == "done"){
            cell.btnTaskStart.isHidden = true
            cell.btnTaskDone.isHidden = true
            cell.requestPaymentButton.isHidden = false
        }else if(taskStatus.status == "completed"){
            cell.btnTaskStart.isHidden = true
            cell.btnTaskDone.isHidden = true
            cell.requestPaymentButton.isHidden = true
        }
        cell.taskTitle.text = taskStatus.taskName
        cell.taskEmail.text = taskStatus.taskEmail
        cell.taskAmount.text = taskStatus.taskAmount
        cell.daysLeft.text = self.calculateDaysLeft(taskDate: taskStatus.taskDueDate)
        cell.toDoTaskCellDelegate =  self
        return cell
    }
    
    func calculateDaysLeft(taskDate: String) -> String {
          let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
        let taskDate = dateFormatter.date(from: taskDate)!
                          
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: taskDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return "\(components.day ?? 0) days left"

    }

    func displayAlert(title: String, message: String, flag: Int){
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true)
      }
    func updateTaskStatusInFireStore(taskStatus: TaskStatus, flag: Int) {
        if flag == 0{

            self.db.collection("taskStatus").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").whereField("taskEmail", isEqualTo: taskStatus.taskEmail).whereField("taskDueDate", isEqualTo: taskStatus.taskDueDate).whereField("taskName", isEqualTo: taskStatus.taskName).whereField("taskId", isEqualTo: taskStatus.taskId).limit(to: 1).getDocuments() { (querySnapshot, err) in
                   if let err = err {
                     self.displayAlert(title: "Error!", message: "\(err.localizedDescription)", flag: 0)
                    print("Error getting documents: \(err)")
                   } else {
                       for document in querySnapshot!.documents {
                        document.reference.updateData([
                            "status": "started",
                            "taskHours": "\(self.startTimeHour())"
                        ])
                       }
        }
    }
        }else if flag == 1{
            
    self.db.collection("taskStatus").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").whereField("taskEmail", isEqualTo: taskStatus.taskEmail).whereField("taskDueDate", isEqualTo: taskStatus.taskDueDate).whereField("taskName", isEqualTo: taskStatus.taskName).whereField("taskId", isEqualTo: taskStatus.taskId).limit(to: 1).getDocuments() { (querySnapshot, err) in
                           if let err = err {
                            self.displayAlert(title: "Error!", message: "\(err.localizedDescription)", flag: 0)
                               print("Error getting documents: \(err)")
                           } else {
                               for document in querySnapshot!.documents {
                                document.reference.updateData([
                                    "status": "done",
                                    "taskHours": "\(self.totalWorkingHours)",
                                    "calculatedAmount": "\(self.totalAmountAccHours)"
                                ])
                               }
                }
            }
            
        }else if flag == 2{
                
        self.db.collection("taskStatus").whereField("userEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").whereField("taskEmail", isEqualTo: taskStatus.taskEmail).whereField("taskDueDate", isEqualTo: taskStatus.taskDueDate).whereField("taskName", isEqualTo: taskStatus.taskName).whereField("taskId", isEqualTo: taskStatus.taskId).limit(to: 1).getDocuments() { (querySnapshot, err) in
                               if let err = err {
                                self.displayAlert(title: "Error!", message: "\(err.localizedDescription)", flag: 0)
                                   print("Error getting documents: \(err)")
                               } else {
                                   for document in querySnapshot!.documents {
                                    document.reference.updateData([
                                        "status": "completed"
                                ])
                        }
                    }
                }
                
            }
    }
    
    func startTimeHour() -> String {
        self.startTimeString = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        self.startTimeString = formatter.string(from: Date())
        return formatter.string(from: Date())
    }

    func calculateWorkingHours(startTime: String, taskAmount: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        
        let time1 = startTime
        let time2 = formatter.string(from: Date())

        let date1 = formatter.date(from: time1) ?? formatter.date(from: self.startTimeString)!
        let date2 = formatter.date(from: time2)!

        let elapsedTime = date2.timeIntervalSince(date1)


        let hours = floor(elapsedTime / 60 / 60)

        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        var amount: String
        amount = taskAmount.replacingOccurrences(of: "$ ", with: "")
        amount = amount.replacingOccurrences(of: "/hr", with: "")
        var amountValue: Double
        let hoursValue = Float(amount)! * (Float(hours))
        let minuteValue = (Float(amount)!/60) * (Float(minutes))
        amountValue = Double(hoursValue + minuteValue)
        
        self.totalWorkingHours = "\(Int(hours)) hr and \(Int(minutes)) min"
        self.totalAmountAccHours = "\(String(format: "%.2f", amountValue))"
        
    }

    func paymentRequestActivity(taskStatus: TaskStatus){
         
        var amount: String
        var hours: String
        
        if(self.totalWorkingHours == "" || self.totalAmountAccHours == ""){
            hours = taskStatus.taskHours
            amount = taskStatus.calculatedAmount
        }else{
            hours = self.totalWorkingHours
            amount = self.totalAmountAccHours
        }
        
     
        
        displayAlert(title: "Payment Request💰", message: "Your request for \(hours) of service, which sums up to: $\(amount) is submitted to the user", flag: 0)
        
        let paymentDue = PaymentDue(taskName: taskStatus.taskName, taskId: taskStatus.taskId, taskEmail: taskStatus.taskEmail, userEmail: taskStatus.userEmail, status: "completed", taskDueDate: taskStatus.taskDueDate, taskHours: hours, taskAmount: taskStatus.taskAmount, calculatedAmount: amount, paymentStatus: "paymentDue")
       var ref: DocumentReference? = nil
        ref = self.db.collection("paymentStatus").addDocument(data: paymentDue.dictionary){
                error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            }else{
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
    }
    
}

extension ToDoTasksTableViewController: ToDoTaskTableViewCellDelegate{
    func toDoCell(cell: ToDoTaskTableViewCell, didTappedThe button: UIButton?) {
        if button == cell.btnTaskStart{
            guard let indexPath = tableView.indexPath(for: cell) else  { return }
            let taskStatus = self.taskStatusArray[indexPath.row]
            self.updateTaskStatusInFireStore(taskStatus: taskStatus, flag: 0)
            cell.btnTaskStart.isHidden = true
            cell.btnTaskDone.isHidden = false
            cell.requestPaymentButton.isHidden = true

        }else if button == cell.btnTaskDone{
            guard let indexPath = tableView.indexPath(for: cell) else  { return }
            let taskStatus = self.taskStatusArray[indexPath.row]
            self.calculateWorkingHours(startTime: taskStatus.taskHours, taskAmount: taskStatus.taskAmount)
            self.updateTaskStatusInFireStore(taskStatus: taskStatus, flag: 1)
            cell.btnTaskStart.isHidden = true
            cell.btnTaskDone.isHidden = true
            cell.requestPaymentButton.isHidden = false

        }else if button == cell.requestPaymentButton{
            guard let indexPath = tableView.indexPath(for: cell) else  { return }
            let taskStatus = self.taskStatusArray[indexPath.row]
            self.paymentRequestActivity(taskStatus: taskStatus)
            self.updateTaskStatusInFireStore(taskStatus: taskStatus, flag: 2)
            cell.btnTaskStart.isHidden = true
            cell.btnTaskDone.isHidden = true
            cell.requestPaymentButton.isHidden = true

        }
       
    }
    
    
}
