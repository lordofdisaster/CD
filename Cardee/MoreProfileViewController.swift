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
    var menuLabels = [String]()
    var menuIcons = [UIImage]()
    var statusMenu: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        initTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLastMenuItem()
        tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func setLastMenuItem() {
        statusMenu = OWNER_STATUS ? "Switch To Renteer" : "Switch To Owner"
        
        self.menuLabels[self.menuLabels.count-1] = statusMenu
        
        
        
        
    }
    
}

//MARK: TableView Delegate + DataSource

extension MoreProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func initTable() {
        
        
        self.menuIcons = [#imageLiteral(resourceName: "account"), #imageLiteral(resourceName: "settings"), #imageLiteral(resourceName: "live_chat"), #imageLiteral(resourceName: "cardee"), #imageLiteral(resourceName: "switch_to_owner")]
        self.menuLabels = ["Account", "Settings", "Live Chat", "Cardee", "?"]
        
        setLastMenuItem()
        
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
        
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "showOwnerProfileSegue", sender: self)
        case 2:
            self.performSegue(withIdentifier: "showAccountDetailsSegue", sender: self)
        case 5:
            
            
            //and go to Rentee Storyboard
            var vcID: String!
            var storyBoardName: String!
            if OWNER_STATUS {
                vcID = "RenteeTabBarController"
                storyBoardName = "Rentee"
            } else {
                vcID = "CardeeTabBarController"
                storyBoardName = "Main"
            
            }
            
            OWNER_STATUS = !OWNER_STATUS
            
            let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: vcID) as UIViewController
            present(vc, animated: true, completion: nil)
            
            
        
        default:
            self.performSegue(withIdentifier: "showSettingsSegue", sender: self)
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCellIdentifier", for: indexPath) as? ProfileHeaderTableViewCell {
            
                cell.avatarImageView.image = #imageLiteral(resourceName: "avatar")
                return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileListItemCellIdentifier", for: indexPath) as? ProfileListItemTableViewCell {
                cell.itemImageView.image = self.menuIcons[indexPath.row - 1]
                cell.itemNameLabel.text = self.menuLabels[indexPath.row - 1]
                return cell
            
        }
        
        return UITableViewCell()
        
    }
}
