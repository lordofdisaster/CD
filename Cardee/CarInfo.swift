//
//  CarInfo.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/31/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CarInfo: NSObject {
    
    var carBrand: String?
    var carModel: String?
    var yearOfManufacture: String?
    var carTitle: String?
    var licensePlateNumber: String?
    var seatingCapacity: Int?
    var engineCapacity: String?
    var transmission: Transmission?
    var bodyType: BodyType?
    
    var isNotEmpty = false
    
    override init() {
        super.init()
    }
    
    func isFilled() -> Bool {
        if (self.carBrand != nil && !(self.carBrand?.isEmpty)!) && (self.carModel != nil && !(self.carModel?.isEmpty)!) && (self.yearOfManufacture != nil && !(self.yearOfManufacture?.isEmpty)!) && (self.carTitle != nil && !(self.carTitle?.isEmpty)!) && (self.licensePlateNumber != nil && !(self.licensePlateNumber?.isEmpty)!) && self.seatingCapacity != nil && (self.engineCapacity != nil && !(self.engineCapacity?.isEmpty)!) && self.transmission != nil && self.bodyType != nil {
            self.isNotEmpty = true
            return true
        } else {
            self.isNotEmpty = false
            return false
        }
    }
}
