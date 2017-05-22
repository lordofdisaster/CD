//
//  PaymentMethodTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/22/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {
    
    var cardImageView: UIImageView!
    var cardNumberLabel: UILabel!
    var isPrimaryLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.cardImageView = UIImageView(frame: CGRect(x: 12, y: 50/2 - 21/2, width: 33, height: 21))
        self.cardImageView.backgroundColor = UIColor.red
        
        
        self.cardNumberLabel = UILabel(frame: CGRect(x: 65, y: 50/2 - 20/2, width: 100, height: 20))
        self.cardNumberLabel.font = UIFont.systemFont(ofSize: 16)
        self.cardNumberLabel.textColor = Color.grayText
        self.cardNumberLabel.text = "•••• 1234"
        
        self.contentView.addSubview(self.cardImageView)
        self.contentView.addSubview(self.cardNumberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
