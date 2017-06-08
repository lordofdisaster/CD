//
//  SimpleCar.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class SimpleCar: NSObject {
    
    var carId: Int!
    //var carAvailabilityHourly
    //var carAvailabilityDaily
    var carTitle: String!
    var carImage: String?
    var licensePlateNumber: String!
    var yearManufacture: String!

    override init() {
        super.init()
    }
}
