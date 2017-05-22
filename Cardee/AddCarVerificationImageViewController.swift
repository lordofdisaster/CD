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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(save))
        
        self.carPhotoImageView.clipsToBounds = true
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(self.back))
    }
    
    func back() {
        let vc = self.navigationController?.viewControllers[1] as! AddCarViewController
        self.navigationController?.popToViewController(vc, animated: true)
    }

    @IBAction func addCarPhotoAction(_ sender: UIButton) {
        
    }
    
    func save() {
        self.performSegue(withIdentifier: "nextSegue", sender: self)
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
