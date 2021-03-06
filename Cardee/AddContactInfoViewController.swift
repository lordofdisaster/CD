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

        NewCar.shared.contactInfo = self.contactInfo
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
        if let filledContactInfo = NewCar.shared.contactInfo {
            self.contactInfo = filledContactInfo
        }
    }
    
    //MARK: Navigation Actions
    
    func goToParent() {
        
        var emailIsValid = false
        var phoneNumberIsValid = false
        
        if let email = self.contactInfo.email {
            if !Methods.isValidEmail(email: email) {
                CardeeAlert.showAlert(withTitle: "Error", message: "Your email is not valid. Please check it.", sender: self)
            } else {
                emailIsValid = true
            }
        } else {
            emailIsValid = true
        }
        
        if var mobileNumber = self.contactInfo.mobileNumber {
            if mobileNumber.characters.count > 15 {
                self.contactInfo.mobileNumber?.characters.removeLast()
                mobileNumber = self.contactInfo.mobileNumber!
                phoneNumberIsValid = true
            } else if mobileNumber.characters.count == 15 {
                phoneNumberIsValid = true
            } else if mobileNumber.characters.count < 14 {
                phoneNumberIsValid = false
            }
        } else {
            phoneNumberIsValid = true
        }
    
        if !emailIsValid {
            CardeeAlert.showAlert(withTitle: "Error", message: "Your email is not valid. Please check it.", sender: self)
        } else if !phoneNumberIsValid {
            CardeeAlert.showAlert(withTitle: "Error", message: "Your phone number is not valid. Please check it.", sender: self)
        } else {
            let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
            self.navigationController?.popToViewController(vc, animated: true)
        }
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
            cell.infoTextField.keyboardType = .alphabet
            if let textFieldInfo = self.contactInfo.name {
                cell.infoTextField.text = textFieldInfo
            }
            break
        case 1:
            cell.infoTextField.keyboardType = .numberPad
            if let textFieldInfo = self.contactInfo.mobileNumber {
                cell.infoTextField.text = textFieldInfo
            } else {
                cell.infoTextField.text = "+(65) "
            }
            break
        case 2:
            cell.infoTextField.keyboardType = .emailAddress
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
            cell.infoTextField.keyboardType = .numberPad
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
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            
            if length == 0 || length > 10 {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                return (newLength > 9) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if (length - index) > 2 {
                let areaCode = decimalString.substring(with: NSMakeRange(index, 2))
                formattedString.appendFormat("+(%@) ", areaCode)
                index += 2
            }
            if length - index > 4 {
                let prefix = decimalString.substring(with: NSMakeRange(index, 4))
                formattedString.appendFormat("%@-", prefix)
                index += 4
            }
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String
            return false
            //break
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
