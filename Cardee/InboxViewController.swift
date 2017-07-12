//
//  InboxViewViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 7/3/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class InboxViewController: CardeeViewController {

    var pageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Color.darkBlue
        
        var controllerArray = [UIViewController]()
        
        let alertsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertsViewControllerIdentifier") as! AlertsViewController
        alertsViewController.title = "Alerts"
        
        let chatsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatsViewControllerIdentifier") as! ChatsViewController
        chatsViewController.title = "Chats"
        
        controllerArray.append(alertsViewController)
        controllerArray.append(chatsViewController)
        
        let parameters: [CAPSPageMenuOption] = [
            .useMenuLikeSegmentedControl(true),
            .menuHeight(44.0),
            .selectionIndicatorHeight(3),
            .selectionIndicatorColor(UIColor.white),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)),
            .scrollMenuBackgroundColor(Color.darkBlue),
            .menuItemSeparatorColor(UIColor.clear)
        ]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 20.0, width: self.view.frame.width, height: self.view.frame.height - 20.0), pageMenuOptions: parameters)
        self.pageMenu!.delegate = self
        
        self.addChildViewController(self.pageMenu!)
        self.view.addSubview(self.pageMenu!.view)
        self.pageMenu?.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension InboxViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int){}
    func didMoveToPage(_ controller: UIViewController, index: Int){}
}
