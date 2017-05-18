//
//  OwnerDescriptionTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/28/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class OwnerDescriptionTableViewCell: UITableViewCell {
    
    var locationLabel: UILabel!
    var descriptionLabel: UILabel!
    var editButton: UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // Edit Button
        
        let editButtonSideOffset = 26
        let editButtonWidth = 40
        let editButtonX = Screen.width - CGFloat(editButtonSideOffset) - CGFloat(editButtonWidth)
        let editButtonY = 26
        let editButtonHeight = 20
        
        self.editButton = UIButton(type: .system)
        self.editButton.frame = CGRect(x: Int(editButtonX), y: editButtonY, width: editButtonWidth, height: editButtonHeight)
        self.editButton.setTitle("Edit", for: .normal)
        self.editButton.setTitleColor(Color.blue, for: .normal)
        self.editButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        // Location label
        
        let locationLabelX = 26
        let locationLabelY = 26
        let locationLabelWidth = editButtonX - CGFloat(2 * locationLabelX)
        let locationLabelHeight = 20
        
        self.locationLabel = UILabel(frame: CGRect(x: locationLabelX, y: locationLabelY, width: Int(locationLabelWidth), height: locationLabelHeight))
        self.locationLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        self.locationLabel.textColor = Color.grayText
        self.locationLabel.text = "Singapore, Hougang"
        
        // Description label
        
        let desctiptionLabelTopOffset = 16
        let desctiptionLabelX = 26
        let desctiptionLabelY = locationLabelY + locationLabelHeight + desctiptionLabelTopOffset
        let desctiptionLabelWidth = Screen.width - CGFloat(2 * desctiptionLabelX)
        let desctiptionLabelHeight = 10
        
        self.descriptionLabel = UILabel(frame: CGRect(x: desctiptionLabelX, y: desctiptionLabelY, width: Int(desctiptionLabelWidth), height: desctiptionLabelHeight))
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.textColor = Color.grayText
        self.descriptionLabel.text = "Hi Guys, I'm a cool owner. Be nice to my car and I'll be nice to you! :)"
        self.descriptionLabel.sizeToFit()
        
        // Separator View
        
        let separatorViewTopOffset = 26
        let separatorViewY = CGFloat(separatorViewTopOffset) + CGFloat(desctiptionLabelY) + self.descriptionLabel.frame.height
        
        let separatorView = UIView(frame: CGRect(x: 0, y: separatorViewY, width: Screen.width, height: 1))
        separatorView.backgroundColor = Color.lightGray
        
        self.contentView.addSubview(self.locationLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.editButton)
        self.contentView.addSubview(separatorView)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
