//
//  InsuranceInfo.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/30/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class InsuranceInfo: NSObject {
    
    var comprehensiveInsurance = false
    var coversDrivers = false
    var minimumAge: Int?
    var minimumExperience: Int?
    var insuranceExpiresDate: Date?
    var accidentIssue: String!
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if self.minimumAge != nil && self.minimumExperience != nil && self.insuranceExpiresDate != nil && !self.accidentIssue.isEmpty {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }

}
