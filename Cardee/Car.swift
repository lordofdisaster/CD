//
//  Car.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/8/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class Car: NSObject {
    
    var carId: Int!
    //var carAvailabilityHourly
    //var carAvailabilityDaily
    var carTitle: String?
    var carImage = ""
    var licensePlateNumber: String!
    var yearManufacture: String!
    var address: String!
    var town: String!
    var isExactLocationHidden = Bool()
    var carDescription: String?
    var latitude: Double!
    var longitude: Double!
    
    override init() {
        super.init()
    }
    
}
