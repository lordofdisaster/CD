//
//  CarCarouselView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/28/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarCarouselView: UIView {
    
    var overButton: UIButton!
    var carImageView: UIImageView!
    var carNameLabel: UILabel!
    var ratingLabel: UILabel!
    var ratingImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Over button
        
        self.overButton = UIButton(type: .system)
        self.overButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    
        // Car image view
        
        self.carImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.carImageView.backgroundColor = UIColor.gray
        self.carImageView.contentMode = .scaleAspectFill
        self.carImageView.clipsToBounds = true
        
        // Car name label
        
        let carNameBottomOffset = 8
        let carNameLabelX = 10
        let carNameLabelheight = 15
        let carNameLabelY = frame.height - CGFloat(carNameLabelheight) - CGFloat(carNameBottomOffset)
        let carNameLabelWidth = 50
        
        self.carNameLabel = UILabel(frame: CGRect(x: carNameLabelX, y: Int(carNameLabelY), width: carNameLabelWidth, height: carNameLabelheight))
        self.carNameLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold)
        self.carNameLabel.textColor = UIColor.white
        self.carNameLabel.text = "Mazda 3"
        self.carNameLabel.textAlignment = .right
        
        // Rating imageview
        
        let ratingImageViewX = frame.width - 17
        let ratingImageViewY = carNameLabelY + 4
        let ratingImageViewSize = 10
        
        self.ratingImageView = UIImageView(frame: CGRect(x: Int(ratingImageViewX), y: Int(ratingImageViewY), width: ratingImageViewSize, height: ratingImageViewSize))
        self.ratingImageView.backgroundColor = UIColor.yellow
        
        // Rating label
        
        let ratingLabelSideOffset = 7
        let ratingLabelWidth = 25
        let ratingLabelX = ratingImageViewX - CGFloat(ratingLabelSideOffset) - CGFloat(ratingLabelWidth)
        let ratingLabelY = carNameLabelY
        let ratingLabelHeight = 17
        
        self.ratingLabel = UILabel(frame: CGRect(x: Int(ratingLabelX), y: Int(ratingLabelY), width: ratingLabelWidth, height: ratingLabelHeight))
        self.ratingLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightSemibold)
        self.ratingLabel.textColor = UIColor.white
        self.ratingLabel.text = "4.2"

        self.addSubview(self.carImageView)
        self.carImageView.addSubview(self.carNameLabel)
        self.carImageView.addSubview(self.ratingLabel)
        self.carImageView.addSubview(self.ratingImageView)
        self.addSubview(self.overButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
