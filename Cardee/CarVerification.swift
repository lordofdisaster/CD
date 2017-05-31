//
//  CarVerificatoin.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarVerification: NSObject {
    
    var carImage: UIImage?
    
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if self.carImage != nil {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }

}
