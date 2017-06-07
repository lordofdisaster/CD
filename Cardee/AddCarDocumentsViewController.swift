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
    
    let imagePicker = UIImagePickerController()
    var selectedButtonIndex: Int?
    var carDocuments = CarDocuments()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Car Documents"
        
        self.initializeImagePicker()
        self.initializeTableView()
        self.setDefaultSelections()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NewCar.shared.carDocuments = self.carDocuments
    }
    
    //MARK: Actions
    
    func setDefaultSelections() {
        if let carDocuments = NewCar.shared.carDocuments {
            self.carDocuments = carDocuments
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
        
        self.headerDataSource = ["Upload your vehicle log card", "Upload your car insurance"]
        self.documentTypeDataSource = [.car, .car]
        
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
        cell.addPhotoButton.tag = indexPath.row
        cell.addPhotoButton.addTarget(self, action: #selector(self.chooseImage(_:)), for: .touchUpInside)
        
        if indexPath.row == 0 {
            if self.carDocuments.vehicleLogCard.count == 0 {
                cell.photoImageView.image = #imageLiteral(resourceName: "vehicle_log_card_sample")
            } else {
                cell.photoImageView.image = self.carDocuments.vehicleLogCard.last
                cell.countLabel.text = "\(self.carDocuments.vehicleLogCard.count) images"
            }
        } else {
            if self.carDocuments.vehicleInsurance.count == 0 {
                cell.photoImageView.image = #imageLiteral(resourceName: "vehicle_insurance_sample")
            } else {
                cell.photoImageView.image = self.carDocuments.vehicleInsurance.last
                cell.countLabel.text = "\(self.carDocuments.vehicleInsurance.count) images"
            }
        }
        return cell
    }
}

//MARK: UIImagePicker Delegate

extension AddCarDocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            
            if self.selectedButtonIndex == 0 {
                self.carDocuments.vehicleLogCard.append(pickedImage)
                cell.countLabel.text = "\(self.carDocuments.vehicleLogCard.count) images"
            } else {
                self.carDocuments.vehicleInsurance.append(pickedImage)
                cell.countLabel.text = "\(self.carDocuments.vehicleInsurance.count) images"
            }
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

