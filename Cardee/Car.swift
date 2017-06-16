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
    var payMileage: Float!
    
    // Rental Info
    
    //var carAvailabilityHourly
    //var carAvailabilityDaily
    var isInstantBooking: (hourly: Bool, daily: Bool)!
    var isCurbsideDelivery: (hourly: Bool, daily: Bool)!
    var isAcceptCash: (hourly: Bool, daily: Bool)!
    
    // -- Curbside Delivery
    
    var baseRate: Int!
    var distanceRate: Int!
    var isProvideFreeDelivery: Bool!
    var rentalDuration: Int!
    
    // -- Rental Rates
    
    var firstRates: (hourly: Int, daily: Int)!
    var secondRates: (hourly: Int, daily: Int)!
    var firstDiscount: (hourly: Int, daily: Int)!
    var secondDiscount: (hourly: Int, daily: Int)!
    var minimumRentalDuration: (hourly: Int, daily: Int)!
    
    // -- Fuel Policy
    
    var fuelPolicyId: (hourly: Int, daily: Int)!
    var fuelPolicyName: (hourly: String, daily: String)!
    
    // -- Rental Terms
    
    var driverExperience: Int!
    var minimumAge: Int!
    
    override init() {
        super.init()
    }
    
}
