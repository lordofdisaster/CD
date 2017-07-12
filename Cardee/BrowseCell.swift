//
//  BrowseCell.swift
//  Cardee
//
//  Created by Leonid Nifantyev on 7/12/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class BrowseCell: UITableViewCell {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    
    
    func configureCell(_ car: SimpleCar)  {
        
        
        if let imgUrl = car.carImage, let imageUrl = URL(string: imgUrl) {
            carImageView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(), filter: nil, progress: { progress in
                print("Progress \(progress)")
            }, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { data in
                print(data)
            }
            
            if let yearString = car.yearManufacture {
                let yearAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin) ]
                let yearAttributedString = NSAttributedString(string: yearString, attributes: yearAttribute)
                let carNameString = car.carTitle! + "  "
                let carNameAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold) ]
                let carNameAttributedString = NSAttributedString(string: carNameString, attributes: carNameAttribute)
                
                let result = NSMutableAttributedString()
                result.append(carNameAttributedString)
                result.append(yearAttributedString)
                
                carNameLabel.attributedText = result
                
            }
        }
        
        
    }
    
    
    

}
