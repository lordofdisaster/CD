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
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeController()
        self.initializeImagePicker()
        self.initializeTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Initializers
    
    func initializeImagePicker() {
        self.imagePicker.delegate = self
    }
    
    //MARK: Car Carousel Action
    
    func selectCarFromCarousel(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showDetailCar", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailCar" {
            let index = (sender as! UIButton).tag
            if let detailCarViewController = segue.destination as? VCViewController {
                detailCarViewController.carId = OwnerProfile.shared.cars[index].carId!
            }
        }
    }
    
    //MARK: Initializers
    
    func initializeController() {
        self.title = "Owner Profile"
    }
    
    func initializeTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height - CGFloat(System.tabBarHeight)))
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
            if OwnerProfile.shared.cars.count > 0 {
                return 170
            } else {
                return 50
            }
        case 3:
            if OwnerProfile.shared.reviewCount > 0 {
                return 340
            } else {
                return 52
            }
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
            cell.usernameLabel.text = OwnerProfile.shared.name
            cell.changeButton.addTarget(self, action: #selector(self.chooseImage), for: .touchUpInside)
            if let profilePhoto = OwnerProfile.shared.profilePhoto{
                cell.avatarImageView.image = profilePhoto;
            }
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
            cell.reviewHederLabel.text = "\(OwnerProfile.shared.reviewCount!) Car Reviews"
            return cell
        }
    }
}

//MARK: UIImagePicker Delegate

extension OwnerProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    func chooseImage() {
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
            let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! OwnerInfoTableViewCell
            cell.avatarImageView.image = pickedImage
            AlamofireManager.set(avatar: pickedImage)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

