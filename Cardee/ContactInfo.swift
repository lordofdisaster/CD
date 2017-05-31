//
//  ContactInfo.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class ContactInfo: NSObject {
    
    var name: String?
    var mobileNumber: String?
    var email: String?
    var accountType: String?
    var accountNumber: String?
    
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if (self.name != nil && !(self.name?.isEmpty)!) && (self.mobileNumber != nil && !(self.mobileNumber?.isEmpty)!) && (self.email != nil && !(self.email?.isEmpty)!) && (self.accountType != nil && !(self.accountType?.isEmpty)!) && (self.accountNumber != nil && !(self.accountNumber?.isEmpty)!) {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }

}
