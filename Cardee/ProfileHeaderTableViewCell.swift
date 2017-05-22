//
//  ProfileHeaderTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {
    
    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var profileTypeLabel: UILabel!
    var forwardImageView: UIImageView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        
        // Avatar image view
        
        let avatarImageViewX = 30
        let avatarImageViewY = 60
        let avatarImageViewSize = 60
        
        self.avatarImageView = UIImageView(frame: CGRect(x: avatarImageViewX, y: avatarImageViewY, width: avatarImageViewSize, height: avatarImageViewSize))
        self.avatarImageView.layer.cornerRadius = CGFloat(avatarImageViewSize/2)
        self.avatarImageView.contentMode = .scaleAspectFill
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.backgroundColor = UIColor.gray
        
        // Name label
        
        let nameLabelLeftOffset = 30
        let nameLabelX = avatarImageViewX + avatarImageViewSize + nameLabelLeftOffset
        let nameLabelY = 67
        let nameLabelWidth = Screen.width/2
        let nameLabelHeight = 20
        
        self.nameLabel = UILabel(frame: CGRect(x: nameLabelX, y: nameLabelY, width: Int(nameLabelWidth), height: nameLabelHeight))
        self.nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.nameLabel.text = "Andy Lee"
        
        // Renter profile
        
        let profileTypeTopOffset = 7
        let profileTypeLabelX = nameLabelX
        let profileTypeLabelY = nameLabelY + nameLabelHeight + profileTypeTopOffset
        let profileTypeLabelWidth = Screen.width/2
        let profileTypeLabelHeight = 20
        
        self.profileTypeLabel = UILabel(frame: CGRect(x: profileTypeLabelX, y: profileTypeLabelY, width: Int(profileTypeLabelWidth), height: profileTypeLabelHeight))
        self.profileTypeLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        self.profileTypeLabel.textColor = Color.lightGrayText
        self.profileTypeLabel.text = "Renter Profile"
        
        // Forward image view
        
        let forwardImageViewRightOffset = 30
        let forwardImageViewWidth = 8
        let forwardImageViewX = Screen.width - CGFloat(forwardImageViewRightOffset) - CGFloat(forwardImageViewWidth)
        let forwardImageViewY = 80
        let forwardImageViewHeight = 16
        
        self.forwardImageView = UIImageView(frame: CGRect(x: Int(forwardImageViewX), y: forwardImageViewY, width: forwardImageViewWidth, height: forwardImageViewHeight))
        self.forwardImageView.backgroundColor = UIColor.gray
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.profileTypeLabel)
        self.contentView.addSubview(self.forwardImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
