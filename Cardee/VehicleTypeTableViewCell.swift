//
//  VehicleTypeTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class VehicleTypeTableViewCell: UITableViewCell {

    var borderView: UIView!
    var typeNameLabel: UILabel!
    var typeImageView: UIImageView!
    var footerLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Border view
        
        let borderViewX = 15
        let borderViewY = 15
        let borderViewWidth = Screen.width - CGFloat(borderViewX * 2)
        let borderViewHeight = 55
        
        self.borderView = UIView(frame: CGRect(x: borderViewX, y: borderViewY, width: Int(borderViewWidth), height: borderViewHeight))
        self.borderView.layer.borderWidth = 0.5
        self.borderView.layer.borderColor = Color.darkGray.cgColor
        self.borderView.layer.cornerRadius = 3
        
        // Type name label
        
        let typeNameLabelX = 25
        let typeNameLabelY = 0
        let typeNameLabelWidth = Screen.width - Screen.width/3
        let typeNameLabelHeight = borderViewHeight
        
        self.typeNameLabel = UILabel(frame: CGRect(x: typeNameLabelX, y: typeNameLabelY, width: Int(typeNameLabelWidth), height: typeNameLabelHeight))
        self.typeNameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.typeNameLabel.textColor = Color.darkGray
        
        // Type image view
        
        let typeImageViewWidth = 35
        let typeImageViewHeight = 35
        let typeImageViewX = CGFloat(borderViewX) + borderViewWidth - 36 - CGFloat(typeImageViewWidth)
        
        let typeImageViewY = (borderViewHeight - typeImageViewWidth)/2
        
        self.typeImageView = UIImageView(frame: CGRect(x: Int(typeImageViewX), y: typeImageViewY, width: typeImageViewWidth, height: typeImageViewHeight))
        self.typeImageView.contentMode = .scaleAspectFit
        
        // Footer label
        
        let footerLabelTopOffset = 8
        let footerLabelX = 28
        let footerLabelY = borderViewY + borderViewHeight + footerLabelTopOffset
        let footerLabelWidth = Screen.width - CGFloat(2 * footerLabelX)
        let footerLabelHeight = 30
        
        self.footerLabel = UILabel(frame: CGRect(x: footerLabelX, y: footerLabelY, width: Int(footerLabelWidth), height: footerLabelHeight))
        self.footerLabel.font = UIFont.systemFont(ofSize: 12)
        self.footerLabel.textColor = Color.lightGrayText
        self.footerLabel.numberOfLines = 2

        self.contentView.addSubview(self.borderView)
        self.borderView.addSubview(self.typeNameLabel)
        self.borderView.addSubview(self.typeImageView)
        self.contentView.addSubview(self.footerLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.borderView.layer.borderColor = Color.darkBlue.cgColor
            self.typeImageView.tintColor = Color.darkBlue
            self.typeNameLabel.textColor = Color.darkBlue
        } else {
            self.borderView.layer.borderColor = Color.darkGray.cgColor
            self.typeImageView.tintColor = Color.lightGray
            self.typeNameLabel.textColor = Color.darkGray
        }
    }

}
