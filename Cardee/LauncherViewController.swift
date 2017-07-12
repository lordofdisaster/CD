//
//  LauncherViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/29/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class LauncherViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var scrollView: UIScrollView!
    var firstSplash: UIImageView!
    var secondSplash: UIImageView!
    var thirdSplash: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let widthBounds = self.view.bounds.width
        let heightBounds = self.view.bounds.height
        
        self.pageControl.frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
        
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.frame = self.view.frame
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        self.scrollView.contentSize = CGSize(width: self.view.bounds.size.width * 3, height: heightBounds/2)
        
        self.firstSplash = UIImageView()
        self.firstSplash.frame = CGRect(x: 0, y: 0, width: widthBounds, height: heightBounds)
        self.firstSplash.contentMode = .scaleAspectFill
        self.firstSplash.image = #imageLiteral(resourceName: "splash_background")
        self.scrollView.addSubview(self.firstSplash)
        
        self.secondSplash = UIImageView()
        self.secondSplash.frame = CGRect(x: widthBounds, y: 0, width: widthBounds, height: heightBounds)
        self.secondSplash.contentMode = .scaleAspectFill
        self.secondSplash.image = #imageLiteral(resourceName: "splash_background")
        self.scrollView.addSubview(self.secondSplash)
        
        self.thirdSplash = UIImageView()
        self.thirdSplash.frame = CGRect(x: widthBounds * 2, y: 0, width: widthBounds, height: heightBounds)
        self.thirdSplash.contentMode = .scaleAspectFill
        self.thirdSplash.image = #imageLiteral(resourceName: "splash_background")
        self.scrollView.addSubview(self.thirdSplash)
        
        self.view.bringSubview(toFront: self.loginButton)
        self.view.bringSubview(toFront: self.signupButton)
    }
    
    @IBAction func openLoginScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginScreen", sender: self)
    }

    @IBAction func openSignUpScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "showSignUpScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSignUpScreen" {
            if let loginViewController = segue.destination as? LoginViewController {
                loginViewController.showSignUpScreen = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension LauncherViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        if (xOffset < 1.0) {
            self.pageControl.currentPage = 0
        } else if (xOffset < self.view.bounds.width + 1) {
            self.pageControl.currentPage = 1
        } else {
            self.pageControl.currentPage = 2
        }
    }
}


