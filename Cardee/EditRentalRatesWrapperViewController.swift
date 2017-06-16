//
//  EditRentalRatesWrapperViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/16/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import PageMenu
import MBProgressHUD

class EditRentalRatesWrapperViewController: CardeeViewController {

    var pageMenu: CAPSPageMenu?
    var car: Car!
    var currentRentalType: RentalType!
    var present: DetailRentalViewController!
    
    var dailyRentalRatesViewController: EditDetailRentalRatesTableViewController!
    var hourlyRentalRatesViewController: EditDetailRentalRatesTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Rental Rates"
        
        self.currentRentalType = RentalType(rawValue: 0)
        
        var controllerArray = [UIViewController]()
        
        self.dailyRentalRatesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditDetailRentalRatesIdentifier") as! EditDetailRentalRatesTableViewController
        self.dailyRentalRatesViewController.title = "DAILY"
        self.dailyRentalRatesViewController.rentalType = .daily
        self.dailyRentalRatesViewController.car = car
        
        self.hourlyRentalRatesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditDetailRentalRatesIdentifier") as! EditDetailRentalRatesTableViewController
        self.hourlyRentalRatesViewController.title = "HOURLY"
        self.hourlyRentalRatesViewController.rentalType = .hourly
        self.hourlyRentalRatesViewController.car = car
        
        controllerArray.append(self.dailyRentalRatesViewController)
        controllerArray.append(self.hourlyRentalRatesViewController)
        
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveRentalRates))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.present = self.navigationController?.viewControllers[1].childViewControllers[0].childViewControllers[0] as! DetailRentalViewController!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.present.refreshDataOf(car: self.car)
    }
    
    func saveRentalRates() {
        if self.currentRentalType == .daily {
            self.car.firstRates.daily = Int(self.dailyRentalRatesViewController.firstRateTextField.text!)!
            self.car.secondRates.daily = Int(self.dailyRentalRatesViewController.secondRateTextField.text!)!
            self.car.firstDiscount.daily = Int(self.dailyRentalRatesViewController.firstDiscount.text!)!
            self.car.secondDiscount.daily = Int(self.dailyRentalRatesViewController.secondDiscount.text!)!
            self.car.minimumRentalDuration.daily = Int(self.dailyRentalRatesViewController.minimumDurationTextField.text!)!
            MBProgressHUD.showAdded(to: self.view, animated: true)
            AlamofireManager.changeDailyRentaInfoFor(car: self.car) { success, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.dailyRentalRatesViewController.reloadData()
                if success {
                    CardeeAlert.showAlert(withTitle: "Success", message: "Your daily changes were succesfully saved.", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        } else {
            self.car.firstRates.hourly = Int(self.hourlyRentalRatesViewController.firstRateTextField.text!)!
            self.car.secondRates.hourly = Int(self.hourlyRentalRatesViewController.secondRateTextField.text!)!
            self.car.firstDiscount.hourly = Int(self.hourlyRentalRatesViewController.firstDiscount.text!)!
            self.car.secondDiscount.hourly = Int(self.hourlyRentalRatesViewController.secondDiscount.text!)!
            self.car.minimumRentalDuration.hourly = Int(self.hourlyRentalRatesViewController.minimumDurationTextField.text!)!
            MBProgressHUD.showAdded(to: self.view, animated: true)
            AlamofireManager.changeHourlyRentaInfoFor(car: self.car) { success, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.hourlyRentalRatesViewController.reloadData()
                if success {
                    CardeeAlert.showAlert(withTitle: "Success", message: "Your hourly changes were succesfully saved.", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension EditRentalRatesWrapperViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int){}
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        self.currentRentalType = RentalType(rawValue: index)
        print("Moved to \(index)")
    }
}
