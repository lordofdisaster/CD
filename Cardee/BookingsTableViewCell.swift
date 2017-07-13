//
//  BookingsTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 7/13/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class BookingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cellContentView.layer.borderColor = Color.darkGray.cgColor
        self.cellContentView.layer.borderWidth = 0.5
        self.cellContentView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
