//
//  EditDescriptionViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/1/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class EditDetailCarDescriptionViewController: CardeeViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var tipViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Car Description"
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
        self.dismiss(animated: true, completion: nil)
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
