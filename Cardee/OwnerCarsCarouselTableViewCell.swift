//
//  OwnerCarsCarouselTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/28/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class OwnerCarsCarouselTableViewCell: UITableViewCell {

    var carHeaderLabel: UILabel!
    var carsArray = [CarCarouselView]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // Review header
        
        let reviewHederLabelX = 26
        let reviewHederLabelY = 18
        let reviewHederLabelWidth = Screen.width - CGFloat(2 * reviewHederLabelX)
        let reviewHederLabelHeight = 22
        
        self.carHeaderLabel = UILabel(frame: CGRect(x: reviewHederLabelX, y: reviewHederLabelY, width: Int(reviewHederLabelWidth), height: reviewHederLabelHeight))
        self.carHeaderLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightThin)
        self.carHeaderLabel.textColor = Color.grayText
        self.carHeaderLabel.text = "2 Cars"
        
        // Cars Carousel
        
        let count = 10
        
        let scrollViewSideOffset = 20
        let scrollViewX = 10
        let scrollViewY = 50
        let scrollViewWidth = Screen.width - CGFloat(scrollViewSideOffset)
        let scrollViewHeight = 100
        
        let scrollView = UIScrollView(frame: CGRect(x: scrollViewX, y: scrollViewY, width: Int(scrollViewWidth), height: scrollViewHeight))
        scrollView.alwaysBounceHorizontal = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentSize = CGSize(width: 130 * count + 5 * (count + 1), height: 100)
        
        for i in 0..<count {
            let view = CarCarouselView(frame: CGRect(x: 5 + i * 5 + i * 130, y: 5, width: 130, height: 90))
            view.carImageView.image = UIImage(named: "Mazda.jpg")
            self.carsArray.append(view)
            scrollView.addSubview(view)
        }
    
        // Separator View

        let separatorViewY = 169

        let separatorView = UIView(frame: CGRect(x: 0, y: separatorViewY, width: Int(Screen.width), height: 1))
        separatorView.backgroundColor = Color.lightGray
        
        self.contentView.addSubview(self.carHeaderLabel)
        self.contentView.addSubview(separatorView)
        self.contentView.addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
