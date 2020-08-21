//
//  OnboardingViewController.swift
//  navDrawer
//
//  Created by Aman Kaur on 2020-08-21.
//  Copyright © 2020 Aman Kaur. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var btnGetStarted: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles = ["GET TASKS DONE","VARIETY OF SERVICES","GET PAID", "SIMPLIFIED COMMUNICATION"]
    var descs = ["The convenient and fast way of getting around the house tasks done ","Post ads for a range of services from home assembly to hauling","Easy to earn money by completing tasks whenever you are free", "Easily communicate and schedule meeting with your helper"]
    var imgs = ["tasks","services","payment", "communication"]
    
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layoutIfNeeded()
//        self.btnGetStarted.applyGradient(colors: [UIColor.red.cgColor, UIColor.orange.cgColor])
//        self.btnGetStarted.layer.cornerRadius = 10
        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)
            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:400,height:400)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
                     
                       let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
                       txt1.textAlignment = .center
                       txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
                    txt1.textColor = UIColor.orange
                       txt1.text = titles[index]

                       let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:50))
                       txt2.textAlignment = .center
                       txt2.numberOfLines = 3
                       txt2.font = UIFont.systemFont(ofSize: 18.0)
                       txt2.text = descs[index]

                       slide.addSubview(imageView)
                       slide.addSubview(txt1)
                       slide.addSubview(txt2)
                       scrollView.addSubview(slide)
            }

                   //set width of scrollview to accomodate all the slides
                   scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

                   //disable vertical scroll/bounce
                   self.scrollView.contentSize.height = 1.0

                   //initial state
                   pageControl.numberOfPages = titles.count
                   pageControl.currentPage = 0

    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            setIndiactorForCurrentPage()
        }

        func setIndiactorForCurrentPage()  {
            let page = (scrollView?.contentOffset.x)!/scrollWidth
            pageControl?.currentPage = Int(page)
        
    }
    
    @IBAction func getStartedBtn(_ sender: UIButton) {
        
      let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "rootVC") as! RootViewController
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = viewController
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIButton
{
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.4)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.opacity = 0.7
    }
}
