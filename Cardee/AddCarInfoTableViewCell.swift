//
//  AddCarInfoTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddCarInfoTableViewCell: UITableViewCell {
    
    var infoTextField: UITextField!
    var infoLabel: UILabel!
    var infoButton: UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        let infoTextFieldX = 20
        let infoTextFieldY = 10
        let infoTextFieldWidth = Screen.width - CGFloat(2 * infoTextFieldX)
        let infoTextFieldHeight = 40
        
        self.infoTextField = UITextField(frame: CGRect(x: infoTextFieldX, y: infoTextFieldY, width: Int(infoTextFieldWidth), height: infoTextFieldHeight))
        self.infoTextField.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.infoTextField.textColor = Color.grayText
        self.infoTextField.tintColor = Color.darkBlue
        self.infoTextField.placeholder = "Info Placeholder"
        self.infoTextField.returnKeyType = .next;
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: infoTextFieldHeight))
        
        self.infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(leftView.frame.width - 10), height: infoTextFieldHeight))
        self.infoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        self.infoLabel.textColor = Color.grayText
        self.infoLabel.numberOfLines = 2
        self.infoLabel.text = "Hourly"
        
        leftView.addSubview(self.infoLabel)
        
        self.infoButton = UIButton(type: .system)
        self.infoButton.frame = CGRect(x: infoTextFieldX + 120, y: infoTextFieldY, width: Int(infoTextFieldWidth - 120), height: infoTextFieldHeight)
        self.infoButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        self.infoButton.setTitleColor(Color.blue, for: .normal)
        self.infoButton.contentHorizontalAlignment = .left
        self.infoButton.setTitle("Please Select", for: .normal)
        self.infoButton.isHidden = true
        
        self.infoTextField.leftView = leftView
        self.infoTextField.leftViewMode = .always
        
        self.contentView.addSubview(self.infoTextField)
        self.contentView.addSubview(self.infoButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
