//
//  ShadowView.swift
//  Cardee
//
//  Created by Leonid Nifantyev on 7/12/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        
    }
}
