//
//  HideExactLocationView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class HideExactLocationView: UIView {
    
    var hideExactLocationLabel: UILabel!
    var hideExactLocationSwitch: UISwitch!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Self settings
        
        self.backgroundColor = UIColor.white
        
        // Hide exact location label
        
        let hideExactLocationLabelHeight = 20
        let hideExactLocationLabelX = 26
        let hideExactLocationLabelY = frame.height/2 - CGFloat(hideExactLocationLabelHeight/2)
        let hideExactLocationLabelWidth = Screen.width/2
        
        self.hideExactLocationLabel = UILabel(frame: CGRect(x: hideExactLocationLabelX, y: Int(hideExactLocationLabelY), width: Int(hideExactLocationLabelWidth), height: hideExactLocationLabelHeight))
        self.hideExactLocationLabel.font = UIFont.systemFont(ofSize: 16)
        self.hideExactLocationLabel.textColor = Color.grayText
        self.hideExactLocationLabel.text = "Hide Exact Location"
        
        // Hide exact location switch
        
        let hideExactLocationSideOffset = 26
        let hideExactLocationSwitchX = Screen.width - CGFloat(System.switchNativeSize.width) - CGFloat(hideExactLocationSideOffset)
        let hideExactLocationSwitchY = frame.height/2 - CGFloat(System.switchNativeSize.height/2)
        let hideExactLocationSwitchWidth = 0
        let hideExactLocationSwitchHeight = 0
        
        self.hideExactLocationSwitch = UISwitch(frame: CGRect(x: hideExactLocationSwitchX, y: hideExactLocationSwitchY, width: CGFloat(hideExactLocationSwitchWidth), height: CGFloat(hideExactLocationSwitchHeight)))
        self.hideExactLocationSwitch.onTintColor = Color.blue
        
        self.addSubview(self.hideExactLocationLabel)
        self.addSubview(self.hideExactLocationSwitch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
