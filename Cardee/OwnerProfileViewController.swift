//
//  OwnerProfileViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/27/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class OwnerProfileViewController: CardeeViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeController()
        self.initializeTableView()
    }
    
    //MARK: Car Carousel Action
    
    func selectCarFromCarousel(_ sender: UIButton) {
        print("Tap \(sender.tag)")
    }
    
    //MARK: Initializers
    
    func initializeController() {
        self.title = "Owner Profile"
    }
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(OwnerInfoTableViewCell.self, forCellReuseIdentifier: "OwnerInfoCellIdentifier")
        self.tableView.register(OwnerDescriptionTableViewCell.self, forCellReuseIdentifier: "OwnerDescriptionCellIdentifier")
        self.tableView.register(OwnerCarsCarouselTableViewCell.self, forCellReuseIdentifier: "OwnerCarsCarouselCellIdentifier")
        self.tableView.register(OwnerCarReviewTableViewCell.self, forCellReuseIdentifier: "OwnerCarReviewCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
    }
    
    //MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OwnerProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 126
        case 2:
            return 170
        case 3:
            return 340
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerInfoCellIdentifier", for: indexPath) as! OwnerInfoTableViewCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerDescriptionCellIdentifier", for: indexPath) as! OwnerDescriptionTableViewCell
            return cell
        } else  if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCarsCarouselCellIdentifier", for: indexPath) as! OwnerCarsCarouselTableViewCell
            for (index, car) in cell.carsArray.enumerated() {
                car.overButton.addTarget(self, action: #selector(self.selectCarFromCarousel(_:)), for: .touchUpInside)
                car.overButton.tag = index
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCarReviewCellIdentifier", for: indexPath) as! OwnerCarReviewTableViewCell
            return cell
        }
    }
}
