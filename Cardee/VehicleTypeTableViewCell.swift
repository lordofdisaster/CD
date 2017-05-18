//
//  VehicleTypeTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class VehicleTypeTableViewCell: UITableViewCell {

    var layerButton: UIButton!
    var borderView: UIView!
    var typeNameLabel: UILabel!
    var typeImageView: UIImageView!
    var footerLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Layer button
        
        let layerButtonX = 15
        let layerButtonY = 15
        let layerButtonWidth = Screen.width - CGFloat(layerButtonX * 2)
        let layerButtonHeight = 55
        
        self.layerButton = UIButton(type: .system)
        self.layerButton.frame = CGRect(x: layerButtonX, y: layerButtonY, width: Int(layerButtonWidth), height: layerButtonHeight)
        
        // Border view
        
        let borderViewX = 15
        let borderViewY = 15
        let borderViewWidth = Screen.width - CGFloat(borderViewX * 2)
        let borderViewHeight = 55
        
        self.borderView = UIView(frame: CGRect(x: borderViewX, y: borderViewY, width: Int(borderViewWidth), height: borderViewHeight))
        self.borderView.layer.borderWidth = 1
        self.borderView.layer.borderColor = Color.darkBlue.cgColor
        self.borderView.layer.cornerRadius = 3
        
        // Type name label
        
        let typeNameLabelX = 25
        let typeNameLabelY = 0
        let typeNameLabelWidth = Screen.width - Screen.width/3
        let typeNameLabelHeight = borderViewHeight
        
        self.typeNameLabel = UILabel(frame: CGRect(x: typeNameLabelX, y: typeNameLabelY, width: Int(typeNameLabelWidth), height: typeNameLabelHeight))
        self.typeNameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.typeNameLabel.textColor = Color.darkBlue
        self.typeNameLabel.text = "Commercial Vehicle"
        
        // Type image view
        
        let typeImageViewWidth = 30
        let typeImageViewHeight = 30
        let typeImageViewX = CGFloat(borderViewX) + borderViewWidth - 36 - CGFloat(typeImageViewWidth)
        
        let typeImageViewY = (borderViewHeight - typeImageViewWidth)/2
        
        self.typeImageView = UIImageView(frame: CGRect(x: Int(typeImageViewX), y: typeImageViewY, width: typeImageViewWidth, height: typeImageViewHeight))
        self.typeImageView.backgroundColor = Color.blue
        
        // Footer label
        
        let footerLabelTopOffset = 8
        let footerLabelX = 28
        let footerLabelY = borderViewY + borderViewHeight + footerLabelTopOffset
        let footerLabelWidth = Screen.width - CGFloat(2 * footerLabelX)
        let footerLabelHeight = 30
        
        self.footerLabel = UILabel(frame: CGRect(x: footerLabelX, y: footerLabelY, width: Int(footerLabelWidth), height: footerLabelHeight))
        self.footerLabel.font = UIFont.systemFont(ofSize: 12)
        self.footerLabel.textColor = Color.lightGrayText
        self.footerLabel.text = "Private-hire cars registered for Grab or Uber Use"
        self.footerLabel.numberOfLines = 2
        self.footerLabel.sizeToFit()

        self.contentView.addSubview(self.borderView)
        self.borderView.addSubview(self.typeNameLabel)
        self.borderView.addSubview(self.typeImageView)
        self.contentView.addSubview(self.footerLabel)
        self.contentView.addSubview(self.layerButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
