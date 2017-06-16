//
//  EditDetailRentalDeliveryRatesTableViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/13/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class EditDetailRentalDeliveryRatesTableViewController: UITableViewController, UITextFieldDelegate {

    var dynamicCellHeight: CGFloat!
    var car: Car!
    
    @IBOutlet weak var baseRateTextField: UITextField!
    @IBOutlet weak var distanceRateTextField: UITextField!
    @IBOutlet weak var freeDeliverySwitch: UISwitch!
    @IBOutlet weak var minimumRentalDaysTextField: UITextField!
    
    // MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dynamicCellHeight = 115
        
        self.title = "Delivery Rates"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveDeliveryRates))
        
        self.setDefaultValues()
    }
    
    func setDefaultValues() {
        self.baseRateTextField.text = "\(self.car.baseRate!)"
        self.distanceRateTextField.text = "\(self.car.distanceRate!)"
        self.freeDeliverySwitch.isOn = self.car.isProvideFreeDelivery
        if self.car.isProvideFreeDelivery {
            self.dynamicCellHeight = 115
        } else {
            self.dynamicCellHeight = 60
        }
        self.minimumRentalDaysTextField.text = "\(self.car.rentalDuration!)"
    }
    
    // MARK: Actions
    
    func saveDeliveryRates() {
        self.car.baseRate = Int(self.baseRateTextField.text!)
        self.car.distanceRate = Int(self.distanceRateTextField.text!)
        self.car.isProvideFreeDelivery = self.freeDeliverySwitch.isOn
        self.car.rentalDuration = Int(self.minimumRentalDaysTextField.text!)!
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.changeRentalDeliveryRatesFor(car: self.car) { success, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.reloadData()
            if success {
                print("Success")
            } else {
                print("Error")
            }
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.invalidateIntrinsicContentSize()
        return true
    }
    
    func textFieldEditingChanged(textField: UITextField) {
        textField.invalidateIntrinsicContentSize()
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            self.dynamicCellHeight = 115
        } else {
            self.dynamicCellHeight = 60
        }
        self.tableView.reloadData()
    }
    
    // MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            return dynamicCellHeight
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
