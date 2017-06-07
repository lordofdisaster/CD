//
//  AddVehicleTypeViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddVehicleTypeViewController: UIViewController {
    
    var tableView: UITableView!
    var typeImages = [UIImage]()
    var typeTitles = [String]()
    var typeDescriptions = [String]()
    let newCar = NewCar.shared

    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehicle Type"
        
        self.initializeTableView()
        self.initializeDataSource()
        self.setDefaultSelection()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    //MARK: Actions
    
    func setDefaultSelection() {
        if let selectedIndex = newCar.vehicleType?.rawValue {
            self.tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    //MARK: Initializers
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(VehicleTypeTableViewCell.self, forCellReuseIdentifier: "VehicleTypeCellIdentifier")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
    }
    
    func initializeDataSource() {
        self.typeImages = [#imageLiteral(resourceName: "personal_car"), #imageLiteral(resourceName: "uber_grab"), #imageLiteral(resourceName: "taxi"), #imageLiteral(resourceName: "truck")]
        self.typeTitles = ["Personal Car", "Private-Hire Car", "Taxi", "Commercial Vehicle"]
        self.typeDescriptions = ["Passenger car for personal user", "Private-hire cars registered for Grab / Uber use. (Also can be rented out for personal use)", "Taxis", "Pickup, lorry, van, minibus etc."]
    }
    
    //MARK: Navigation Actions
    
    func goToParent() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    func goToNextStep() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
    }
    
    //MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension AddVehicleTypeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VehicleTypeCellIdentifier", for: indexPath) as! VehicleTypeTableViewCell
        cell.typeImageView.image = self.typeImages[indexPath.row]
        cell.typeNameLabel.text = self.typeTitles[indexPath.row]
        cell.footerLabel.text = self.typeDescriptions[indexPath.row]
        cell.footerLabel.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NewCar.shared.vehicleType = VehicleType(rawValue: indexPath.row + 1)
    }
}
