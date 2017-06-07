//
//  AddCarInfoViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class AddCarInfoViewController: UIViewController {
    
    var tableView: UITableView!
    var infoDataSource = [String]()
    var placeHolderDataSource = [String]()
    var carInfo = CarInfo()
    var textFieldTag = 0

    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Info"
        
        self.initializeTableView()
        self.initializeDataSource()
        self.setDefaultSelections()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NewCar.shared.carInfo = self.carInfo
    }

    //MARK: Initializers
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.register(AddCarInfoTableViewCell.self, forCellReuseIdentifier: "AddCarInfoCellIdentifier")
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        self.view.addSubview(self.tableView)
    }
    
    func initializeDataSource() {
        self.infoDataSource = ["Car Brand", "Car Model", "Year of Manufacture", "Car Titile", "License Plate Number", "Seating Capacity", "Engine Capacity", "Transmission", "Body Type(s)"]
        self.placeHolderDataSource = ["E.g. Toyota, Honda, BMW etc.", "E.g. Altis, Camry, Prius etc.", "", "E.g. Toyota Camry, BMW 3 Hybrid etc.", "E.g. SJX8938Y", "", "", "", ""]
    }
    
    //MARK: Actions
    
    func setDefaultSelections() {
        if let filledCarInfo = NewCar.shared.carInfo {
            self.carInfo = filledCarInfo
        }
    }
    
    func showPicker(_ sender: UIButton) {
        var pickerDataSource = [String]()
        switch sender.tag {
        case 2:
            for i in 0..<10 {
                pickerDataSource.append("\(2007 + i)")
            }
            break
        case 5:
            pickerDataSource = ["1", "2", "3", "4", "5", "6", "7", "8"]
            break
        case 6:
            pickerDataSource = ["0.7", "1.0", "1.6", "1.8", "2.0", "2.5", "3.0", "Will be more soon"]
            break
        case 7:
            pickerDataSource = ["Automatic", "Manual"]
            break
        case 8:
            pickerDataSource = ["Sedan", "Liftback", "SUV", "Hatchback", "Wagon", "Coupe", "Convertible", "Minivan", "Pickup", "Van", "Limousin"]
            break
        default:
            break
        }
        ActionSheetStringPicker.show(withTitle: "Choose", rows: pickerDataSource, initialSelection: 0, doneBlock: { (picker, index, value) in
            if sender.tag == 2 {
                self.carInfo.yearOfManufacture = value! as? String
            }
            if sender.tag == 5 {
                self.carInfo.seatingCapacity = (value! as AnyObject).integerValue
            }
            if sender.tag == 6 {
                self.carInfo.engineCapacity = value! as? String
            }
            if sender.tag == 7 {
                self.carInfo.transmission = Transmission(rawValue: index + 1)
                print(self.carInfo.transmission!)
            }
            if sender.tag == 8 {
                self.carInfo.bodyType = BodyType(rawValue: index + 1)
                print(self.carInfo.bodyType!)
            }
            sender.setTitle(value! as? String, for: .normal)
        }, cancel: { (picker) in
            print("Cancel")
        }, origin: sender)
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

extension AddCarInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCarInfoCellIdentifier", for: indexPath) as! AddCarInfoTableViewCell
        cell.infoLabel.text = self.infoDataSource[indexPath.row]
        cell.infoTextField.delegate = self
        cell.infoTextField.placeholder = self.placeHolderDataSource[indexPath.row]
        
        if indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 {
            cell.infoButton.isHidden = false
            cell.infoButton.tag = indexPath.row
            cell.infoButton.addTarget(self, action: #selector(self.showPicker(_:)), for: .touchUpInside)
        } else {
            cell.infoTextField.tag = textFieldTag
            textFieldTag += 1
        }
        
        switch indexPath.row {
        case 0:
            if let textFieldInfo = self.carInfo.carBrand {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 1:
            if let textFieldInfo = self.carInfo.carModel {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 2:
            if let buttonInfo = self.carInfo.yearOfManufacture {
                cell.infoButton.setTitle(buttonInfo, for: .normal)
            }
            break
        case 3:
            if let textFieldInfo = self.carInfo.carTitle {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 4:
            if let textFieldInfo = self.carInfo.licensePlateNumber {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 5:
            if let buttonInfo = self.carInfo.seatingCapacity {
                cell.infoButton.setTitle("\(buttonInfo)", for: .normal)
            }
            break
        case 6:
            if let buttonInfo = self.carInfo.engineCapacity {
                cell.infoButton.setTitle("\(buttonInfo)", for: .normal)
            }
            break
        case 7:
            if let buttonInfo = self.carInfo.transmission {
                cell.infoButton.setTitle("\(buttonInfo)".capitalized, for: .normal)
            }
            break
        case 8:
            if let buttonInfo = self.carInfo.bodyType {
                cell.infoButton.setTitle("\(buttonInfo)".capitalized, for: .normal)
            }
            break
        default:
            break
        }
        
        return cell
    }
}

extension AddCarInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.tableView.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let editedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        switch textField.tag {
        case 0:
            self.carInfo.carBrand = editedString
            break
        case 1:
            self.carInfo.carModel = editedString
            break
        case 2:
            self.carInfo.carTitle = editedString
            break
        case 3:
            self.carInfo.licensePlateNumber = editedString
            break
        default:
            break
        }
        return true
    }
}
