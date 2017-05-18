//
//  AddCarInfoViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddCarInfoViewController: UIViewController {
    
    var tableView: UITableView!
    var infoDataSource = [String]()
    var placeHolderDataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Cars"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddCarInfoTableViewCell.self, forCellReuseIdentifier: "AddCarInfoCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        self.view.addSubview(self.tableView)
        
        self.infoDataSource = ["Car Brand", "Car Model", "Year of Manufacture", "Car Titile", "License Plate Number", "Seating Capacity", "Engine Capacity", "Transmission", "Body Type(s)"]
        self.placeHolderDataSource = ["E.g. Toyota, Honda, BMW etc.", "E.g. Altis, Camry, Prius etc.", "Please select", "E.g. Toyota Camry, BMW 3 Hybrid etc.", "E.g. SJX8938Y", "Please select", "Please select", "Please select", "Please select"]
        
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
        cell.infoTextField.placeholder = self.placeHolderDataSource[indexPath.row]
        return cell
    }
}
