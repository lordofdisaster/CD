//
//  AddContactInfoViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddContactInfoViewController: UIViewController {
    
    var tableView: UITableView!
    var infoDataSource = [String]()
    var placeHolderDataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact Info"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddCarInfoTableViewCell.self, forCellReuseIdentifier: "AddCarInfoCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        self.view.addSubview(self.tableView)
        
        self.infoDataSource = ["Your Name", "Your Mobile Number", "Your Email", "Bank / Account Type", "Account Number"]
        self.placeHolderDataSource = ["Please enter", "Please enter", "Please enter", "E.g. DBS savings account", "E.g. 1002003001"]
        
        let nextButton = NextButtonObject()
        nextButton.addButton(on: self.view)
    }

    func save() {
        print("Save")
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension AddContactInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCarInfoCellIdentifier", for: indexPath) as! AddCarInfoTableViewCell
        cell.infoLabel.text = self.infoDataSource[indexPath.row]
        cell.infoTextField.placeholder = self.placeHolderDataSource[indexPath.row]
        return cell
    }
}
