//
//  AccountViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/22/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AccountDetailsViewController: CardeeViewController {
    
    var tableView: UITableView!
    var infoDataSource = [String]()
    var placeHolderDataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Account Details"
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight)), style: .grouped)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddCarInfoTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(PaymentMethodTableViewCell.self, forCellReuseIdentifier: "PaymentCell")
        self.tableView.backgroundColor = Color.lightGray
        self.tableView.tableFooterView = UIView()
        
        self.infoDataSource = ["Name", "Email", "Mobile Number", "Password", "Button"]
        self.placeHolderDataSource = ["E.g. Andy Lee", "E.g. mail@mail.com", "E.g. +65 1234 43211", "E.g. 123456789", "Button"]
        
        self.view.addSubview(self.tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AccountDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 4 && indexPath.section == 0) || indexPath.section == 1 || indexPath.section == 2 {
            return 50
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            return 1
        } else {
            return 3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Account Details"
        case 2:
            return "Payment Method"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 || indexPath.section == 1 || (indexPath.row == 2 && indexPath.section == 2)  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! ButtonTableViewCell
            return cell
        } else if (indexPath.section == 2 && indexPath.row != 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentMethodTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddCarInfoTableViewCell
            cell.infoLabel.text = self.infoDataSource[indexPath.row]
            cell.infoTextField.placeholder = self.placeHolderDataSource[indexPath.row]
            return cell
        }
        
    }
}
