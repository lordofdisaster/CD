//
//  CarLocationView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarLocationView: UIView {
    
    var infoLabel: UILabel!
    var addressLabel: UILabel!
    var addressTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Self settings
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 3
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.24).cgColor
        self.layer.shadowOpacity = 0.5
        
        // Info label
        
        let infoLabelX = 23
        let infoLabelY = 13
        let infoLabelWidth = frame.width - CGFloat(2 * infoLabelX)
        let infoLabelHeight = 15
        
        self.infoLabel = UILabel(frame: CGRect(x: infoLabelX, y: infoLabelY, width: Int(infoLabelWidth), height: infoLabelHeight))
        self.infoLabel.font = UIFont.systemFont(ofSize: 12)
        self.infoLabel.textColor = Color.lightGrayText
        self.infoLabel.text = "Where is your car usually parked?"
        
        // Address label
        
        let addressLabelTopOffset = 4
        let addressLabelX = 23
        let addressLabelY = infoLabelY + infoLabelHeight + addressLabelTopOffset
        let addressLabelWidth = frame.width - CGFloat(2 * infoLabelX)
        let addressLabelHeight = 20
        
        self.addressLabel = UILabel(frame: CGRect(x: addressLabelX, y: addressLabelY, width: Int(addressLabelWidth), height: addressLabelHeight))
        self.addressLabel.font = UIFont.systemFont(ofSize: 16)
        self.addressLabel.textColor = Color.grayText
        self.addressLabel.text = "Loading..."
        
        self.addSubview(self.infoLabel)
        self.addSubview(self.addressLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
