//
//  CarTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/4/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    var carImageView: UIImageView!
    var carDescriptionBackground: UIView!
    var carNameLabel: UILabel!
    var carNumberLabel: UILabel!
    var hourlyLabel: UILabel!
    var dailyLabel: UILabel!
    var hourlySwitch: UISwitch!
    var dailySwitch: UISwitch!
    var availableDaysLabel: UILabel!
    var editButton: UIButton!
    var separatorView: UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        // Separator view
        
        let separatorViewTopOffset = 25
        let separatorViewX = 0
        let separatorViewY = 0
        let separatorViewWidth = Screen.width
        let separatorViewHeight = 13
        
        self.separatorView = UIView(frame: CGRect(x: CGFloat(separatorViewX), y: CGFloat(separatorViewY), width: separatorViewWidth, height: CGFloat(separatorViewHeight)))
        self.separatorView.backgroundColor = Color.lightGray
        
        // Car image view
        
        let carImageViewX = 0
        let carImageViewY = separatorViewHeight
        let carImageViewWidth = Screen.width
        let carImageViewHeight = CGFloat(202.0)
        
        self.carImageView = UIImageView(frame: CGRect(x: CGFloat(carImageViewX), y: CGFloat(carImageViewY), width: carImageViewWidth, height: carImageViewHeight))
        self.carImageView.backgroundColor = UIColor.lightGray
        self.carImageView.contentMode = .scaleAspectFill
        self.carImageView.clipsToBounds = true
        
        // Car description background
        
        let carViewWidth = Screen.width
        let carViewHeight = 36
        let carViewX = 0
        let carViewY = carImageViewHeight - CGFloat(carViewHeight)
        
        self.carDescriptionBackground = UIView(frame: CGRect(x: CGFloat(carViewX), y: CGFloat(carViewY), width: carViewWidth, height: CGFloat(carViewHeight)))
        self.carDescriptionBackground.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        // Car name label
        
        let carNameLabelX = 13
        let carNameLabelY = 0
        let carNameLabelWidth = carViewWidth/1.5
        let carNameLabelHeight = carViewHeight
        
        self.carNameLabel = UILabel(frame: CGRect(x: carNameLabelX, y: carNameLabelY, width: Int(carNameLabelWidth), height: carNameLabelHeight))
        self.carNameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.carNameLabel.textColor = UIColor.white
        self.carNameLabel.text = "Mazda 3 2016"
        
        // Car number label
        
        let carNumberLabelX = CGFloat(carNameLabelX) + carNameLabelWidth
        let carNumberLabelY = 0
        let carNumberLabelWidth = carViewWidth - carNumberLabelX - 13
        let carNumberLabelHeight = carViewHeight
        
        self.carNumberLabel = UILabel(frame: CGRect(x: Int(carNumberLabelX), y: carNumberLabelY, width: Int(carNumberLabelWidth), height: carNumberLabelHeight))
        self.carNumberLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        self.carNumberLabel.textColor = UIColor.white
        self.carNumberLabel.text = "SLE8938Y"
        self.carNumberLabel.textAlignment = .right
        
        // Hourly label
        
        let hourlyLabelTopOffset = 20
        let hourlyLabelX = 26
        let hourlyLabelY = CGFloat(carImageViewY) + carImageViewHeight + CGFloat(hourlyLabelTopOffset)
        let hourlyLabelWidth = 50
        let hourlyLabelHeight = 20
        
        self.hourlyLabel = UILabel(frame: CGRect(x: hourlyLabelX, y: Int(hourlyLabelY), width: hourlyLabelWidth, height: hourlyLabelHeight))
        self.hourlyLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        self.hourlyLabel.textColor = Color.grayText
        self.hourlyLabel.text = "Daily"
        
        // Hourly control
        
        let hourlySwitchSideOffset = 20
        let hourlySwitchX = hourlyLabelX + hourlyLabelWidth + hourlySwitchSideOffset
        let hourlySwitchY = hourlyLabelY - 5
        
        self.hourlySwitch = UISwitch(frame: CGRect(x: hourlySwitchX, y: Int(hourlySwitchY), width: 0, height: 0))
        self.hourlySwitch.onTintColor = Color.blue
        
        // Daily label
        
        let dailyLabelTopOffset = 20
        let dailyLabelX = Screen.width/2 + CGFloat(hourlyLabelX)
        let dailyLabelY = CGFloat(carImageViewY) + carImageViewHeight + CGFloat(dailyLabelTopOffset)
        let dailyLabelWidth = 50
        let dailyLabelHeight = 20
        
        self.dailyLabel = UILabel(frame: CGRect(x: Int(dailyLabelX), y: Int(dailyLabelY), width: dailyLabelWidth, height: dailyLabelHeight))
        self.dailyLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        self.dailyLabel.textColor = Color.grayText
        self.dailyLabel.text = "Hourly"
        
        // Daily control
        
        let dailySwitchSideOffset = 29
        let dailySwitchX = dailyLabelX + CGFloat(dailyLabelWidth) + CGFloat(dailySwitchSideOffset)
        let dailySwitchY = dailyLabelY - 5
        
        self.dailySwitch = UISwitch(frame: CGRect(x: Int(dailySwitchX), y: Int(dailySwitchY), width: 0, height: 0))
        self.dailySwitch.onTintColor = Color.blue
        
        // Available days label
        
        let availableDaysTopOffset = 25
        let availableDaysX = 26
        let availableDaysY = hourlyLabelY + CGFloat(hourlyLabelHeight) + CGFloat(availableDaysTopOffset)
        let availableDaysWidth = 115
        let availableDaysHeight = 20
        
        self.availableDaysLabel = UILabel(frame: CGRect(x: availableDaysX, y: Int(availableDaysY), width: availableDaysWidth, height: availableDaysHeight))
        self.availableDaysLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightRegular)
        self.availableDaysLabel.textColor = Color.grayText
        self.availableDaysLabel.text = "6 available days"
        
        // Edit button
        
        let editButtonWidth = 35
        let editButtonX = Screen.width - CGFloat(availableDaysX) - CGFloat(editButtonWidth)
        let editButtonY = hourlyLabelY + CGFloat(hourlyLabelHeight) + CGFloat(availableDaysTopOffset)
        let editButtonHeight = 20
        
        self.editButton = UIButton(type: .system)
        self.editButton.frame = CGRect(x: Int(editButtonX), y: Int(editButtonY), width: editButtonWidth, height: editButtonHeight)
        self.editButton.setTitle("edit", for: .normal)
        self.editButton.setTitleColor(Color.blue, for: .normal)
        self.editButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        
        
        // Adding to content view
        
        self.contentView.addSubview(self.carImageView)
        self.carImageView.addSubview(self.carDescriptionBackground)
        self.carDescriptionBackground.addSubview(self.carNameLabel)
        self.carDescriptionBackground.addSubview(self.carNumberLabel)
        self.contentView.addSubview(self.hourlyLabel)
        self.contentView.addSubview(self.hourlySwitch)
        self.contentView.addSubview(self.dailyLabel)
        self.contentView.addSubview(self.dailySwitch)
        self.contentView.addSubview(self.availableDaysLabel)
        self.contentView.addSubview(self.editButton)
        self.contentView.addSubview(self.separatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
