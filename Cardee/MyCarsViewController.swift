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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Cars"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Car", style: .plain, target: self, action: #selector(self.addCar))
        
        MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        AlamofireManager.getOwnerProfile() { success, error in
            MBProgressHUD.hide(for: (self.navigationController?.view)!, animated: true)
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.tableView.reloadData()
        }
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight) - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 13, 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: "CarCellIdentifier")
        self.tableView.backgroundColor = Color.lightGray
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refresh...")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
    }
    
    func refresh(_ sender: UIRefreshControl) {
        AlamofireManager.getOwnerProfile() { success, error in
            self.refreshControl.endRefreshing()
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.tableView.reloadData()
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCellIdentifier", for: indexPath) as! CarTableViewCell
        
        if let imageUrl = URL(string: self.cars[indexPath.row].carImage!) {
            cell.carImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(), filter: nil, progress: { progress in
                print("Progress \(progress)")
            }, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { data in
                print(data)
            }
        }
        
        let yearString = self.cars[indexPath.row].yearManufacture
        let yearAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin) ]
        let yearAttributedString = NSAttributedString(string: yearString!, attributes: yearAttribute)
        
        let carNameString = self.cars[indexPath.row].carTitle + "  "
        let carNameAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold) ]
        let carNameAttributedString = NSAttributedString(string: carNameString, attributes: carNameAttribute)
        
        let result = NSMutableAttributedString()
        result.append(carNameAttributedString)
        result.append(yearAttributedString)
        
        cell.carNameLabel.attributedText = result
        cell.carNumberLabel.text = self.cars[indexPath.row].licensePlateNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailCar", sender: indexPath)
    }
}
