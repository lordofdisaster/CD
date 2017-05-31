//
//  PersonalDocuments.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class PersonalDocuments: NSObject {
    
    var frontIdentityCardImage: UIImage?
    var backIdentityCardImage: UIImage?
    var businessProfile = [UIImage]()
    
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if frontIdentityCardImage != nil && backIdentityCardImage != nil {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }
}
