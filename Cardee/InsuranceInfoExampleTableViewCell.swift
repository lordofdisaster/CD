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
    var exampleTextView: UITextView!

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
        
        let exampleTextViewTopOffset = 13
        let exampleTextViewX = 20
        let exampleTextViewY = exampleTextViewTopOffset + infoLabelY + infoLabelHeight
        let exampleTextViewWidth = Screen.width - CGFloat(2 * infoLabelX)
        let exampleTextViewHeight = 100
        
        self.exampleTextView = UITextView(frame: CGRect(x: exampleTextViewX, y: exampleTextViewY, width: Int(exampleTextViewWidth), height: exampleTextViewHeight))
        self.exampleTextView.layer.borderColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1).cgColor
        self.exampleTextView.layer.borderWidth = 1
        self.exampleTextView.layer.cornerRadius = 3
        self.exampleTextView.textColor = #colorLiteral(red: 0.7333333333, green: 0.7333333333, blue: 0.7333333333, alpha: 1)
        self.exampleTextView.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        //self.exampleTextView.text = 

        self.contentView.addSubview(self.infoLabel)
        self.contentView.addSubview(self.exampleTextView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
