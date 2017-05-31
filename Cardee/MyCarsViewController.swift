//
//  MyCarsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/4/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class MyCarsViewController: CardeeViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Cars"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Car", style: .plain, target: self, action: #selector(addCar))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight) - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CarTableViewCell.self, forCellReuseIdentifier: "CarCellIdentifier")
        self.tableView.backgroundColor = Color.lightGray
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
    }
    
    //MARK: Actions
    
    func addCar() {
        self.performSegue(withIdentifier: "AddCarSegue", sender: self)
    }
    
    //MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension MyCarsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 286
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCellIdentifier", for: indexPath) as! CarTableViewCell
        cell.carImageView.image = UIImage(named: "Mazda.jpg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailCar", sender: self)
    }
}
