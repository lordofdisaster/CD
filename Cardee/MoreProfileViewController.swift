//
//  MoreProfileViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class MoreProfileViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView(frame: CGRect(x: 0, y: -20, width: Screen.width, height: Screen.height + 50))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProfileHeaderTableViewCell.self, forCellReuseIdentifier: "ProfileHeaderCellIdentifier")
        self.tableView.register(ProfileListItemTableViewCell.self, forCellReuseIdentifier: "ProfileListItemCellIdentifier")
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        
        let fotview = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        fotview.textColor = Color.lightGrayText
        fotview.text = "Cardee 1.0"
        fotview.textAlignment = .center
        fotview.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightBold)
        
        
        self.tableView.tableFooterView = fotview
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension MoreProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 130
        } else {
            return 60
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "showRenterProfileSegue", sender: self)
        } else if indexPath.row == 5 {
            self.performSegue(withIdentifier: "showOwnerProfileSegue", sender: self)
        } else {
            self.performSegue(withIdentifier: "showAccountDetailsSegue", sender: self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCellIdentifier", for: indexPath) as! ProfileHeaderTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileListItemCellIdentifier", for: indexPath) as! ProfileListItemTableViewCell
            if indexPath.row == 5 {
                cell.itemNameLabel.text = "Switch To Owner"
            }
            return cell
        }
    }
}