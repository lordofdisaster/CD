//
//  AddCarVerificationImageViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddCarVerificationImageViewController: UIViewController {

    @IBOutlet weak var carPhotoImageView: UIImageView!
    @IBOutlet weak var addCarPhotoButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    var carVerification = CarVerification()
    
    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Image"
        
        self.initializeImagePicker()
        self.setDefaultSelection()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goToNextStep))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron_left"), style: .plain, target: self, action: #selector(self.goToParent))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NewCar.sharedInstance.carVerification = self.carVerification
    }
    
    //MARK: Actions
    
    func setDefaultSelection() {
        if let carVerification = NewCar.sharedInstance.carVerification {
            self.carVerification = carVerification
            if let carImage = self.carVerification.carImage {
                self.carPhotoImageView.image = carImage
            }
        }
    }
    
    @IBAction func addCarPhotoAction(_ sender: UIButton) {
        self.chooseImage()
    }
    
    //MARK: Navigation Actions
    
    func goToNextStep() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
    }
    
    func goToParent() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    //MARK: Initializers
    
    func initializeImagePicker() {
        self.imagePicker.delegate = self
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: UIImagePicker Delegate

extension AddCarVerificationImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            self.carPhotoImageView.image = pickedImage
            self.carVerification.carImage = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
