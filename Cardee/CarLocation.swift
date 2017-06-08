//
//  CarLocation.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import CoreLocation

class CarLocation: NSObject {
    
    var carLocationCoordinate: CLLocationCoordinate2D?
    var address: String!
    var town: String!
    var isExactLocationHidden: Bool!
    
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if self.carLocationCoordinate != nil {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }

}
