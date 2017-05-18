//
//  InsuranceInfoTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class InsuranceInfoTableViewCell: UITableViewCell {
    
    var infoLabel: UILabel!
    var infoSwitch: UISwitch!
    var infoButton: UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Info label
        
        let infoLabelX = 20
        let infoLabelY = 10
        let infoLabelWidth = Screen.width - Screen.width/3 - CGFloat(2 * infoLabelX)
        let infoLabelHeight = 60
        
        self.infoLabel = UILabel(frame: CGRect(x: infoLabelX, y: infoLabelY, width: Int(infoLabelWidth), height: infoLabelHeight))
        self.infoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.infoLabel.textColor = Color.grayText
        self.infoLabel.numberOfLines = 3
        
        // Info switch
        
        let cellHeight = 80
        let infoSwitchSideOffset = 20
        let infoSwitchX = Screen.width - CGFloat(infoSwitchSideOffset) - CGFloat(System.switchNativeSize.width)
        let infoSwitchY = cellHeight/2 - System.switchNativeSize.height/2
        let infoSwitchWidth = 0
        let infoSwitchHeight = 0
        
        self.infoSwitch = UISwitch(frame: CGRect(x: Int(infoSwitchX), y: infoSwitchY, width: infoSwitchWidth, height: infoSwitchHeight))
        self.infoSwitch.onTintColor = Color.blue
        
        // Info button
        
        let infoButtonWidth = Screen.width/3
        let infoButtonHeight = System.switchNativeSize.height
        let infoButtonX = Screen.width - CGFloat(infoSwitchSideOffset) - CGFloat(infoButtonWidth)
        let infoButtonY = cellHeight/2 - infoButtonHeight/2
        
        self.infoButton = UIButton(type: .system)
        self.infoButton.frame = CGRect(x: Int(infoButtonX), y: infoButtonY, width: Int(infoButtonWidth), height: infoButtonHeight)
        self.infoButton.setTitle("Choose", for: .normal)
        self.infoButton.setTitleColor(Color.blue, for: .normal)
        self.infoButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.infoButton.contentHorizontalAlignment = .right
        
        self.contentView.addSubview(self.infoLabel)
        self.contentView.addSubview(self.infoSwitch)
        self.contentView.addSubview(self.infoButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
