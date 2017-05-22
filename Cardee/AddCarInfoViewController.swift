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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Cars"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(save))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.register(AddCarInfoTableViewCell.self, forCellReuseIdentifier: "AddCarInfoCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        self.view.addSubview(self.tableView)
        
        self.infoDataSource = ["Car Brand", "Car Model", "Year of Manufacture", "Car Titile", "License Plate Number", "Seating Capacity", "Engine Capacity", "Transmission", "Body Type(s)"]
        self.placeHolderDataSource = ["E.g. Toyota, Honda, BMW etc.", "E.g. Altis, Camry, Prius etc.", "", "E.g. Toyota Camry, BMW 3 Hybrid etc.", "E.g. SJX8938Y", "", "", "", ""]
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(self.back))
    }
    
    func showPicker(_ sender: UIButton) {
        var pickerDataSource = [String]()
        switch sender.tag {
        case 2:
            for i in 0..<30 {
                pickerDataSource.append("\(1987 + i)")
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
            pickerDataSource = ["SUV", "Sedan", "Will be more soon"]
            break
        default:
            break
        }
        ActionSheetStringPicker.show(withTitle: "Choose", rows: pickerDataSource, initialSelection: 2, doneBlock: { (picker, index, value) in
            print("Done")
            sender.setTitle(value! as? String, for: .normal)
        }, cancel: { (picker) in
            print("Cancel")
        }, origin: sender)
    }
    
    func back() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    func save() {
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
        cell.infoTextField.tag = indexPath.row
        cell.infoTextField.placeholder = self.placeHolderDataSource[indexPath.row]
        if indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 {
            //cell.infoTextField.isHidden = true
            cell.infoButton.isHidden = false
            cell.infoButton.tag = indexPath.row
            cell.infoButton.addTarget(self, action: #selector(self.showPicker(_:)), for: .touchUpInside)
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
}
