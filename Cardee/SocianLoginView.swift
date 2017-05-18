//
//  SocianLoginView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class SocianLoginView: UIView {

    var facebookButton: SocialButton!
    var googleButton: SocialButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Social button constants
        let sideOffset = 40
        let topOffset = 15
        let buttonWidth = Screen.width - CGFloat(2 * sideOffset)
        let buttonHeight = 50
        
        let facebookButtonY = 0
        let googleButtonY = facebookButtonY + buttonHeight + topOffset
        let facebookButtonX = sideOffset
        let googleButtonX = sideOffset
        
        // Facebook Button
        self.facebookButton = SocialButton(type: .system)
        self.facebookButton.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.3411764706, blue: 0.6156862745, alpha: 1)
        self.facebookButton.setTitle("Log in with Facebook", for: .normal)
        self.facebookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.facebookButton.frame = CGRect(x: Int(facebookButtonX), y: facebookButtonY, width: Int(buttonWidth), height: buttonHeight)
        
        // Google button
        self.googleButton = SocialButton(type: .system)
        self.googleButton.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.3176470588, blue: 0.1960784314, alpha: 1)
        self.googleButton.setTitle("Log in with Google+", for: .normal)
        self.googleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.googleButton.frame = CGRect(x: Int(googleButtonX), y: googleButtonY, width: Int(buttonWidth), height: buttonHeight)
        
        // Adding to superview
        self.addSubview(facebookButton)
        self.addSubview(googleButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
