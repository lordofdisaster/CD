//
//  EditRentalTermsRequirementsTableViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/14/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import MBProgressHUD

class EditRentalTermsRequirementsTableViewController: UITableViewController {

    @IBOutlet weak var setAgeButton: UIButton!
    @IBOutlet weak var experienceButton: UIButton!
    
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Requirements"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveRequirements))
    }
    
    // MARK: Actions
    
    func saveRequirements() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.changeRentalTermsFor(car: self.car) { success, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            if success {
                print("Success")
            } else {
                print("Error")
            }
        }
    }
    
    @IBAction func setAgeAction(_ sender: UIButton) {
        var ageDataSource = [String]()
        for i in 0..<81 {
            ageDataSource.append("\(i + 18)")
        }
        ActionSheetMultipleStringPicker.show(withTitle: "Choose available age", rows: [ageDataSource, ageDataSource], initialSelection: [3, 47], doneBlock: { picker, index, value in
            sender.setTitle("\(ageDataSource[(index?[0] as AnyObject).integerValue]) to \(ageDataSource[(index?[1] as AnyObject).integerValue]) yrs old", for: .normal)
            self.car.minimumAge = Int(ageDataSource[(index?[0] as AnyObject).integerValue])
            print(index!, value!)
        }, cancel: { (picker) in
            print("Cancelled by user")
        }, origin: sender)
    }
    
    @IBAction func setExperienceAction(_ sender: UIButton) {
        var experienceDataSource = [String]()
        for i in 0..<98 {
            experienceDataSource.append("\(i + 1)")
        }
        ActionSheetStringPicker.show(withTitle: "Choose driving experience", rows: experienceDataSource, initialSelection: 0, doneBlock: { picker, index, value in
            print(index, value!)
            self.car.driverExperience = Int(experienceDataSource[index])
        }, cancel: { (picker) in
            print("Cancelled by user")
        }, origin: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
