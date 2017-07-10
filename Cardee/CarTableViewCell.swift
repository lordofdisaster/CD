//
//  CarTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/4/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var hourlySwitch: UISwitch!
    @IBOutlet weak var dailySwitch: UISwitch!
    @IBOutlet weak var availableDaysLabel: UILabel!
    @IBOutlet weak var availableHoursLabel: UILabel!

    override func awakeFromNib() {
        hourlySwitch.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        dailySwitch.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
    }
    
    func configureCell(_ car: SimpleCar) {
        if let carImg = car.carImage, let imageUrl = URL(string: carImg) {
        
            carImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(), filter: nil, progress: { progress in
                print("Progress \(progress)")
            }, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { data in
                print(data)
            }
        }
        
        if let yearString = car.yearManufacture {
            let yearAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin) ]
            let yearAttributedString = NSAttributedString(string: yearString, attributes: yearAttribute)
            let carNameString = car.carTitle + "  "
            let carNameAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold) ]
            let carNameAttributedString = NSAttributedString(string: carNameString, attributes: carNameAttribute)
            
            let result = NSMutableAttributedString()
            result.append(carNameAttributedString)
            result.append(yearAttributedString)
            
            carNameLabel.attributedText = result
            carNumberLabel.text = car.licensePlateNumber
        }
       
    }
    

}
