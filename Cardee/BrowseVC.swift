//
//  BrowseVC.swift
//  Cardee
//
//  Created by Leonid Nifantyev on 7/12/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class BrowseVC: UIViewController {
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var periodBarView: UIView!
    
    @IBOutlet weak var carsTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var cars = [SimpleCar]()

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControlSetup()
        
        MBProgressHUD.showAdded(to: (carsTableView)!, animated: true)
        AlamofireManager.getOwnerProfile() { success, error in
            
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.carsTableView.reloadData()
            
            MBProgressHUD.hide(for: (self.carsTableView)!, animated: true)
        }

    }

    func refreshControlSetup() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh...")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.carsTableView.refreshControl = self.refreshControl
        
    }
    
    func refresh(_ sender: UIRefreshControl) {
        AlamofireManager.getOwnerProfile() { success, error in
            self.refreshControl.endRefreshing()
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.carsTableView.reloadData()
        }
    }


    

}

//MARK: Table
extension BrowseVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = carsTableView.dequeueReusableCell(withIdentifier: "autoCell", for: indexPath) as? BrowseCell {
            
            let car = cars[indexPath.row]
            
            cell.configureCell(car)
            
            return cell
            
        }
        
        
        
        return UITableViewCell()
    }
    
    
}
