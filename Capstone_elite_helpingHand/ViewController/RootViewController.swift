//
//  ViewController.swift
//  Capstone_elite_helpingHand
//
//  Created by Aman Kaur on 2020-08-09.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit
import SwiftUI
import UserNotifications

class RootViewController: UIViewController, ATCWalkthroughViewControllerDelegate {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    let walkthroughs = [
      ATCWalkthroughModel(title: "Quick Overview", subtitle: "Quickly visualize important business metrics. The overview in the home tab shows the most important metrics to monitor how your business is doing in real time.", icon: "bell-icon"),
      ATCWalkthroughModel(title: "Analytics", subtitle: "Dive deep into charts to extract valuable insights and come up with data driven product initiatives, to boost the success of your business.", icon: "bell-icon"),
      ATCWalkthroughModel(title: "Dashboard Feeds", subtitle: "View your sales feed, orders, customers, products and employees.", icon: "bell-icon"),
      ATCWalkthroughModel(title: "Get Notified", subtitle: "Receive notifications when critical situations occur to stay on top of everything important.", icon: "bell-icon"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initials()
        notificationsCall()
    }

    func initials(){
//        let walkthroughVC = self.walkthroughVC()
//        walkthroughVC.delegate = self
//        self.addChildViewControllerWithView(walkthroughVC)
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.cornerRadius = 8.0
        loginBtn.layer.borderColor = UIColor.darkGray.cgColor
        
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.cornerRadius = 8.0
        signUpBtn.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func walkthroughViewControllerDidFinishFlow(_ vc: ATCWalkthroughViewController) {
      UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromLeft, animations: {
        vc.view.removeFromSuperview()
        let viewControllerToBePresented = UIViewController()
        self.view.addSubview(viewControllerToBePresented.view)
      }, completion: nil)
    }
    
    fileprivate func walkthroughVC() -> ATCWalkthroughViewController {
      let viewControllers = walkthroughs.map { ATCClassicWalkthroughViewController(model: $0, nibName: "ATCClassicWalkthroughViewController", bundle: nil) }
      return ATCWalkthroughViewController(nibName: "ATCWalkthroughViewController",
                                          bundle: nil,
                                          viewControllers: viewControllers)
    }
    
       
        //MARK: Notification centre
     func notificationsCall() {
            // fire test notification
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                // schedule
                NotificationCenter.default.addObserver(self, selector: #selector(self.scheduleNotifications), name: UIApplication.willResignActiveNotification, object: nil)
            }
            else if error != nil {
                print("error occurred")
                }
            })
        }
        

            @objc func scheduleNotifications() {
                
                print("on resign")
//                DataStorage.getInstance().loadTasks()
                
//                var tasks: [Task]
//                tasks = DataStorage.getInstance().getAllTasks()
//                var firstCount: Int
//                firstCount = tasks.count
//                print("First Count: \(firstCount)")
//                tasks.removeAll()
//                DataStorage.getInstance().loadTasks()
//                tasks = DataStorage.getInstance().getAllTasks()
//                var secondCount: Int
//                secondCount = tasks.count
//                 print("Second Count: \(secondCount)")
//                if(secondCount > firstCount){
//                    let formatter = DateFormatter()
//                        formatter.dateStyle = .medium
//                        formatter.timeStyle = .short
//
//                        let content = UNMutableNotificationContent()
//                            content.title = "New Task"
//                            content.sound = .default
//                            content.body = "Description"
//
//                            var dateComponents = DateComponents()
//                            dateComponents.hour = 10
//                            dateComponents.minute = 08
//
//                    //  let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//                        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//                            if error != nil {
//                                print("Error while generating notification: \(error?.localizedDescription)")
//                                    }
//                                })
//                }
//                Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
//                    sleep(10)
//                    self.scheduleNotifications()
              
            }

    @objc func fireTimer() {
        print("Timer fired!")
    }
           

    
    
    @IBAction func loginAction(_ sender: UIButton) {
        
    }
     
}

