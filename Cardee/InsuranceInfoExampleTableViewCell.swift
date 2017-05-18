//
//  InsuranceInfoExampleTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class InsuranceInfoExampleTableViewCell: UITableViewCell {
    
    var infoLabel: UILabel!
    var exampleView: UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Info label
        
        let infoLabelX = 20
        let infoLabelY = 10
        let infoLabelWidth = Screen.width - CGFloat(2 * infoLabelX)
        let infoLabelHeight = 40
        
        self.infoLabel = UILabel(frame: CGRect(x: infoLabelX, y: infoLabelY, width: Int(infoLabelWidth), height: infoLabelHeight))
        self.infoLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.infoLabel.textColor = Color.grayText
        self.infoLabel.numberOfLines = 2
        self.infoLabel.text = "What is the maximum amount payable by renter (excess) in case of accident?"
        
        // Example view
        
        let exampleViewTopOffset = 13
        let exampleViewX = 20
        let exampleViewY = exampleViewTopOffset + infoLabelY + infoLabelHeight
        let exampleViewWidth = Screen.width - CGFloat(2 * infoLabelX)
        let exampleViewHeight = 100
        
        self.exampleView = UIView(frame: CGRect(x: exampleViewX, y: exampleViewY, width: Int(exampleViewWidth), height: exampleViewHeight))
        self.exampleView.layer.borderColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1).cgColor
        self.exampleView.layer.borderWidth = 1
        self.exampleView.layer.cornerRadius = 3
        
        // Example label
        
        let exampleLabelX = 13
        let exampleLabelY = 10
        let exampleLabelWidth = Screen.width - CGFloat(2 * infoLabelX)
        let exampleLabelHeight = exampleViewHeight - 2 * exampleLabelY
        
        let exampleLabel = UILabel(frame: CGRect(x: exampleLabelX, y: exampleLabelY, width: Int(exampleLabelWidth - CGFloat(2 * exampleLabelX)), height: exampleLabelHeight))
        exampleLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        exampleLabel.textColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1)
        exampleLabel.numberOfLines = 4
        exampleLabel.text = "Example\nExcess - $1,000 (per section)]\nIf accident occurs in Malaysia - $2,000\nIf driver is below the age of 25 - $1,500"
        
        exampleView.addSubview(exampleLabel)
        self.contentView.addSubview(self.infoLabel)
        self.contentView.addSubview(self.exampleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
