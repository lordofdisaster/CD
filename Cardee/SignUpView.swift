//
//  SignupView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/26/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    var almostDoneLabel: UILabel!
    var addPhotoLabel: UILabel!
    var youPhotoImageView: UIImageView!
    var yourNameLabel: UILabel!
    var yourNameTextField: LoginTextField!
    var getStartedButton: UIButton!
    var backButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Color.blue
        
        // Back Button
        
        self.backButton = UIButton(type: .system)
        self.backButton.tintColor = UIColor.white
        self.backButton.frame = CGRect(x: 10, y: 30, width: 30, height: 30)
        self.backButton.setImage(#imageLiteral(resourceName: "chevron_left"), for: .normal)
        
        // Almost done label
        
        let almostDoneY = 70
        let almostDoneHeight = 20
        
        self.almostDoneLabel = UILabel(frame: CGRect(x: 0, y: almostDoneY, width: Int(Screen.width), height: almostDoneHeight))
        self.almostDoneLabel.font = UIFont.systemFont(ofSize: 16)
        self.almostDoneLabel.textColor = UIColor.white
        self.almostDoneLabel.text = "Almost done!"
        self.almostDoneLabel.textAlignment = .center
        
        // Add a photo label
        
        let addPhotoLabelTopOffset = 40
        let addPhotoLabelHeight = 20
        let addPhotoLabelY = almostDoneY + almostDoneHeight + addPhotoLabelTopOffset
        
        self.addPhotoLabel = UILabel(frame: CGRect(x: 0, y: addPhotoLabelY, width: Int(Screen.width), height: addPhotoLabelHeight))
        self.addPhotoLabel.font = UIFont.systemFont(ofSize: 16)
        self.addPhotoLabel.textColor = UIColor.white
        self.addPhotoLabel.text = "Add a photo of yourself"
        self.addPhotoLabel.textAlignment = .center
        
        // Photo imageview
        
        let photoImageTopOffset = 30
        let photoImageSize = 80
        let photoImageX = Int(Screen.width/2 - CGFloat(photoImageSize/2))
        let photoImageY = addPhotoLabelY + addPhotoLabelHeight + photoImageTopOffset
        
        self.youPhotoImageView = UIImageView(frame: CGRect(x: photoImageX, y: photoImageY, width: photoImageSize, height: photoImageSize))
        self.youPhotoImageView.contentMode = .scaleAspectFit
        self.youPhotoImageView.backgroundColor = Color.lightBlue
        self.youPhotoImageView.layer.cornerRadius = 40
        self.youPhotoImageView.layer.masksToBounds = true
        self.youPhotoImageView.clipsToBounds = true
        self.youPhotoImageView.isUserInteractionEnabled = true
        
        // Your name label
        
        let yourNameLabelTopOffset = 30
        let yourNameLabelY = photoImageY + photoImageSize + yourNameLabelTopOffset
        let yourNameLabelHeight = 20
        
        self.yourNameLabel = UILabel(frame: CGRect(x: 0, y: yourNameLabelY, width: Int(Screen.width), height: yourNameLabelHeight))
        self.yourNameLabel.font = UIFont.systemFont(ofSize: 16)
        self.yourNameLabel.textColor = UIColor.white
        self.yourNameLabel.text = "What is your name?"
        self.yourNameLabel.textAlignment = .center
        
        // You name textfield
        
        let yourNameTextFieldSideOffset = 40
        let yourNameTextFieldTopOffset = 30
        let yourNameTextFieldHeight = 50
        let yourNameTextFieldY = yourNameLabelY + yourNameLabelHeight + yourNameTextFieldTopOffset
        let yourNameTextFieldWidth = Screen.width - CGFloat(2 * yourNameTextFieldSideOffset)
        
        self.yourNameTextField = LoginTextField(frame: CGRect(x: yourNameTextFieldSideOffset, y: yourNameTextFieldY, width: Int(yourNameTextFieldWidth), height: yourNameTextFieldHeight), customPlaceholder: "Enter your name")
        self.yourNameTextField.layer.cornerRadius = 5
        self.yourNameTextField.clipsToBounds = true
        
        // Get started button
        
        let getStartedButtonOffset = 40
        let getStartedButtonHeight = 50
        let getStartedButtonY = Screen.height - CGFloat(getStartedButtonHeight) - 20
        let getStartedButtonWidth = Screen.width - CGFloat(2 * getStartedButtonOffset)
        
        self.getStartedButton = UIButton(type: .system)
        self.getStartedButton.frame = CGRect(x: getStartedButtonOffset, y: Int(getStartedButtonY), width: Int(getStartedButtonWidth), height: getStartedButtonHeight)
        self.getStartedButton.setTitle("Let's get started!", for: .normal)
        self.getStartedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.getStartedButton.setTitleColor(Color.blue, for: .normal)
        self.getStartedButton.backgroundColor = UIColor.white
        self.getStartedButton.layer.cornerRadius = 5
        self.getStartedButton.layer.masksToBounds = true
        
        self.addSubview(self.backButton)
        self.addSubview(self.almostDoneLabel)
        self.addSubview(self.addPhotoLabel)
        self.addSubview(self.youPhotoImageView)
        self.addSubview(self.yourNameLabel)
        self.addSubview(self.yourNameTextField)
        self.addSubview(self.getStartedButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }

}
