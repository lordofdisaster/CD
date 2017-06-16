//
//  EditDetailRentalRatesTableViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/13/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class EditDetailRentalRatesTableViewController: UITableViewController {

    var car: Car!
    var rentalType: RentalType!
    
    @IBOutlet weak var firstRateLabel: UILabel!
    @IBOutlet weak var secondRateLabel: UILabel!
    
    @IBOutlet weak var firstRateTextField: UITextField!
    @IBOutlet weak var secondRateTextField: UITextField!
    
    @IBOutlet weak var firstDiscountLabel: UILabel!
    @IBOutlet weak var secondDiscountLabel: UILabel!
    
    @IBOutlet weak var firstDiscount: UITextField!
    @IBOutlet weak var secondDiscount: UITextField!
    
    @IBOutlet weak var minimumDurationLabel: UILabel!
    @IBOutlet weak var minimumDurationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.rentalType == .hourly {
            self.firstRateLabel.text = "Peak hour"
            self.secondRateLabel.text = "Non-peak hour"
            self.firstDiscountLabel.text = "4 hours discount"
            self.secondDiscountLabel.text = "8 hours discount"
        } else {
            self.firstRateLabel.text = "Weekdays"
            self.secondRateLabel.text = "Weekends and public holidays"
            self.firstDiscountLabel.text = "Weekly discount"
            self.secondDiscountLabel.text = "Monthly discount"
        }
        
        self.setDefaultValues()
    }
    
    // MARK: Actions
    
    func setDefaultValues() {
        if self.rentalType == .daily {
            self.firstRateTextField.text = "\(self.car.firstRates.daily)"
            self.secondRateTextField.text = "\(self.car.secondRates.daily)"
            self.firstDiscount.text = "\(self.car.firstDiscount.daily)"
            self.secondDiscount.text = "\(self.car.secondDiscount.daily)"
            self.minimumDurationTextField.text = "\(self.car.minimumRentalDuration.daily)"
        } else {
            self.firstRateTextField.text = "\(self.car.firstRates.hourly)"
            self.secondRateTextField.text = "\(self.car.secondRates.hourly)"
            self.firstDiscount.text = "\(self.car.firstDiscount.hourly)"
            self.secondDiscount.text = "\(self.car.secondDiscount.hourly)"
            self.minimumDurationTextField.text = "\(self.car.minimumRentalDuration.hourly)"
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if self.rentalType == .daily {
                return "Daily Rates"
            } else {
                return "Hourly Rates"
            }
        } else if section == 1 {
            return "Discount"
        } else {
            return "Minimum"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
    }

}
