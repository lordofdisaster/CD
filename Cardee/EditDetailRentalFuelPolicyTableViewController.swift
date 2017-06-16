//
//  EditDetailRentalFuelPolicyTableViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/13/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class EditDetailRentalFuelPolicyTableViewController: UITableViewController {
    
    var car: Car!
    var selectedRow = 0
    var rentalType: RentalType!

    @IBOutlet weak var paymentByMileageTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.rentalType == .daily {
            self.tableView.selectRow(at: IndexPath(row: self.car.fuelPolicyId.daily, section: 0), animated: false, scrollPosition: .none)
            self.tableView(self.tableView, didSelectRowAt: IndexPath(row: self.car.fuelPolicyId.daily, section: 0))
        } else {
            self.tableView.selectRow(at: IndexPath(row: self.car.fuelPolicyId.hourly, section: 0), animated: false, scrollPosition: .none)
            self.tableView(self.tableView, didSelectRowAt: IndexPath(row: self.car.fuelPolicyId.hourly, section: 0))
            if let payMileage = self.car.payMileage {
                self.paymentByMileageTextView.text = "\(payMileage)"
            } else {
                self.paymentByMileageTextView.text = "0.0"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func saveDailyFuelPolicy() {
        self.car.fuelPolicyId.daily = self.selectedRow
        switch self.selectedRow {
        case 0:
            self.car.fuelPolicyName.daily = "Payment by mileage"
            break
        case 1:
            self.car.fuelPolicyName.daily = "Full to Full"
            break
        case 2:
            self.car.fuelPolicyName.daily = "1/8 to 1/8"
            break
        case 3:
            self.car.fuelPolicyName.daily = "Return with similar level"
        default:
            break
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.changeDailyRentaInfoFor(car: self.car) { success, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.reloadData()
            if success {
                CardeeAlert.showAlert(withTitle: "Success", message: "Your daily changes were succesfully saved.", sender: self)
            } else {
                CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
            }
        }
    }
    
    func saveHourlyFuelPolicy() {
        self.car.fuelPolicyId.hourly = self.selectedRow
        switch self.selectedRow {
        case 0:
            self.car.fuelPolicyName.hourly = "Payment by mileage"
            break
        case 1:
            self.car.fuelPolicyName.hourly = "Full to Full"
            break
        case 2:
            self.car.fuelPolicyName.hourly = "1/8 to 1/8"
            break
        case 3:
            self.car.fuelPolicyName.hourly = "Return with similar level"
        default:
            break
        }
        self.car.payMileage = Float(self.paymentByMileageTextView.text!)!
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.changeHourlyRentaInfoFor(car: self.car) { success, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.reloadData()
            if success {
                CardeeAlert.showAlert(withTitle: "Success", message: "Your hourly changes were succesfully saved.", sender: self)
            } else {
                CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
            }
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.rentalType == .daily {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.rentalType == .hourly {
            if section == 0 {
                return 4
            } else {
                return 1
            }
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != self.selectedRow {
            tableView.cellForRow(at: IndexPath(row: self.selectedRow, section: 0))?.accessoryType = .none
            self.selectedRow = indexPath.row
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        print(self.selectedRow)
    }

}
