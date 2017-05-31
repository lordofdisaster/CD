//
//  SettingsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/23/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight)), style: .grouped)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = Color.lightGray
        self.tableView.tableFooterView = UIView()
        
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Share"
        case 1:
            return "General Settings"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
}
