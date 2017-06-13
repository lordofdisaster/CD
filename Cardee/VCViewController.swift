//
//  VCViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import PageMenu


class VCViewController: CardeeViewController {
    
    var pageMenu: CAPSPageMenu?
    var carId = Int()
    
    @IBOutlet weak var bookingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SLE8938Y"
        
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.getCarWith(id: self.carId) { object, error in
            //MBProgressHUD.hide(for: self.view, animated: true)
            let car = object as! Car
            
            var controllerArray = [UIViewController]()
            
            let detailCarViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailCarViewControllerIdentifier") as! DetailCarViewController
            detailCarViewController.title = "CAR"
            detailCarViewController.car = car
            
            let detailRentalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailRentalViewControllerIdentifier") as! DetailRentalViewController
            detailRentalViewController.title = "RENTAL"
            detailRentalViewController.car = car
            
            controllerArray.append(detailRentalViewController)
            controllerArray.append(detailCarViewController)
            
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
            //self.pageMenu?.setStartIndexToPage(index: 1)
            
            self.view.bringSubview(toFront: self.bookingButton)
        }

        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension VCViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int){}
    
    func didMoveToPage(_ controller: UIViewController, index: Int){}
}
