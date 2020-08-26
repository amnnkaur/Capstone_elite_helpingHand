//
//  PayTableViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-26.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PayTableViewController: UITableViewController {
    
    var db = Firestore.firestore()
    var paymentDueArray = [PaymentDue]()
    var userList: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
          // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
                self.navigationItem.title = "Payment"
        //        self.navigationController?.title
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(doneBarButton))
        
        loadData()
        checkForUpdates()
            }

            @objc func doneBarButton(){
                self.dismiss(animated: true, completion: nil)
            }

    
    
    func loadData(){
        userList = DataStorage.getInstance().getAllUsers()
        db.collection("paymentStatus").whereField("taskEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").getDocuments() {
                  (querySnapshot, error) in
                  if let error = error {
                      print("\(error.localizedDescription)")
                  }else{
                    guard let queryCount = querySnapshot?.documents.count else { return }
                    if queryCount == 0{
//                        self.displayAlert(title: "Hurray🎊", message: "All tasks are sorted. You have no in due tasks", flag: 0)

                    }else if queryCount >= 1{
                    for doc in querySnapshot!.documents{

                        let paymentDue = PaymentDue(dictionary: doc.data())
                        self.paymentDueArray.append(paymentDue)
                        }
                    }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                      }
                  }
              }
    }
    
    func checkForUpdates(){
        
        db.collection("paymentStatus").whereField("taskEmail", isEqualTo: Auth.auth().currentUser?.email ?? "No user").whereField("timeStamp", isLessThan: Date())
                 .addSnapshotListener {
                     querySnapshot, error in
                     
                     guard let snapshot = querySnapshot else {return}
                     
                     snapshot.documentChanges.forEach {
                         diff in
                         
                         if diff.type == .added {
                             self.paymentDueArray.append(PaymentDue(dictionary: diff.document.data()))
                             DispatchQueue.main.async {
                                 self.tableView.reloadData()
                             }
                         }
                     }
                     
             }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return paymentDueArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "payCell", for: indexPath) as! PayTableViewCell

        cell.payTableViewCellDelegate = self
        let paymentDue = paymentDueArray[indexPath.row]
        
        for item in self.userList{
            if paymentDue.userEmail == item.emailId{
                cell.name.text = "Payment to: \(item.firstName.capitalizingFirstLetter())"
            }
        }
        
        cell.jobTitle.text = paymentDue.taskName
       
        cell.hours.text = "Total Hours: \(paymentDue.taskHours)"
        cell.amount.text = "Amount: $\(paymentDue.calculatedAmount)"

        cell.payBtn.backgroundColor = .clear
        cell.payBtn.layer.borderWidth = 2
        cell.payBtn.layer.borderColor = UIColor.orange.cgColor
        cell.payBtn.layer.cornerRadius = 10
        return cell
    }


   
}

extension PayTableViewController: PayTableViewCellDelegate{
    func toDoPayCell(cell: PayTableViewCell, didTappedThe button: UIButton?) {
       
        if button == cell.payBtn{
            print("pay")
            
        }
    }
    
    
}
