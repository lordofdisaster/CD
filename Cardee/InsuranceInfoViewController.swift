//
//  InsuranceInfoViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class InsuranceInfoViewController: UIViewController {
    
    var tableView: UITableView!
    var infoDataSource = [String]()
    var controlsDataSource = [Bool]()
    var insuranceInfo = InsuranceInfo()

    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Insurance Info"
        
        self.initializeTableView()
        self.initializeDataSource()
        self.setDefaultSelections()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.getAccidentIssueText()
        NewCar.sharedInstance.insuranceInfo = self.insuranceInfo
    }
    
    //MARK: Initializers
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(InsuranceInfoTableViewCell.self, forCellReuseIdentifier: "InsuranceInfoCellIdentifier")
        self.tableView.register(InsuranceInfoExampleTableViewCell.self, forCellReuseIdentifier: "InsuranceInfoExampleCellIdentifier")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        self.view.addSubview(self.tableView)
    }
    
    func initializeDataSource() {
        self.infoDataSource = ["Does the car has a comprehensive insusurance?", "Does the car insurance covers unnamed driver?", "What is the minimum age required for coverage? ", "What is the minimum years of driving experience required for coverage? ", "When does your insurance expires?"]
        self.controlsDataSource = [true, true, false, false, false]
    }
    
    //MARK: Actions
    
    func getAccidentIssueText() {
        let accidentCell = self.tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! InsuranceInfoExampleTableViewCell
        self.insuranceInfo.accidentIssue = accidentCell.exampleTextView.text
    }
    
    func setDefaultSelections() {
        if let selectedInsuranceInfo = NewCar.sharedInstance.insuranceInfo {
            self.insuranceInfo = selectedInsuranceInfo
            
            // Comprehensive Insurance
            let comprehensiveCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InsuranceInfoTableViewCell
            comprehensiveCell.infoSwitch.isOn = self.insuranceInfo.comprehensiveInsurance
            
            // Covers Drivers
            let coversDriversCell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! InsuranceInfoTableViewCell
            coversDriversCell.infoSwitch.isOn = self.insuranceInfo.coversDrivers
            
            // Minimum Age
            if let minimumAge = self.insuranceInfo.minimumAge {
                let minimumAgeCell = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! InsuranceInfoTableViewCell
                minimumAgeCell.infoButton.setTitle("\(minimumAge) years old", for: .normal)
            }
            
            // Minimum Years Experience
            if let minimumExperience = self.insuranceInfo.minimumExperience {
                var experienceString = String()
                if minimumExperience == 0 {
                    experienceString = "No minimum"
                } else {
                    experienceString = "\(minimumExperience) years"
                }
                let minimumExperienceCell = self.tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! InsuranceInfoTableViewCell
                minimumExperienceCell.infoButton.setTitle(experienceString, for: .normal)
            }
            
            // Date
            if let selectedDate = self.insuranceInfo.insuranceExpiresDate {
                let dateCell = self.tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! InsuranceInfoTableViewCell
                dateCell.infoButton.setTitle(self.formatDate(date: selectedDate), for: .normal)
            }
            
            // Accident Issue
            if let accidentIssue = self.insuranceInfo.accidentIssue {
                let accidentCell = self.tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as! InsuranceInfoExampleTableViewCell
                accidentCell.exampleTextView.text = accidentIssue
            }
        }
    }
    
    func switchChanged(_ sender: UISwitch) {
        if sender.tag == 0 {
            self.insuranceInfo.comprehensiveInsurance = sender.isOn
        } else {
            self.insuranceInfo.coversDrivers = sender.isOn
        }
    }
    
    //MARK: Navigation Actions
    
    func goToParent() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }

    func goToNextStep() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
    }
    
    //MARK: Picker Actions
    
    func showPicker(_ sender: UIButton) {
        var pickerDataSource = [String]()
        switch sender.tag {
        case 0:
            pickerDataSource = ["16 years old", "17 years old", "18 years old", "19 years old", "20 years old", "21 years old", "22 years old"]
            break
        case 1:
            pickerDataSource = ["No minimum", "1 year", "2 years", "3 years", "4 years", "5 years", "6 years"]
            break
        case 2:
            var date = Date()
            if let selectedDate = self.insuranceInfo.insuranceExpiresDate {
                date = selectedDate
            }
            ActionSheetDatePicker.show(withTitle: "Choose", datePickerMode: .date, selectedDate: date, doneBlock: { (picker, index, value) in
                sender.setTitle(self.formatDate(date: index as! Date), for: .normal)
                self.insuranceInfo.insuranceExpiresDate = index as? Date
            }, cancel: { (picker) in
                print("Canceled")
            }, origin: sender)
            return
        default:
            break
        }
        ActionSheetStringPicker.show(withTitle: "Choose", rows: pickerDataSource, initialSelection: 2, doneBlock: { (picker, index, value) in
            if sender.tag == 0 {
                self.insuranceInfo.minimumAge = (value! as AnyObject).integerValue
            } else {
                self.insuranceInfo.minimumExperience = (value! as AnyObject).integerValue
            }
            sender.setTitle(value! as? String, for: .normal)
        }, cancel: { (picker) in
            print("Canceled")
        }, origin: sender)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: date)
    }

    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension InsuranceInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return 200
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceInfoExampleCellIdentifier", for: indexPath) as! InsuranceInfoExampleTableViewCell
            if let accidentIssueText = self.insuranceInfo.accidentIssue {
                cell.exampleTextView.text = accidentIssueText
            } else {
                cell.exampleTextView.text = "Example\nExcess - $1,000 (per section)]\nIf accident occurs in Malaysia - $2,000\nIf driver is below the age of 25 - $1,500"
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceInfoCellIdentifier", for: indexPath) as! InsuranceInfoTableViewCell
            cell.infoLabel.text = self.infoDataSource[indexPath.row]
            cell.infoButton.isHidden = self.controlsDataSource[indexPath.row]
            cell.infoButton.addTarget(self, action: #selector(self.showPicker(_:)), for: .touchUpInside)
            cell.infoButton.tag = indexPath.row - 2
            cell.infoSwitch.isHidden = !self.controlsDataSource[indexPath.row]
            cell.infoSwitch.tag = indexPath.row
            cell.infoSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            return cell
        }
    }
}
