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
    let CarCellIdentifier = "CarCellIdentifier"
    @IBOutlet weak var carsTableViews: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        AlamofireManager.getOwnerProfile() { success, error in
            
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.carsTableViews.reloadData()
            
            MBProgressHUD.hide(for: (self.navigationController?.view)!, animated: true)
        }
        
        
    }
    
    func refresh(_ sender: UIRefreshControl) {
        AlamofireManager.getOwnerProfile() { success, error in
            self.refreshControl.endRefreshing()
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.carsTableViews.reloadData()
        }
    }
    
    func configureView() {
        //self.title = "My Cars"
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Car", style: .plain, target: self, action: #selector(self.addCar))
        
        
        //self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight) - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 13, 0)
        //self.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarCellIdentifier)
//        self.tableView.backgroundColor = Color.lightGray
//        self.tableView.tableFooterView = UIView()
//        self.tableView.separatorStyle = .none
//        self.view.addSubview(self.tableView)
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh...")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.carsTableViews.refreshControl = self.refreshControl
        
    }
    
    
    
    //MARK: Actions
    
    func addCar() {
        self.performSegue(withIdentifier: "AddCarSegue", sender: self)
    }
    
    //MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = carsTableViews.dequeueReusableCell(withIdentifier: CarCellIdentifier, for: indexPath) as? CarTableViewCell {
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
