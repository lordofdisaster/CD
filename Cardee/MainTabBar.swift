//
//  MainTabBar.swift
//  Cardee
//
//  Created by Leonid Nifantyev on 7/12/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        var newTabBarFrame = self.frame
        
        //set height of tabbar
        let newTabBarHeight: CGFloat = self.frame.height
        
        let offset = newTabBarHeight - self.frame.height
        
        newTabBarFrame.size.height = newTabBarHeight
        newTabBarFrame.origin.y = self.frame.origin.y - offset//newTabBarHeight
        self.backgroundColor = .red
        
        self.frame = newTabBarFrame
    }
    
    

}
