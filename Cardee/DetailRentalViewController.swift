//
//  DetailRentalViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class DetailRentalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 112, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Actions
    
    func editDate() {
        let calendarViewController = CalendarViewController()
        self.navigationController?.pushViewController(calendarViewController, animated: true)
    }
    
    func editTime() {
        
    }
}

extension DetailRentalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        } else if indexPath.row == 1 {
            return 235.0
        } else if indexPath.row == 2 {
            return 165.0
        } else if indexPath.row == 3 {
            return 105.0
        } else {
            return 72.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalAvailabilityIdentifier", for: indexPath) as! DetailRentalAvailabilityTableViewCell
            cell.editDateButton.addTarget(self, action: #selector(self.editDate), for: .touchUpInside)
            cell.editTimeButton.addTarget(self, action: #selector(self.editTime), for: .touchUpInside)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalSettingsIdentifier", for: indexPath) as! DetailRentalSettingsTableViewCell
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalRatesIdentifier", for: indexPath) as! DetailRentalRatesTableViewCell
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalFuelIdentifier", for: indexPath) as! DetailRentalFuelTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailRentalTermsIdentifier", for: indexPath) as! DetailRentalTermsTableViewCell
            return cell
        }
    }
}

