//
//  OwnerInfoTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/27/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class OwnerInfoTableViewCell: UITableViewCell {
    
    var avatarImageView: UIImageView!
    var usernameLabel: UILabel!
    var ratingLabel: UILabel!
    var changeButton: UIButton!
    var featuresViewSection = [OwnerFeaturesView]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // Avatar imageview
        
        let avatarImageViewX = 33
        let avatarImageViewY = 26
        let avatarImageViewSize = 60
        
        self.avatarImageView = UIImageView(frame: CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewSize, height: avatarImageViewSize))
        self.avatarImageView.layer.cornerRadius = CGFloat(avatarImageViewSize/2)
        self.avatarImageView.backgroundColor = Color.lightGray
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.contentMode = .scaleAspectFill
        
        // Username label
        
        let usernameLabelSideOffset = 33
        let usernameLabelX = avatarImageViewX + avatarImageViewSize + usernameLabelSideOffset
        let usernameLabelY = 26
        let usernameLabelWidth = Screen.width - CGFloat(usernameLabelX) - CGFloat(usernameLabelSideOffset)
        let usernameLabelHeight = 21
        
        self.usernameLabel = UILabel(frame: CGRect(x: usernameLabelX, y: usernameLabelY, width: Int(usernameLabelWidth), height: usernameLabelHeight))
        self.usernameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightSemibold)
        self.usernameLabel.textColor = Color.grayText
        self.usernameLabel.text = "Andy Lee"
        
        // Star image
        
        let starImageViewX = avatarImageViewX + avatarImageViewSize + usernameLabelSideOffset
        let starImageViewY = 64
        let starImageViewSize = 17
        
        let starImageView = UIImageView(frame: CGRect(x: starImageViewX, y: starImageViewY, width: starImageViewSize, height: starImageViewSize))
        starImageView.contentMode = .scaleAspectFit
        starImageView.image = #imageLiteral(resourceName: "star")

        
        // Rating label
        
        let ratingLabelSideOffset = 10
        let ratingLabelX = starImageViewX + starImageViewSize + ratingLabelSideOffset
        let ratingLabelY = 64
        let ratingLabelWidth = 100
        let ratingLabelHeight = 20
        
        self.ratingLabel = UILabel(frame: CGRect(x: ratingLabelX, y: ratingLabelY, width: ratingLabelWidth, height: ratingLabelHeight))
        self.ratingLabel.font = UIFont.systemFont(ofSize: 14)
        self.ratingLabel.textColor = Color.grayText
        self.ratingLabel.text = "4.5"
        
        // Change button
        
        let changeButtonTopOffset = 5
        let changeButtonX = 33
        let changeButtonY = avatarImageViewY + avatarImageViewSize + changeButtonTopOffset
        let changeButtonWidth = 60
        let changeButtonHeight = 15
        
        self.changeButton = UIButton(type: .system)
        self.changeButton.frame = CGRect(x: changeButtonX, y: changeButtonY, width: changeButtonWidth, height: changeButtonHeight)
        self.changeButton.setTitle("Change", for: .normal)
        self.changeButton.setTitleColor(Color.blue, for: .normal)
        self.changeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        // Features view
        
        let featuresViewTopOffset = 10
        let featuresViewY = changeButtonY + changeButtonHeight + featuresViewTopOffset
        let featuresViewWidth = Screen.width
        let featuresViewHeight = 60
        
        for i in 0..<3 {
            var lastItem = true
            if i == 2 {
                lastItem = false
            }
            let featuresView = OwnerFeaturesView(frame: CGRect(x: CGFloat(i) * featuresViewWidth/3, y: CGFloat(featuresViewY), width: CGFloat(featuresViewWidth/3), height: CGFloat(featuresViewHeight)), isLastItem: lastItem)
            self.contentView.addSubview(featuresView)
            self.featuresViewSection.append(featuresView)
        }
        
        // Separator view
        
        let separatorViewTopOffset = 13
        let separatorViewY = featuresViewY + featuresViewHeight + separatorViewTopOffset
        let separatorViewHeight = 13
        
        let separatorView = UIView(frame: CGRect(x: 0, y: separatorViewY, width: Int(Screen.width), height: separatorViewHeight))
        separatorView.backgroundColor = Color.lightGray
        
    
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(starImageView)
        self.contentView.addSubview(self.ratingLabel)
        self.contentView.addSubview(self.changeButton)
        self.contentView.addSubview(separatorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
