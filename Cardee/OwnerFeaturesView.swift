//
//  OwnerFeaturesView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/27/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class OwnerFeaturesView: UIView {
    
    var keyLabel: UILabel!
    var valueLabel: UILabel!

    init(frame: CGRect, isLastItem: Bool, title: String, value: String) {
        super.init(frame: frame)
        
        // Key label
        
        let keyLabelX = 0
        let keyLabelY = 5
        let keyLabelWidth = frame.width
        let keyLabelHeight = 15
        
        self.keyLabel = UILabel(frame: CGRect(x: keyLabelX, y: keyLabelY, width: Int(keyLabelWidth), height: keyLabelHeight))
        self.keyLabel.textAlignment = .center
        self.keyLabel.font = UIFont.systemFont(ofSize: 11)
        self.keyLabel.textColor = Color.lightGrayText
        self.keyLabel.text = title
        
        // Value label
        
        let valueLabelTopOffset = 10
        let valueLabelX = 0
        let valueLabelY = valueLabelTopOffset + keyLabelY + keyLabelHeight
        let valueLabelWidth = frame.width
        let valueLabelHeight = 20
        
        self.valueLabel = UILabel(frame: CGRect(x: valueLabelX, y: valueLabelY, width: Int(valueLabelWidth), height: valueLabelHeight))
        self.valueLabel.textAlignment = .center
        self.valueLabel.font = UIFont.systemFont(ofSize: 16)
        self.valueLabel.textColor = Color.grayText
        self.valueLabel.text = value
        
        // Separator view
        
        let separatorView = UIView(frame: CGRect(x: frame.width - 1, y: 0, width: 0.5, height: frame.height))
        separatorView.backgroundColor = Color.lightGrayText
        
        isLastItem ? (separatorView.isHidden = false) : (separatorView.isHidden = true)
        
        self.addSubview(self.keyLabel)
        self.addSubview(self.valueLabel)
        self.addSubview(separatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
