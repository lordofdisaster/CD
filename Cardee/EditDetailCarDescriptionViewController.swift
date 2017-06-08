//
//  EditDescriptionViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/1/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD

class EditDetailCarDescriptionViewController: CardeeViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var tipViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextViewBottomConstraint: NSLayoutConstraint!
    
    var car: Car!
    var present: DetailCarViewController!
    
    //MARK: Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.present = (self.presentingViewController! as! UINavigationController).viewControllers[1].childViewControllers[0].childViewControllers[0] as! DetailCarViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Description"
        self.descriptionTextView.text = self.car.carDescription
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveInfo))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: self, action: #selector(self.goBack))
    }
    
    //MARK: Actions
    
    @IBAction func closeTipViewAction(_ sender: Any) {
        self.tipViewBottomConstraint.constant = -76.0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func animateTextViewHeightChange() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Navigation Actions
    
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveInfo() {
        MBProgressHUD.showAdded(to: (self.navigationController?.view)!, animated: true)
        AlamofireManager.change(description: self.descriptionTextView.text, forCarWith: self.car.carId) { success, error in
            MBProgressHUD.hide(for: (self.navigationController?.view)!, animated: true)
            if success {
                self.car.carDescription = self.descriptionTextView.text
                self.dismiss(animated: true) {
                    self.present.updateCarInfo(car: self.car)
                }
            } else {
                CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
            }
        }
    }
    
    //MARK: Memory Warning
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: UITextView Extension

extension EditDetailCarDescriptionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionTextViewBottomConstraint.constant = 225.0
        self.animateTextViewHeightChange()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.descriptionTextViewBottomConstraint.constant = 0
        self.animateTextViewHeightChange()
    }
}
