//
//  EarningsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 7/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class EarningsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension EarningsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0 {
            return 225.0
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Breakdown"
        } else {
            return "Bookings"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EarningTotalCellIdentifier", for: indexPath) as! EarningsTotalTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EarningsHistoryCellIdentifier", for: indexPath) as! EarningsHistoryTableViewCell
            return cell
        }
    }
}

