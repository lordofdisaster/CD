//
//  SocialButton.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class SocialButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
