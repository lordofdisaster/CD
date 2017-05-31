//
//  DetailCarViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class DetailCarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 130.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 71, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240.0
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCarImageIdentifier", for: indexPath) as! DetailCarImageTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCarInfoIdentifier", for: indexPath) as! DetailCarInfoTableViewCell
            switch indexPath.row {
            case 1:
                cell.iconView.backgroundColor = Color.blue
                cell.iconImageView.image = #imageLiteral(resourceName: "car_features")
                cell.titleLabel.text = "Mazda 3"
                cell.descriptionLabel.text = "Sedan  5-seater  •  1.6L  Auto  •  Private-Hire"
                break
            case 2:
                cell.iconView.backgroundColor = Color.backgroundLightBlue
                cell.iconImageView.image = #imageLiteral(resourceName: "location")
                cell.exactLocationLabel.isHidden = false
                cell.titleLabel.text = "Location"
                cell.descriptionLabel.text = "3 Rivervale Link, The Rivervale"
                break
            case 3:
                cell.iconView.backgroundColor = Color.green
                cell.iconImageView.image = #imageLiteral(resourceName: "description")
                cell.titleLabel.text = "Description"
                cell.descriptionLabel.text = "Its simply a Range Rover and its amazing. Very clean and beautiful. All Wheel Drive. 385HP V8 Engine. 21 inch Premium Wheels Navigation, Bluetooth, Aux plug, Satellite radio.\n\nBlack Leather Interior - Heated Front and Rear Seats, Heated steering wheel.\n\nPlease enjoy it responsibly. Strictly no smoking and no eating!"
                break
            default:
                break
            }
            return cell
        }
    }
}

