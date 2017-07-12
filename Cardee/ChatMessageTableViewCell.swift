//
//  ChatMessageTableViewCell.swift
//  Cardee
//
//  Created by Alexander Lisovik on 7/3/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBadgeImageView: UIView!
    @IBOutlet weak var messageBadgeValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width/2
        self.messageBadgeImageView.layer.cornerRadius = self.messageBadgeImageView.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
