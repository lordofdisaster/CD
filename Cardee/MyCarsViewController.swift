//
//  MyCarsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/4/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD
import AlamofireImage
import Alamofire

class MyCarsViewController: CardeeViewController {
    
    var tableView: UITableView!
    var cars = [SimpleCar]()
    var refreshControl: UIRefreshControl!
    let carCell = "CarCell"
    @IBOutlet weak var carsTableViews: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControlSetup()
        
        MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        AlamofireManager.getOwnerProfile() { success, error in
            
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.carsTableViews.reloadData()
            
            MBProgressHUD.hide(for: (self.navigationController?.view)!, animated: true)
        }
        
        
    }
    
    
    
    func refreshControlSetup() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh...")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.carsTableViews.refreshControl = self.refreshControl
        
    }
    
    func refresh(_ sender: UIRefreshControl) {
        AlamofireManager.getOwnerProfile() { success, error in
            self.refreshControl.endRefreshing()
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.carsTableViews.reloadData()
        }
    }
    
    //MARK: Actions
    @IBAction func addCar(_ sender: Any) {
        self.performSegue(withIdentifier: "AddCarSegue", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailCar" {
            let indexPathRow = (sender as! IndexPath).row
            if let detailCarViewController = segue.destination as? VCViewController {
                detailCarViewController.carId = self.cars[indexPathRow].carId!
            }
        }
    }
}

//MARK: TableView Delegate + DataSource

extension MyCarsViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 325.0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = carsTableViews.dequeueReusableCell(withIdentifier: carCell, for: indexPath) as? CarTableViewCell {
            let car = cars[indexPath.row]
            cell.configureCell(car)
    
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailCar", sender: indexPath)
    }
}
