//
//  DetailRentalFuelTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class DetailRentalFuelTableViewCell: UITableViewCell {

    @IBOutlet weak var rentalTypeLabel: UILabel!
    @IBOutlet weak var editFuelPolicyButton: UIButton!
    @IBOutlet weak var fuelPolicyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
