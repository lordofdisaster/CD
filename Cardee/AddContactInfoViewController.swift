//
//  AddContactInfoViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddContactInfoViewController: UIViewController {
    
    var tableView: UITableView!
    var infoDataSource = [String]()
    var placeHolderDataSource = [String]()
    
    var contactInfo = ContactInfo()

    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact Info"
        
        self.initializeTableView()
        self.setDefaultSelections()
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.goToParent))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NewCar.sharedInstance.contactInfo = self.contactInfo
    }
    
    //MARK: Initializers
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.register(AddCarInfoTableViewCell.self, forCellReuseIdentifier: "AddCarInfoCellIdentifier")
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        self.view.addSubview(self.tableView)
        self.infoDataSource = ["Your Name", "Your Mobile Number", "Your Email", "Bank / Account Type", "Account Number"]
        self.placeHolderDataSource = ["Please enter", "Please enter", "Please enter", "E.g. DBS savings account", "E.g. 1002003001"]
    }

    //MARK: Actions
    
    func setDefaultSelections() {
        if let filledContactInfo = NewCar.sharedInstance.contactInfo {
            self.contactInfo = filledContactInfo
        }
    }
    
    //MARK: Navigation Actions
    
    func goToParent() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension AddContactInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCarInfoCellIdentifier", for: indexPath) as! AddCarInfoTableViewCell
        cell.infoLabel.text = self.infoDataSource[indexPath.row]
        cell.infoTextField.delegate = self
        cell.infoTextField.tag = indexPath.row
        cell.infoTextField.placeholder = self.placeHolderDataSource[indexPath.row]
        
        switch indexPath.row {
        case 0:
            if let textFieldInfo = self.contactInfo.name {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 1:
            if let textFieldInfo = self.contactInfo.mobileNumber {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 2:
            if let textFieldInfo = self.contactInfo.email {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 3:
            if let textFieldInfo = self.contactInfo.accountType {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 4:
            if let textFieldInfo = self.contactInfo.accountNumber {
                cell.infoTextField.text = textFieldInfo
            }
            break
        default:
            break
        }
        
        return cell
    }
}

extension AddContactInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.tableView.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let editedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        switch textField.tag {
        case 0:
            self.contactInfo.name = editedString
            break
        case 1:
            self.contactInfo.mobileNumber = editedString
            break
        case 2:
            self.contactInfo.email = editedString
            break
        case 3:
            self.contactInfo.accountType = editedString
            break
        case 4:
            self.contactInfo.accountNumber = editedString
            break
        default:
            break
        }
        return true
    }
}
