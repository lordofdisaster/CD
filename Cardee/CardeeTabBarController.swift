//
//  CardeeTabBarControllerViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CardeeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 3, 3, 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0.0, -8.0)
        //UITabBarItem.appearance().imageInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = CGFloat(System.tabBarHeight)
        return sizeThatFits
    }
}
