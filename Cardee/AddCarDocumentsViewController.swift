//
//  AddCarDocumentsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddCarDocumentsViewController: UIViewController {

    var tableView: UITableView!
    var headerDataSource = [String]()
    var documentTypeDataSource = [DocumentType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Car Documents"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddDocumentsTableViewCell.self, forCellReuseIdentifier: "AddDocumentsCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 135, right: 0)
        self.view.addSubview(self.tableView)
        
        self.headerDataSource = ["Upload your vehicle log card", "Upload your car insurance"]
        self.documentTypeDataSource = [.car, .car]
        
        let nextButton = NextButtonObject()
        nextButton.addButton(on: self.view)
        var newFrame = nextButton.backView.frame
        newFrame.origin.y -= 43
        nextButton.backView.frame = newFrame
        
        // Header view
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 60))
        headerView.backgroundColor = Color.backgroundBlue
        let headerLabel = UILabel(frame: CGRect(x: 13, y: 13, width: Screen.width - 2 * 13, height: 34))
        headerLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        headerLabel.numberOfLines = 2
        headerLabel.textColor = Color.grayText
        headerLabel.text = "Alternatively, you can email any of these documents to docs@cardee.com"
        headerView.addSubview(headerLabel)
        
        // Footer view
        
        let footerView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 43 - 44 - 20, width: Screen.width, height: 43))
        footerView.backgroundColor = UIColor.white
        
        let topSeparatorView = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 1))
        topSeparatorView.backgroundColor = Color.lightGray
        
        let footerButton = UIButton(type: .system)
        footerButton.frame = footerView.bounds
        footerButton.setTitle("I’ve emailed missing documents over", for: .normal)
        footerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        footerButton.setTitleColor(#colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1), for: .normal)
        
        footerView.addSubview(footerButton)
        footerView.addSubview(topSeparatorView)
        self.view.addSubview(footerView)
        
        self.tableView.tableHeaderView = headerView
    }
    
    func save() {
        print("Save")
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension AddCarDocumentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddDocumentsTableViewCell(reuseIdentifier: "AddDocumentsCellIdentifier", type: self.documentTypeDataSource[indexPath.row])
        cell.headerLabel.text = self.headerDataSource[indexPath.row]
        return cell
    }
}
