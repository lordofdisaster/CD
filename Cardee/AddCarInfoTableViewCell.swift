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
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: infoTextFieldHeight))
        
        self.infoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(leftView.frame.width - 10), height: infoTextFieldHeight))
        self.infoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        self.infoLabel.textColor = Color.grayText
        self.infoLabel.numberOfLines = 2
        self.infoLabel.text = "Hourly"
        
        leftView.addSubview(infoLabel)
        
        self.infoTextField.leftView = leftView
        self.infoTextField.leftViewMode = .always
        
        self.contentView.addSubview(self.infoTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
