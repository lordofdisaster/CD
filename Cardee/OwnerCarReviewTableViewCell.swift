//
//  OwnerCarReviewTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/28/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class OwnerCarReviewTableViewCell: UITableViewCell {
    
    var reviewHederLabel: UILabel!
    var authorAvatarImageView: UIImageView!
    var authorName: UILabel!
    var reviewDate: UILabel!
    var carNameLabel: UILabel!
    var ratingLabel: UILabel!
    var ratingImageView: UIImageView!
    var reviewTextLabel: UILabel!
    var allReviewsButton: UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // Review header
        
        let reviewHederLabelX = 26
        let reviewHederLabelY = 18
        let reviewHederLabelWidth = Screen.width - CGFloat(2 * reviewHederLabelX)
        let reviewHederLabelHeight = 22
        
        self.reviewHederLabel = UILabel(frame: CGRect(x: reviewHederLabelX, y: reviewHederLabelY, width: Int(reviewHederLabelWidth), height: reviewHederLabelHeight))
        self.reviewHederLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin)
        self.reviewHederLabel.textColor = Color.grayText
        self.reviewHederLabel.text = "10 Car Reviews"
        
        // Author avatart image
        
        let authorAvatarImageViewTopOffset = 12
        let authorAvatarImageViewX = 26
        let authorAvatarImageViewY = authorAvatarImageViewTopOffset + reviewHederLabelY + reviewHederLabelHeight
        let authorAvatarImageViewSize = 45
        
        self.authorAvatarImageView = UIImageView(frame: CGRect(x: authorAvatarImageViewX, y: authorAvatarImageViewY, width: authorAvatarImageViewSize, height: authorAvatarImageViewSize))
        self.authorAvatarImageView.backgroundColor = Color.blue
        self.authorAvatarImageView.layer.cornerRadius = CGFloat(authorAvatarImageViewSize/2)
        self.authorAvatarImageView.clipsToBounds = true
        
        // Author Name
        
        let authorNameSideOffset = 20
        let authorNameX = authorNameSideOffset + authorAvatarImageViewX + authorAvatarImageViewSize
        let authorNameY = authorAvatarImageViewY
        let authorNameWidth = Screen.width - CGFloat(authorNameX)
        let authorNameHeight = 25
        
        self.authorName = UILabel(frame: CGRect(x: authorNameX, y: authorNameY, width: Int(authorNameWidth), height: authorNameHeight))
        self.authorName.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        self.authorName.textColor = Color.grayText
        self.authorName.text = "Rajeev"
        
        // Date label
        
        let reviewDateSideOffset = 20
        let reviewDateX = reviewDateSideOffset + authorAvatarImageViewX + authorAvatarImageViewSize
        let reviewDateY = authorNameY + authorNameHeight
        let reviewDateWidth = 100
        let reviewDateHeight = 20
        
        self.reviewDate = UILabel(frame: CGRect(x: reviewDateX, y: reviewDateY, width: reviewDateWidth, height: reviewDateHeight))
        self.reviewDate.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        self.reviewDate.textColor = Color.lightGrayText
        self.reviewDate.text = "Sep 15, 2016"
        
        // Rating imageview
        
        let ratingImageViewX = Screen.width - 30
        let ratingImageViewY = reviewDateY
        let ratingImageViewSize = 17
        
        self.ratingImageView = UIImageView(frame: CGRect(x: Int(ratingImageViewX), y: ratingImageViewY, width: ratingImageViewSize, height: ratingImageViewSize))
        self.ratingImageView.contentMode = .scaleAspectFit
        self.ratingImageView.image = #imageLiteral(resourceName: "star")
        
        // Rating label
        
        let ratingLabelSideOffset = 7
        let ratingLabelWidth = 10
        let ratingLabelX = ratingImageViewX - CGFloat(ratingLabelSideOffset) - CGFloat(ratingLabelWidth)
        let ratingLabelY = reviewDateY
        let ratingLabelHeight = 17
        
        self.ratingLabel = UILabel(frame: CGRect(x: Int(ratingLabelX), y: ratingLabelY, width: ratingLabelWidth, height: ratingLabelHeight))
        self.ratingLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        self.ratingLabel.textColor = Color.blue
        self.ratingLabel.text = "5"
        
        // Car name
        
        let carNameLabelSideOffset = 10
        let carNameLabelX = reviewDateX + reviewDateWidth + carNameLabelSideOffset
        let carNameLabelY = reviewDateY
        let carNameLabelWidth = Screen.width - CGFloat(carNameLabelX) - (Screen.width - ratingLabelX) - CGFloat(carNameLabelSideOffset)
        let carNameLabelHeight = 17
        
        self.carNameLabel = UILabel(frame: CGRect(x: carNameLabelX, y: carNameLabelY, width: Int(carNameLabelWidth), height: carNameLabelHeight))
        self.carNameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        self.carNameLabel.textColor = Color.blue
        self.carNameLabel.text = "Mazda 3"
        self.carNameLabel.textAlignment = .right
        self.carNameLabel.adjustsFontSizeToFitWidth = true
        
        // Review text
        
        let reviewTextLabelTopOffset = 16
        let reviewTextLabelX = 26
        let reviewTextLabelY = authorAvatarImageViewY + authorAvatarImageViewSize + reviewTextLabelTopOffset
        let reviewTextLabelWidth = Screen.width - CGFloat(2 * reviewTextLabelX)
        let reviewTextLabelHeight = 100
        
        self.reviewTextLabel = UILabel(frame: CGRect(x: reviewTextLabelX, y: reviewTextLabelY, width: Int(reviewTextLabelWidth), height: reviewTextLabelHeight))
        self.reviewTextLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        self.reviewTextLabel.textColor = Color.grayText
        self.reviewTextLabel.numberOfLines = 6
        self.reviewTextLabel.text = "Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. Great experience. "
        
        // All reviews button
        
        let allReviewButtonTopOffset = 16
        let allReviewsButtonX = 26
        let allReviewsButtonY = CGFloat(reviewTextLabelY) + self.reviewTextLabel.frame.height + CGFloat(allReviewButtonTopOffset)
        let allReviewsButtonWidth = Screen.width - CGFloat(2 * allReviewButtonTopOffset)
        let allReviewsButtonheight = 20
        
        self.allReviewsButton = UIButton(type: .system)
        self.allReviewsButton.frame = CGRect(x: CGFloat(allReviewsButtonX), y: allReviewsButtonY, width: CGFloat(allReviewsButtonWidth), height: CGFloat(allReviewsButtonheight))
        self.allReviewsButton.setTitle("See all reviews", for: .normal)
        self.allReviewsButton.setTitleColor(Color.blue, for: .normal)
        self.allReviewsButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin)
        self.allReviewsButton.contentHorizontalAlignment = .left
        // Adding subviews
        
        self.contentView.addSubview(self.reviewHederLabel)
        self.contentView.addSubview(self.authorAvatarImageView)
        self.contentView.addSubview(self.authorName)
        self.contentView.addSubview(self.reviewDate)
        self.contentView.addSubview(self.carNameLabel)
        self.contentView.addSubview(self.ratingLabel)
        self.contentView.addSubview(self.ratingImageView)
        self.contentView.addSubview(self.reviewTextLabel)
        self.contentView.addSubview(self.allReviewsButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
