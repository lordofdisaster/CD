//
//  CardeePickerViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/19/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CardeePickerViewController: UIViewController {

    var closeButton: UIButton!
    var pickerBackgroundView: UIView!
    var pickerTitleLabel: UILabel!
    var pickerTitle: String!
    var saveButton: UIButton!
    
    var values: [String]!
    var headers: [String]!
    
    var pickerView: UIPickerView!
    
    var fromTime: String!
    var toTime: String!
    
    var car: Car!
    var rentalType: RentalType!
    var present: DetailRentalViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        
        self.closeButton = UIButton(type: .system)
        self.closeButton.frame = CGRect(x: Screen.width - 30, y: Screen.height - 300 - 30, width: 15, height: 15)
        self.closeButton.setImage(#imageLiteral(resourceName: "cross"), for: .normal)
        self.closeButton.tintColor = UIColor.white
        self.closeButton.addTarget(self, action: #selector(self.dismissCardeePicker), for: .touchUpInside)
        
        self.pickerTitleLabel = UILabel(frame: CGRect(x: 15, y: Screen.height - 300 - 30, width: Screen.width - self.closeButton.frame.width - 30, height: 15))
        self.pickerTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        self.pickerTitleLabel.textColor = UIColor.white
        self.pickerTitleLabel.text = self.pickerTitle.uppercased()
        
        self.pickerBackgroundView = UIView(frame: CGRect(x: 0, y: Screen.height - 300, width: Screen.width, height: 320))
        self.pickerBackgroundView.backgroundColor = UIColor.white
        self.pickerBackgroundView.layer.cornerRadius = 3
        
        for i in 0..<2 {
            let valueLabel = UILabel(frame: CGRect(x: CGFloat(i) * Screen.width/2, y: 0, width: Screen.width/2, height: 40))
            valueLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
            valueLabel.textColor = UIColor.darkGray
            valueLabel.textAlignment = .center
            valueLabel.text = self.headers[i]
            self.pickerBackgroundView.addSubview(valueLabel)
        }
        
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 40, width: Screen.width, height: 189))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.pickerBackgroundView)
        self.view.addSubview(self.pickerTitleLabel)
        self.pickerBackgroundView.addSubview(self.pickerView)
        
        let nextDayLabel = UILabel(frame: CGRect(x: Screen.width - 50, y: 85, width: 50, height: 18))
        nextDayLabel.text = "next day"
        nextDayLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightLight)
        nextDayLabel.textColor = Color.grayText
        
        self.pickerView.addSubview(nextDayLabel)
        
        self.saveButton = UIButton(type: .system)
        self.saveButton.frame = CGRect(x: 13, y: self.pickerBackgroundView.frame.height - 76, width: view.frame.size.width - 26, height: 45)
        self.saveButton.backgroundColor = Color.green
        self.saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.saveButton.setTitleColor(UIColor.white, for: .normal)
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.layer.cornerRadius = 3
        self.saveButton.addTarget(self, action: #selector(self.saveTimeInfo), for: .touchUpInside)
        
        self.pickerBackgroundView.addSubview(self.saveButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.present = (self.presentingViewController!.childViewControllers[0] as! UINavigationController).viewControllers[1].childViewControllers[0].childViewControllers[0] as! DetailRentalViewController
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.present.refreshDataOf(car: self.car)
    }
    
    func dismissCardeePicker() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveTimeInfo() {
        if self.rentalType == .daily {
            print("Daily")
            AlamofireManager.changeDailyRentaInfoFor(car: self.car) { success, error in
                if success {
                    CardeeAlert.showAlert(withTitle: "Success", message: "You changes were succesfully saved", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        } else {
            AlamofireManager.availabilityHourlyForCar(car: self.car) { success, error in
                if success {
                    CardeeAlert.showAlert(withTitle: "Success", message: "You changes were succesfully saved", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CardeePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.rentalType == .daily {
            if component == 0 {
                self.fromTime = Methods.transformPickupTimeToString(pickupTime: self.values[row])
                self.car.timePickup = self.fromTime
                print(self.fromTime)
            } else {
                self.toTime = Methods.transformPickupTimeToString(pickupTime: self.values[row])
                self.car.timeReturn = self.toTime
                print(self.toTime)
            }
        } else {
            if component == 0 {
                self.car.availabilityTimeBegin = Methods.transformPickupTimeToString(pickupTime: self.values[row])
            } else {
                self.car.availabilityTimeEnd = Methods.transformPickupTimeToString(pickupTime: self.values[row])
            }
        }
    }
}
