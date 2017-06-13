//
//  DetailRentalSettingsTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class DetailRentalSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var rentalTypeLabel: UILabel!
    @IBOutlet weak var instantBookingSwitch: UISwitch!
    @IBOutlet weak var curbsideDeliverySwitch: UISwitch!
    @IBOutlet weak var acceptCashSwitch: UISwitch!
    @IBOutlet weak var deliveryRatesButton: UIButton!
    @IBOutlet weak var settingsInfoButton: UIButton!
    
    @IBOutlet weak var instantBookingImageView: UIImageView!
    @IBOutlet weak var curbsideDeliveryImageView: UIImageView!
    @IBOutlet weak var acceptCashImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
