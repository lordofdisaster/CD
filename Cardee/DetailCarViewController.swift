//
//  DetailCarViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class DetailCarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var carId = Int()
    var car = Car()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 130.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 71, right: 0)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.getCarWith(id: self.carId) { object, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.car = object as! Car
            self.parent?.title = self.car.licensePlateNumber
            self.tableView.reloadData()
        }
        
    }
    
    func updateCarInfo(car: Car) {
        self.car = car
        self.tableView.reloadData()
    }
    
    func editCarLocation() {
        self.performSegue(withIdentifier: "editLocationSegue", sender: self)
    }
    
    func editDescriptionInfo() {
        self.performSegue(withIdentifier: "editDescriptionSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editDescriptionSegue" {
            if let editDescriptionViewController = segue.destination as? UINavigationController {
                (editDescriptionViewController.viewControllers[0] as! EditDetailCarDescriptionViewController).car = self.car
            }
        }
        if segue.identifier == "editLocationSegue" {
            if let editDescriptionViewController = segue.destination as? UINavigationController {
                (editDescriptionViewController.viewControllers[0] as! EditDetailCarLocationViewController).car = self.car
            }
        }
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
            
            if let imageUrl = URL(string: self.car.carImage) {
                cell.carImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(), filter: nil, progress: { progress in
                    print("Progress \(progress)")
                }, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { data in
                    print(data)
                }
            }
            
            if let carTitle = self.car.carTitle, let carYear = self.car.yearManufacture {
                let yearAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin) ]
                let yearAttributedString = NSAttributedString(string: carYear, attributes: yearAttribute)
                
                let carNameAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold) ]
                let carNameAttributedString = NSAttributedString(string: carTitle + "  ", attributes: carNameAttribute)
                
                let result = NSMutableAttributedString()
                result.append(carNameAttributedString)
                result.append(yearAttributedString)
                cell.carTitle.attributedText = result
            } else {
                cell.carTitle.text = "Not specified"
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCarInfoIdentifier", for: indexPath) as! DetailCarInfoTableViewCell
            switch indexPath.row {
            case 1:
                cell.iconView.backgroundColor = Color.blue
                cell.iconImageView.image = #imageLiteral(resourceName: "car_features")
                
                if let carTitle = self.car.carTitle {
                    cell.titleLabel.text = carTitle
                } else {
                    cell.titleLabel.text = "Not specified"
                }
                
                cell.descriptionLabel.text = "Sedan  5-seater  •  1.6L  Auto  •  Private-Hire"
                break
            case 2:
                cell.iconView.backgroundColor = Color.backgroundLightBlue
                cell.iconImageView.image = #imageLiteral(resourceName: "location")
                cell.exactLocationLabel.isHidden = !self.car.isExactLocationHidden
                cell.titleLabel.text = "Location"
                if let town = self.car.town, let address = self.car.address {
                    cell.descriptionLabel.text = "\(town), \(address)"
                } else {
                    cell.descriptionLabel.text = "Not specified"
                }
                cell.editButton.addTarget(self, action: #selector(self.editCarLocation), for: .touchUpInside)
                break
            case 3:
                cell.iconView.backgroundColor = Color.green
                cell.iconImageView.image = #imageLiteral(resourceName: "description")
                cell.titleLabel.text = "Description"
                if let carDescription = self.car.carDescription {
                    if !carDescription.isEmpty {
                        cell.descriptionLabel.text = carDescription
                    } else {
                        cell.descriptionLabel.text = "Not specified"
                    }
                } else {
                    cell.descriptionLabel.text = "Not specified"
                }
                cell.editButton.addTarget(self, action: #selector(self.editDescriptionInfo), for: .touchUpInside)
                break
            default:
                break
            }
            return cell
        }
    }
}

