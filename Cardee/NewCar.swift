//
//  NewCar.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/30/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

final class NewCar {
    
    private init() {}
    static let sharedInstance = NewCar()
    
    var vehicleType: VehicleType?
    var insuranceInfo: InsuranceInfo?
    var carInfo: CarInfo?
    var carVerification: CarVerification?
    var carLocation: CarLocation?
    var carDocuments: CarDocuments?
    var personalDocuments: PersonalDocuments?
    var contactInfo: ContactInfo?
    
    func dispose() {
        self.vehicleType = nil
        self.insuranceInfo = nil
        self.carInfo = nil
        self.carVerification = nil
        self.carLocation = nil
        self.carDocuments = nil
        self.personalDocuments = nil
        self.contactInfo = nil
    }
    
    func isFilled() -> Bool {
        if (self.vehicleType != nil) && (self.insuranceInfo?.isNotEmpty)! && (self.carInfo?.isNotEmpty)! && (self.carVerification?.isNotEmpty)! && (self.carLocation?.isNotEmpty)! && (self.carDocuments?.isNotEmpty)! && (self.personalDocuments?.isNotEmpty)! && (self.contactInfo?.isNotEmpty)! {
            return true
        } else {
            return false
        }
    }
}
