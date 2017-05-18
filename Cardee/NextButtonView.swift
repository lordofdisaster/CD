//
//  NextButtonView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class NextButtonView: UIView {
    
    var backgroundView: UIView!
    var nextLabel: UILabel!
    var nextImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Color.green
        self.layer.cornerRadius = 23
        self.clipsToBounds = true
        
        // Next label
        
        let nextLabelHeight = 20
        let nextLabelWidth = 40
        let nextLabelX = frame.width/2 - CGFloat(nextLabelWidth/2) - 5
        let nextLabelY = frame.height/2 - CGFloat(nextLabelHeight/2)
        
        self.nextLabel = UILabel(frame: CGRect(x: nextLabelX, y: nextLabelY, width: CGFloat(nextLabelWidth), height: CGFloat(nextLabelHeight)))
        self.nextLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.nextLabel.textColor = UIColor.white
        self.nextLabel.text = "Next"
        
        // Next image
        
        let nextImageViewHeight = 12
        let nextImageViewWidth = 6
        let nextImageViewX = frame.width/2 - CGFloat(nextImageViewWidth/2) + 20
        let nextImageViewY = frame.height/2 - CGFloat(nextImageViewHeight/2)
        
        self.nextImageView = UIImageView(frame: CGRect(x: nextImageViewX, y: nextImageViewY, width: CGFloat(nextImageViewWidth), height: CGFloat(nextImageViewHeight)))
        self.nextImageView.backgroundColor = UIColor.white
        
        self.addSubview(self.nextLabel)
        self.addSubview(self.nextImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
