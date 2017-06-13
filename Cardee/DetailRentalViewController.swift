//
//  DetailRentalViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import MBProgressHUD

class DetailRentalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dates = [Date]()
    var carId = Int()
    var car = Car()
    
    var dailyDataSource = [String]()
    var hourlyDataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 112, right: 0)
        /*
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.getCarWith(id: self.carId) { object, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.car = object as! Car
            self.parent?.title = self.car.licensePlateNumber
            self.tableView.reloadData()
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func switchChanged(_ sender: UISwitch) {
        self.car.isInstantBooking.daily = sender.isOn
        self.reloadData()
    }
    
    func showSettingsInfo() {
        CardeeAlert.showAlert(withTitle: "", message: "Instant booking\n Confirm booking request instantly as long as renter / driver meets the basic requirements you set under rental terms.\n\n Curbside Delivery\nSend vehicle to Renter's desired pickup location for collection, at a delivery rate you set.\n\nAccept Cash\nAllow Renters's yo pay in cash for the booking. Note that it will be your responsibility to ensure cash is collected.", sender: self)
    }
    
    func editDate() {
        let calendarViewController = CalendarViewController()
        calendarViewController.dates = self.dates
        self.navigationController?.pushViewController(calendarViewController, animated: true)
    }
    
    func editTime(_ sender: UIButton) {
        ActionSheetMultipleStringPicker.show(withTitle: "Pickup and return timing", rows: [["1", "2", "3"], ["a", "b", "c"]], initialSelection: [0, 1], doneBlock: { (picker, index, value) in
            print("Hello")
        }, cancel: { (picker) in
            print("Bye")
        }, origin: sender)
    }
}

extension DetailRentalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        } else if indexPath.row == 1 {
            return 235.0
        } else if indexPath.row == 2 {
            return 165.0
        } else if indexPath.row == 3 {
            return 105.0
        } else {
            return 72.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.car.carDescription {
            return 5
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalAvailabilityIdentifier", for: indexPath) as! DetailRentalAvailabilityTableViewCell
            cell.availableDaysLabel.text = "\(self.dates.count) available days"
            cell.editDateButton.addTarget(self, action: #selector(self.editDate), for: .touchUpInside)
            cell.editTimeButton.addTarget(self, action: #selector(self.editTime(_:)), for: .touchUpInside)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalSettingsIdentifier", for: indexPath) as! DetailRentalSettingsTableViewCell
            cell.settingsInfoButton.addTarget(self, action: #selector(showSettingsInfo), for: .touchUpInside)
            
            cell.instantBookingSwitch.isOn = self.car.isInstantBooking.daily
            //cell.instantBookingSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.instantBookingSwitch.isOn ? (cell.instantBookingImageView.tintColor = #colorLiteral(red: 0.9490196078, green: 0.7137254902, blue: 0.1960784314, alpha: 1)) : (cell.instantBookingImageView.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
            
            cell.curbsideDeliverySwitch.isOn = self.car.isCurbsideDelivery.daily
            //cell.curbsideDeliverySwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.curbsideDeliverySwitch.isOn ? (cell.curbsideDeliveryImageView.tintColor = #colorLiteral(red: 0.09803921569, green: 0.7254901961, blue: 0.6784313725, alpha: 1)) : (cell.curbsideDeliveryImageView.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
            
            cell.acceptCashSwitch.isOn = self.car.isAcceptCash.daily
            //cell.acceptCashSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.acceptCashSwitch.isOn ? (cell.acceptCashImageView.tintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.2509803922, alpha: 1)) : (cell.acceptCashImageView.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalRatesIdentifier", for: indexPath) as! DetailRentalRatesTableViewCell
            cell.firstRateLabel.text = "\(car.firstRates.daily)$ per day (weekdays)"
            cell.secondRateLabel.text = "\(car.secondRates.daily)$ per day (weekends and P.H.)"
            cell.firstDiscountLabel.text = "Weekly discount \(car.firstDiscount.daily)%"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalFuelIdentifier", for: indexPath) as! DetailRentalFuelTableViewCell
            cell.fuelPolicyLabel.text = car.fuelPolicyName.daily
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalTermsIdentifier", for: indexPath) as! DetailRentalTermsTableViewCell
            return cell
        }
    }
}

