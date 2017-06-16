//
//  DetailRentalRatesTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class DetailRentalRatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rentalTypeLabel: UILabel!
    @IBOutlet weak var firstRateLabel: UILabel!
    @IBOutlet weak var secondRateLabel: UILabel!
    @IBOutlet weak var firstDiscountLabel: UILabel!
    @IBOutlet weak var secondDiscountLabel: UILabel!
    @IBOutlet weak var ratesEditButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
