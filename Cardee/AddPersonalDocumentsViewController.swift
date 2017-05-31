//
//  AddPersonalDocumentsViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddPersonalDocumentsViewController: UIViewController {
    
    var tableView: UITableView!
    var headerDataSource = [String]()
    var documentTypeDataSource = [DocumentType]()
    
    let imagePicker = UIImagePickerController()
    var selectedButtonIndex: Int?
    var personalDocuments = PersonalDocuments()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Personal Documents"
        
        self.initializeImagePicker()
        self.initializeTableView()
        self.setDefaultSelections()
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NewCar.sharedInstance.personalDocuments = self.personalDocuments
    }
    
    //MARK: Actions
    
    func setDefaultSelections() {
        if let personalDocuments = NewCar.sharedInstance.personalDocuments {
            self.personalDocuments = personalDocuments
        }
    }
    
    //MARK: Navigation Actions
    
    func goToParent() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    func goToNextStep() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
    }
    
    //MARK: Initializers
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.navigationBarHeight) - CGFloat(System.statusBarHeight)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(AddDocumentsTableViewCell.self, forCellReuseIdentifier: "AddDocumentsCellIdentifier")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 135, right: 0)
        self.view.addSubview(self.tableView)
        
        self.headerDataSource = ["Upload an image of the front of your identity card.", "Upload an image of the back of your identity card.", "If car is registered under a company, upload your business profile"]
        self.documentTypeDataSource = [.personal, .personal, .car]
        
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
    
    func initializeImagePicker() {
        self.imagePicker.delegate = self
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: TableView Delegate + DataSource

extension AddPersonalDocumentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 240
        } else {
            return 162
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddDocumentsTableViewCell(reuseIdentifier: "AddDocumentsCellIdentifier", type: self.documentTypeDataSource[indexPath.row])
        cell.headerLabel.text = self.headerDataSource[indexPath.row]
        cell.addPhotoButton.tag = indexPath.row
        cell.addPhotoButton.addTarget(self, action: #selector(self.chooseImage(_:)), for: .touchUpInside)
        switch indexPath.row {
        case 0:
            if let frontIdentityCardImage = self.personalDocuments.frontIdentityCardImage {
                cell.photoImageView.image = frontIdentityCardImage
            } else {
                cell.photoImageView.image = #imageLiteral(resourceName: "front_id_card")
            }
            cell.countBackgroundView.isHidden = true
            break
        case 1:
            if let backIdentityCardImage = self.personalDocuments.backIdentityCardImage {
                cell.photoImageView.image = backIdentityCardImage
            } else {
                cell.photoImageView.image = #imageLiteral(resourceName: "back_id_card")
            }
            cell.countBackgroundView.isHidden = true
            break
        case 2:
            if self.personalDocuments.businessProfile.count == 0 {
                cell.photoImageView.image = #imageLiteral(resourceName: "bussines_doc")
            } else {
                cell.photoImageView.image = self.personalDocuments.businessProfile.last
                cell.countLabel.text = "\(self.personalDocuments.businessProfile.count) images"
            }
            break
        default:
            break
        }
        return cell
    }
}

//MARK: UIImagePicker Delegate

extension AddPersonalDocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func chooseImage(_ sender: UIButton) {
        
        self.selectedButtonIndex = sender.tag
        
        let alert = UIAlertController(title: Login.chooseImageString, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Login.cameraString, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: Login.galleryString, style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: Login.cancelString, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            let cell = self.tableView.cellForRow(at: IndexPath(row: self.selectedButtonIndex!, section: 0)) as! AddDocumentsTableViewCell
            cell.photoImageView.image = pickedImage
            
            switch self.selectedButtonIndex! {
            case 0:
                self.personalDocuments.frontIdentityCardImage = pickedImage
                break
            case 1:
                self.personalDocuments.backIdentityCardImage = pickedImage
                break
            case 2:
                self.personalDocuments.businessProfile.append(pickedImage)
                cell.countLabel.text = "\(self.personalDocuments.businessProfile.count) images"
                break
            default:
                break
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
