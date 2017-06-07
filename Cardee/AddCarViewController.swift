//
//  AddCarViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class AddCarViewController: CardeeViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var infoKeysArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Car"
        self.infoKeysArray = ["Vehicle Type", "Insurance Info", "Car Info", "Car Image", "Car Location", "Car Documents", "Personal Documents", "Contact Info"]
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    //MARK: Actions
    
    @IBAction func addCar(_ sender: Any) {
        MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        AlamofireManager.addCar() { success, error in
            MBProgressHUD.hide(for: (self.navigationController?.view)!, animated: true)
            if success {
                CardeeAlert.showAlert(withTitle: "Success", message: "Your car was succesfully added", sender: self)
            } else {
                CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
            }
        }
    }
    func addCarInfo(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.performSegue(withIdentifier: "addVehicleTypeSegue", sender: self)
            break
        case 1:
            self.performSegue(withIdentifier: "addInsuranceInfoSegue", sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: "addCarInfoSegue", sender: self)
            break
        case 3:
            self.performSegue(withIdentifier: "addCarVerificationImageSegue", sender: self)
            break
        case 4:
            self.performSegue(withIdentifier: "addCarLocationSegue", sender: self)
            break
        case 5:
            self.performSegue(withIdentifier: "addCarDocumentsSegue", sender: self)
            break
        case 6:
            self.performSegue(withIdentifier: "addPersonalDocumentsSegue", sender: self)
            break
        case 7:
            self.performSegue(withIdentifier: "addContactInfoSegue", sender: self)
            break
        default:
            print("Hello")
        }
    }

    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NewCar.shared.dispose()
    }
}

//MARK: TableView Delegate + DataSource

extension AddCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func setupFilledIdentifiers(cell: AddCarTableViewCell) {
        cell.filledInfoImageView.isHidden = false
        cell.fillInfoButton.setTitle("Edit", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCarCellIdentifier", for: indexPath) as! AddCarTableViewCell
        cell.infoKeyLabel.text = "\(indexPath.row + 1). \(self.infoKeysArray[indexPath.row])"
        cell.fillInfoButton.setTitle("Add", for: .normal)
        cell.fillInfoButton.addTarget(self, action: #selector(addCarInfo(_:)), for: .touchUpInside)
        cell.fillInfoButton.tag = indexPath.row
        cell.filledInfoImageView.isHidden = true
        
        if indexPath.row == 0 && (NewCar.shared.vehicleType != nil) {
            self.setupFilledIdentifiers(cell: cell)
        }
        
        if indexPath.row == 1 {
            if let insuranceInfo = NewCar.shared.insuranceInfo {
                if insuranceInfo.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        if indexPath.row == 2 {
            if let carInfo = NewCar.shared.carInfo {
                if carInfo.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        if indexPath.row == 3 {
            if let carVerification = NewCar.shared.carVerification {
                if carVerification.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        if indexPath.row == 4 {
            if let carLocation = NewCar.shared.carLocation {
                if carLocation.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        if indexPath.row == 5 {
            if let carDocuments = NewCar.shared.carDocuments {
                if carDocuments.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        if indexPath.row == 6 {
            if let personalDocuments = NewCar.shared.personalDocuments {
                if personalDocuments.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        if indexPath.row == 7 {
            if let contactInfo = NewCar.shared.contactInfo {
                if contactInfo.isFilled() {
                    self.setupFilledIdentifiers(cell: cell)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        print("Ready to submit: \(NewCar.shared.isFilled())")
        return UIView()
    }
}
