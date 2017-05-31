//
//  RenterProfileHeaderTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/19/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class RenterProfileHeaderTableViewCell: UITableViewCell {

    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var starImageView: UIImageView!
    var ratingLabel: UILabel!
    var tripsImageView: UIImageView!
    var tripsLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Avatar image view
        
        let avatarImageViewX = 26
        let avatarImageViewY = 20
        let avatarImageViewSize = 80

        self.avatarImageView = UIImageView(frame: CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewSize, height: avatarImageViewSize))
        self.avatarImageView.layer.cornerRadius = CGFloat(avatarImageViewSize/2)
        self.avatarImageView.backgroundColor = UIColor.gray
        self.avatarImageView.contentMode = .scaleAspectFill
        
        // Name label
        
        let nameLabelTopOffset = 12
        let nameLabelLeftOffset = 26
        let nameLabelX = avatarImageViewX + avatarImageViewSize + nameLabelLeftOffset
        let nameLabelY = nameLabelTopOffset + avatarImageViewY
        let nameLabelWidth = Screen.width/2
        let nameLabelHeight = 20
        
        self.nameLabel = UILabel(frame: CGRect(x: nameLabelX, y: nameLabelY, width: Int(nameLabelWidth), height: nameLabelHeight))
        self.nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.nameLabel.textColor = Color.grayText
        self.nameLabel.text = "Andy Lee"
        
        // Star image view
        
        let starImageTopOffset = 18
        let starImageViewX = nameLabelX
        let starImageViewY = nameLabelY + nameLabelHeight + starImageTopOffset
        let starImageViewSize = 16
        
        self.starImageView = UIImageView(frame: CGRect(x: starImageViewX, y: starImageViewY, width: starImageViewSize, height: starImageViewSize))
        self.starImageView.contentMode = .scaleAspectFit
        self.starImageView.image = #imageLiteral(resourceName: "star")
        
        // Rating label
        
        let ratingLabelLeftOffset = 10
        let ratingLabelX = starImageViewX + starImageViewSize + ratingLabelLeftOffset
        let ratingLabelY = starImageViewY
        let ratingLabelWidth = 25
        let ratingLabelHeight = 16
        
        self.ratingLabel = UILabel(frame: CGRect(x: ratingLabelX, y: ratingLabelY, width: ratingLabelWidth, height: ratingLabelHeight))
        self.ratingLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.ratingLabel.textColor = Color.grayText
        self.ratingLabel.text = "4.5"
        
        // Trips image view
        
        let tripsImageViewLeftOffset = 26
        let tripsImageX = ratingLabelX + ratingLabelWidth + tripsImageViewLeftOffset
        let tripsImageY = starImageViewY
        let tripsImageWidth = 30
        let tripsImageHeight = 16
        
        self.tripsImageView = UIImageView(frame: CGRect(x: tripsImageX, y: tripsImageY, width: tripsImageWidth, height: tripsImageHeight))
        self.tripsImageView.contentMode = .scaleAspectFit
        self.tripsImageView.image = #imageLiteral(resourceName: "trips")
        
        // Trips label
        
        let tripsLabelLeftOffset = 10
        let tripsLabelX = tripsImageX + tripsImageWidth + tripsLabelLeftOffset
        let tripsLabelY = tripsImageY
        let tripsLabelWidth = 100
        let tripsLabelHeight = 16
        
        self.tripsLabel = UILabel(frame: CGRect(x: tripsLabelX, y: tripsLabelY, width: tripsLabelWidth, height: tripsLabelHeight))
        self.tripsLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.tripsLabel.textColor = Color.grayText
        self.tripsLabel.text = "10 trips"
        
        // Separator view
        
        // Separator view
        
        let separatorViewTopOffset = 20
        let separatorViewY = avatarImageViewY + avatarImageViewSize + separatorViewTopOffset
        let separatorViewHeight = 13
        
        let separatorView = UIView(frame: CGRect(x: 0, y: separatorViewY, width: Int(Screen.width), height: separatorViewHeight))
        separatorView.backgroundColor = Color.lightGray
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.starImageView)
        self.contentView.addSubview(self.ratingLabel)
        self.contentView.addSubview(self.tripsImageView)
        self.contentView.addSubview(self.tripsLabel)
        self.contentView.addSubview(separatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
