//
//  CarDocuments.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarDocuments: NSObject {
    
    var vehicleLogCard = [UIImage]()
    var vehicleInsurance = [UIImage]()
    
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if self.vehicleLogCard.count != 0 && self.vehicleInsurance.count != 0 {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }

}
