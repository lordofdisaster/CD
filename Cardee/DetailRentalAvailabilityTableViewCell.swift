//
//  DetailRentalAvailabilityTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class DetailRentalAvailabilityTableViewCell: UITableViewCell {

    @IBOutlet weak var rentalTypeLabel: UILabel!
    @IBOutlet weak var editDateButton: UIButton!
    @IBOutlet weak var editTimeButton: UIButton!
    @IBOutlet weak var availableDaysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
