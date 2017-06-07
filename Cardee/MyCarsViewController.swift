//
//  MyCarsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/4/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class MyCarsViewController: CardeeViewController {
    
    var tableView: UITableView!
    var cars = [SimpleCar]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Cars"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Car", style: .plain, target: self, action: #selector(addCar))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight) - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 13, 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: "CarCellIdentifier")
        self.tableView.backgroundColor = Color.lightGray
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        AlamofireManager.getOwnerProfile() { success, error in
            MBProgressHUD.hide(for: (self.navigationController?.view)!, animated: true)
            self.cars.removeAll()
            self.cars = OwnerProfile.shared.cars
            self.tableView.reloadData()
        }
    }
    
    //MARK: Actions
    
    func addCar() {
        self.performSegue(withIdentifier: "AddCarSegue", sender: self)
    }
    
    //MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        if let image = self.cars[indexPath.row].carImageObject {
            cell.carImageView.image = image
        } else {
            let url = URL(string: self.cars[indexPath.row].carImage)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.carImageView.image = UIImage(data: data!)
                    self.cars[indexPath.row].carImageObject = cell.carImageView.image
                }
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
        self.performSegue(withIdentifier: "showDetailCar", sender: self)
    }
}
