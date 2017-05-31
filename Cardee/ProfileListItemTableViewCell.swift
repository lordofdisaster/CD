//
//  ProfileListItemTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class ProfileListItemTableViewCell: UITableViewCell {
    
    var itemImageView: UIImageView!
    var itemNameLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Item image view
        
        let itemImageViewSize = 16
        let itemImageViewX = 28
        let itemImageViewY = 60/2 - itemImageViewSize/2
        
        self.itemImageView = UIImageView(frame: CGRect(x: itemImageViewX, y: itemImageViewY, width: itemImageViewSize, height: itemImageViewSize))
        self.itemImageView.contentMode = .scaleAspectFit
        
        // Item name label
        
        let itemNameLabelLeftOffset = 16
        let itemNameLabelX = itemImageViewX + itemImageViewSize + itemNameLabelLeftOffset
        let itemNameLabelWidth = Screen.width - CGFloat(itemNameLabelX) - 20
        let itemNameLabelHeight = 20
        let itemNameLabelY = 60/2 - itemNameLabelHeight/2
        
        self.itemNameLabel = UILabel(frame: CGRect(x: itemNameLabelX, y: itemNameLabelY, width: Int(itemNameLabelWidth), height: itemNameLabelHeight))
        self.itemNameLabel.text = "Account"
        self.itemNameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        
        self.contentView.addSubview(self.itemImageView)
        self.contentView.addSubview(self.itemNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
