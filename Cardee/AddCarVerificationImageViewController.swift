//
//  AddCarVerificationImageViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddCarVerificationImageViewController: UIViewController {

    var tableView: UITableView!
    
    @IBOutlet weak var carPhotoImageView: UIImageView!
    @IBOutlet weak var addCarPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Cars"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.carPhotoImageView.clipsToBounds = true
        
        let backButton = NextButtonObject()
        backButton.addButton(on: self.view)
    }

    @IBAction func addCarPhotoAction(_ sender: UIButton) {
        
    }
    
    func save() {
        print("Save")
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
