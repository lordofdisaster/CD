//
//  RenterProfileViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/19/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class RenterProfileViewController: CardeeViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Renter Profile"
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(RenterProfileHeaderTableViewCell.self, forCellReuseIdentifier: "RenterProfileHeaderCellIdentifier")
        self.tableView.register(OwnerDescriptionTableViewCell.self, forCellReuseIdentifier: "OwnerDescriptionTableViewCell")
        self.tableView.register(OwnerCarReviewTableViewCell.self, forCellReuseIdentifier: "OwnerCarReviewCellIdentifier")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RenterProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 133
        case 1:
            return 126
        case 2:
            return 340
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RenterProfileHeaderCellIdentifier", for: indexPath) as! RenterProfileHeaderTableViewCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerDescriptionTableViewCell", for: indexPath) as! OwnerDescriptionTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCarReviewCellIdentifier", for: indexPath) as! OwnerCarReviewTableViewCell
            cell.carNameLabel.isHidden = true
            return cell
        }
    }
    
}
