//
//  BrowseViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/23/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class BrowseViewController: CardeeViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Personal Car"
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight)))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.backgroundColor = Color.lightGray
        self.tableView.tableFooterView = UIView()
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 48))
        view.backgroundColor = Color.blue
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: Screen.width/2, height: 48)
        button.setTitle("Calendar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(self.showCalendar), for: .touchUpInside)
        view.addSubview(button)
        self.tableView.tableHeaderView = view
        
        self.view.addSubview(self.tableView)
    }
    
    func showCalendar() {
        self.performSegue(withIdentifier: "showCalendar", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
}
