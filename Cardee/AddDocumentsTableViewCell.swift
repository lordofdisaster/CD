//
//  AddDocumentsTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class AddDocumentsTableViewCell: UITableViewCell {
    
    var headerLabel: UILabel!
    var photoImageView: UIImageView!
    var addPhotoButton: UIButton!
    var countBackgroundView: UIView!
    var countLabel: UILabel!
    var type: DocumentType!

    init(reuseIdentifier: String?, type: DocumentType) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Header label
        
        let headerLabelX = 20
        let headerLabelY = 13
        let headerLabelWidth = Screen.width - CGFloat(2 * headerLabelX)
        let headerLabelHeight = 40
        
        self.headerLabel = UILabel(frame: CGRect(x: headerLabelX, y: headerLabelY, width: Int(headerLabelWidth), height: headerLabelHeight))
        self.headerLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.headerLabel.textColor = Color.grayText
        self.headerLabel.text = "Upload your vehicle log card"
        self.headerLabel.numberOfLines = 2
        
        // Photo image view
        
        let photoImageSideOffset = 25
        let photoImageTopOffset = 19
        let photoImageViewX = 20
        let photoImageViewY = headerLabelY + headerLabelHeight + photoImageTopOffset
        let photoImageViewWidth = 116
        var photoImageViewHeight = 152
        if type == .personal {
            photoImageViewHeight = 75
        }
        
        self.photoImageView = UIImageView(frame: CGRect(x: photoImageViewX, y: photoImageViewY, width: Int(photoImageViewWidth), height: photoImageViewHeight))
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.clipsToBounds = true
        self.photoImageView.backgroundColor = Color.backgroundBlue
        
        // Add photo button
        
        let addPhotoButtonX = photoImageViewX + Int(photoImageViewWidth) + photoImageSideOffset
        let addPhotoButtonY = photoImageViewY
        let addPhotoButtonWidth = photoImageViewWidth
        let addPhotoButtonHeight = photoImageViewHeight
        
        self.addPhotoButton = UIButton(type: .system)
        self.addPhotoButton.frame = CGRect(x: addPhotoButtonX, y: addPhotoButtonY, width: Int(addPhotoButtonWidth), height: addPhotoButtonHeight)
        self.addPhotoButton.setTitle("Upload", for: .normal)
        self.addPhotoButton.backgroundColor = Color.backgroundBlue
        self.addPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.addPhotoButton.setTitleColor(Color.blue, for: .normal)
        
        // Count background view
        
        let countBackgroundViewX = 0
        let countBackgroundViewHeight = 26
        let countBackgroundViewY = photoImageViewHeight - countBackgroundViewHeight
        let countBackgroundViewWidth = photoImageViewWidth
        
        self.countBackgroundView = UIView(frame: CGRect(x: countBackgroundViewX, y: countBackgroundViewY, width: Int(countBackgroundViewWidth), height: countBackgroundViewHeight))
        self.countBackgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        // Count label
        
        self.countLabel = UILabel(frame: self.countBackgroundView.bounds)
        self.countLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular)
        self.countLabel.textColor = UIColor.white
        self.countLabel.text = "0 images"
        self.countLabel.textAlignment = .center
        
        // Adding subviews
        
        self.countBackgroundView.addSubview(self.countLabel)
        self.photoImageView.addSubview(self.countBackgroundView)
        
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.photoImageView)
        self.contentView.addSubview(self.addPhotoButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
