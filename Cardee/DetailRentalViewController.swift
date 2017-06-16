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
    var car = Car()
    var rentalType: RentalType!
    
    var dailyDataSource = [String]()
    var hourlyDataSource = [String]()
    
    @IBOutlet weak var hourlyButton: UIButton!
    @IBOutlet weak var dailyButton: UIButton!
    var hourlyUnderscoreView: UIView!
    var dailyUnderscoreView: UIView!
    @IBOutlet weak var rentalTypeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 112, right: 0)
        self.rentalType = .daily
        
        self.hourlyUnderscoreView = UIView(frame: CGRect(x: 0, y: self.hourlyButton.bounds.height - 3, width: self.hourlyButton.bounds.width, height: 3))
        self.hourlyUnderscoreView.backgroundColor = Color.darkBlue
        self.hourlyUnderscoreView.isHidden = true
        
        self.dailyUnderscoreView = UIView(frame: CGRect(x: 0, y: self.hourlyButton.bounds.height - 3, width: self.hourlyButton.bounds.width, height: 3))
        self.dailyUnderscoreView.backgroundColor = Color.darkBlue
        self.dailyUnderscoreView.isHidden = true
        
        self.renderButtons()
        
        self.hourlyButton.addSubview(self.hourlyUnderscoreView)
        self.dailyButton.addSubview(self.dailyUnderscoreView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func renderButtons() {
        if self.rentalType == .daily {
            self.hourlyUnderscoreView.isHidden = true
            self.dailyUnderscoreView.isHidden = false
        } else {
            self.hourlyUnderscoreView.isHidden = false
            self.dailyUnderscoreView.isHidden = true
        }
    }
    
    func refreshDataOf(car: Car) {
        self.car = car
        self.reloadData()
    }
    
    @IBAction func hourlyButtonAction(_ sender: Any) {
        self.rentalType = .hourly
        self.renderButtons()
        self.reloadData()
    }
    
    @IBAction func dailyButtonAction(_ sender: Any) {
        self.rentalType = .daily
        self.renderButtons()
        self.reloadData()
    }
    
    
    func showDeliveryRates() {
        let editDetailRentalDeliveryRatesTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditDetailRentalDeliveryRatesIdentifier") as! EditDetailRentalDeliveryRatesTableViewController
        editDetailRentalDeliveryRatesTableViewController.car = self.car
        self.navigationController?.pushViewController(editDetailRentalDeliveryRatesTableViewController, animated: true)
    }
    
    func showRentalRates() {
        let editRentalRatesWrapperViewController = EditRentalRatesWrapperViewController()
        editRentalRatesWrapperViewController.car = self.car
        self.navigationController?.pushViewController(editRentalRatesWrapperViewController, animated: true)
    }
    
    func showFuelPolicy() {
        let editFuelPolicyWrapperViewController = EditFuelPolicyWrapperViewController()
        editFuelPolicyWrapperViewController.car = self.car
        self.navigationController?.pushViewController(editFuelPolicyWrapperViewController, animated: true)
    }
    
    func switchChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            if self.rentalType == .daily {
                self.car.isInstantBooking.daily = sender.isOn
            } else {
                self.car.isInstantBooking.hourly = sender.isOn
            }
            break
        case 1:
            if self.rentalType == .daily {
                self.car.isCurbsideDelivery.daily = sender.isOn
            } else {
                self.car.isInstantBooking.hourly = sender.isOn
            }
            break
        case 2:
            if self.rentalType == .daily {
                self.car.isAcceptCash.daily = sender.isOn
            } else {
                self.car.isAcceptCash.hourly = sender.isOn
            }
            break
        default:
            break
        }
        self.saveData()
    }
    
    func saveData() {
        if self.rentalType == .daily {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            AlamofireManager.changeDailyRentaInfoFor(car: self.car) { success, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.reloadData()
                if success {
                    print("Success")
                } else {
                    print("Error")
                }
            }
        } else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            AlamofireManager.changeHourlyRentaInfoFor(car: self.car) { success, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.reloadData()
                if success {
                    print("Success")
                } else {
                    print("Error")
                }
            }
        }
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
            return 196.0
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
            
            if self.rentalType == .daily {
                cell.rentalTypeLabel.text = "(Daily)"
            } else {
                cell.rentalTypeLabel.text = "(Hourly)"
            }
            
            cell.availableDaysLabel.text = "\(self.dates.count) available days"
            cell.editDateButton.addTarget(self, action: #selector(self.editDate), for: .touchUpInside)
            cell.editTimeButton.addTarget(self, action: #selector(self.editTime(_:)), for: .touchUpInside)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalSettingsIdentifier", for: indexPath) as! DetailRentalSettingsTableViewCell
            
            if self.rentalType == .daily {
                cell.rentalTypeLabel.text = "(Daily)"
                cell.instantBookingSwitch.isOn = self.car.isInstantBooking.daily
                cell.curbsideDeliverySwitch.isOn = self.car.isCurbsideDelivery.daily
                cell.acceptCashSwitch.isOn = self.car.isAcceptCash.daily
            } else {
                cell.rentalTypeLabel.text = "(Hourly)"
                cell.instantBookingSwitch.isOn = self.car.isInstantBooking.hourly
                cell.curbsideDeliverySwitch.isOn = self.car.isCurbsideDelivery.hourly
                cell.acceptCashSwitch.isOn = self.car.isAcceptCash.hourly
            }
            
            cell.settingsInfoButton.addTarget(self, action: #selector(showSettingsInfo), for: .touchUpInside)
            
            cell.instantBookingSwitch.tag = 0
            cell.instantBookingSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.instantBookingSwitch.isOn ? (cell.instantBookingImageView.tintColor = #colorLiteral(red: 0.9490196078, green: 0.7137254902, blue: 0.1960784314, alpha: 1)) : (cell.instantBookingImageView.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
            
            cell.curbsideDeliverySwitch.tag = 1
            cell.curbsideDeliverySwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.curbsideDeliverySwitch.isOn ? (cell.curbsideDeliveryImageView.tintColor = #colorLiteral(red: 0.09803921569, green: 0.7254901961, blue: 0.6784313725, alpha: 1)) : (cell.curbsideDeliveryImageView.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
            cell.deliveryRatesButton.addTarget(self, action: #selector(self.showDeliveryRates), for: .touchUpInside)
            
            cell.acceptCashSwitch.tag = 2
            cell.acceptCashSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.acceptCashSwitch.isOn ? (cell.acceptCashImageView.tintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.2509803922, alpha: 1)) : (cell.acceptCashImageView.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalRatesIdentifier", for: indexPath) as! DetailRentalRatesTableViewCell
            if self.rentalType == .daily {
                cell.rentalTypeLabel.text = "(Daily)"
                cell.firstRateLabel.text = "\(car.firstRates.daily)$ per day (weekdays)"
                cell.secondRateLabel.text = "\(car.secondRates.daily)$ per day (weekends and P.H.)"
                cell.firstDiscountLabel.text = "Weekly discount \(car.firstDiscount.daily)%"
                cell.secondDiscountLabel.text = "Monthly discount \(car.secondDiscount.daily)%"
            } else {
                cell.rentalTypeLabel.text = "(Hourly)"
                cell.firstRateLabel.text = "\(car.firstRates.hourly)$ per day (weekdays)"
                cell.secondRateLabel.text = "\(car.secondRates.hourly)$ per day (weekends and P.H.)"
                cell.firstDiscountLabel.text = "Weekly discount \(car.firstDiscount.hourly)%"
                cell.secondDiscountLabel.text = "Monthly discount \(car.secondDiscount.hourly)%"
            }
            cell.ratesEditButton.addTarget(self, action: #selector(self.showRentalRates), for: .touchUpInside)
            
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalFuelIdentifier", for: indexPath) as! DetailRentalFuelTableViewCell
            if self.rentalType == .daily {
                cell.rentalTypeLabel.text = "(Daily)"
                cell.fuelPolicyLabel.text = car.fuelPolicyName.daily
            } else {
                cell.rentalTypeLabel.text = "(Hourly)"
                cell.fuelPolicyLabel.text = car.fuelPolicyName.hourly
            }
            cell.editFuelPolicyButton.addTarget(self, action: #selector(self.showFuelPolicy), for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalTermsIdentifier", for: indexPath) as! DetailRentalTermsTableViewCell
            return cell
        }
    }
}

