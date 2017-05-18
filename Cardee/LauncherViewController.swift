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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageControl.frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
