//
//  ButtonTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/22/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var button: UIButton!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.button = UIButton(frame: CGRect(x: 20, y: 50/2 - 20/2, width: self.contentView.frame.width - 40, height: 20))
        self.button.setTitle("Account Verified / Add Driver", for: .normal)
        self.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.button.setTitleColor(Color.blue, for: .normal)
        self.button.contentHorizontalAlignment = .left
        
        self.contentView.addSubview(self.button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
