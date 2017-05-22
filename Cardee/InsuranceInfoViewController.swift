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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Cars"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(save))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(InsuranceInfoTableViewCell.self, forCellReuseIdentifier: "InsuranceInfoCellIdentifier")
        self.tableView.register(InsuranceInfoExampleTableViewCell.self, forCellReuseIdentifier: "InsuranceInfoExampleCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        self.view.addSubview(self.tableView)
        
        self.infoDataSource = ["Does the car has a comprehensive insusurance?", "Does the car insurance covers unnamed driver?", "What is the minimum age required for coverage? ", "What is the minimum years of driving experience required for coverage? ", "When does your insurance expires?"]
        
        self.controlsDataSource = [true, true, false, false, false]
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(self.back))
    }
    
    func back() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }

    func save() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
    }
    
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
            ActionSheetDatePicker.show(withTitle: "Choose", datePickerMode: .date, selectedDate: Date(), doneBlock: { (picker, index, value) in
                print("date")
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM, yyyy"
                sender.setTitle(dateFormatter.string(from: index as! Date), for: .normal)
            }, cancel: { (picker) in
                print("date")
            }, origin: sender)
            return
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceInfoCellIdentifier", for: indexPath) as! InsuranceInfoTableViewCell
            cell.infoLabel.text = self.infoDataSource[indexPath.row]
            cell.infoButton.isHidden = self.controlsDataSource[indexPath.row]
            cell.infoButton.addTarget(self, action: #selector(self.showPicker(_:)), for: .touchUpInside)
            cell.infoButton.tag = indexPath.row - 2
            cell.infoSwitch.isHidden = !self.controlsDataSource[indexPath.row]
            return cell
        }
    }
}
