//
//  EditFuelPolicyWrapperViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/16/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import PageMenu
import MBProgressHUD

class EditFuelPolicyWrapperViewController: CardeeViewController {

    var pageMenu: CAPSPageMenu?
    var car: Car!
    var currentRentalType: RentalType!
    var present: DetailRentalViewController!
    
    var dailyFuelPolicyViewController: EditDetailRentalFuelPolicyTableViewController!
    var hourlyFuelPolicyViewController: EditDetailRentalFuelPolicyTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Fuel Policy"
        
        self.currentRentalType = RentalType(rawValue: 0)
        
        var controllerArray = [UIViewController]()
        
        self.dailyFuelPolicyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditDetailRentalFuelPolicyIdentifier") as! EditDetailRentalFuelPolicyTableViewController
        self.dailyFuelPolicyViewController.title = "DAILY"
        self.dailyFuelPolicyViewController.rentalType = .daily
        self.dailyFuelPolicyViewController.car = car
        
        self.hourlyFuelPolicyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditDetailRentalFuelPolicyIdentifier") as! EditDetailRentalFuelPolicyTableViewController
        self.hourlyFuelPolicyViewController.title = "HOURLY"
        self.hourlyFuelPolicyViewController.rentalType = .hourly
        self.hourlyFuelPolicyViewController.car = car
        
        controllerArray.append(self.dailyFuelPolicyViewController)
        controllerArray.append(self.hourlyFuelPolicyViewController)
        
        let parameters: [CAPSPageMenuOption] = [
            .useMenuLikeSegmentedControl(true),
            .menuHeight(40.0),
            .selectionIndicatorHeight(3),
            .selectionIndicatorColor(Color.darkBlue),
            .selectedMenuItemLabelColor(Color.grayText),
            .unselectedMenuItemLabelColor(Color.lightGrayText),
            .scrollMenuBackgroundColor(UIColor.white),
            .menuItemSeparatorColor(UIColor.clear)
        ]
        
        self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
        self.pageMenu!.delegate = self
        
        self.addChildViewController(self.pageMenu!)
        self.view.addSubview(self.pageMenu!.view)
        self.pageMenu?.didMove(toParentViewController: self)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveFuelPolicy))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.present = self.navigationController?.viewControllers[1].childViewControllers[0].childViewControllers[0] as! DetailRentalViewController!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.present.refreshDataOf(car: self.car)
    }

    func saveFuelPolicy() {
        if self.currentRentalType == .daily {
            self.dailyFuelPolicyViewController.saveDailyFuelPolicy()
            self.car = self.dailyFuelPolicyViewController.car
        } else {
            self.hourlyFuelPolicyViewController.saveHourlyFuelPolicy()
            self.car = self.hourlyFuelPolicyViewController.car
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension EditFuelPolicyWrapperViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int){}
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        self.currentRentalType = RentalType(rawValue: index)
        print("Moved to \(index)")
    }
}
