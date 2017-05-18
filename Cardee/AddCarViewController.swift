//
//  AddCarViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddCarViewController: CardeeViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var infoKeysArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Car"
        self.infoKeysArray = ["Vehicle Type", "Insurance Info", "Car Info", "Car Image", "Car Location", "Car Documents", "Personal Documents", "Contact Info"]
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    //MARK: Actions
    
    func addCarInfo(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.performSegue(withIdentifier: "addVehicleTypeSegue", sender: self)
            break
        case 1:
            self.performSegue(withIdentifier: "addInsuranceInfoSegue", sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: "addCarInfoSegue", sender: self)
            break
        case 3:
            self.performSegue(withIdentifier: "addCarVerificationImageSegue", sender: self)
            break
        case 4:
            self.performSegue(withIdentifier: "addCarLocationSegue", sender: self)
            break
        case 5:
            self.performSegue(withIdentifier: "addCarDocumentsSegue", sender: self)
            break
        case 6:
            self.performSegue(withIdentifier: "addPersonalDocumentsSegue", sender: self)
            break
        case 7:
            self.performSegue(withIdentifier: "addContactInfoSegue", sender: self)
            break
        default:
            print("Hello")
        }
    }

    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension AddCarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCarCellIdentifier", for: indexPath) as! AddCarTableViewCell
        cell.infoKeyLabel.text = "\(indexPath.row + 1). \(self.infoKeysArray[indexPath.row])"
        cell.fillInfoButton.setTitle("Add", for: .normal)
        cell.fillInfoButton.addTarget(self, action: #selector(addCarInfo(_:)), for: .touchUpInside)
        cell.fillInfoButton.tag = indexPath.row
        return cell
    }
}
