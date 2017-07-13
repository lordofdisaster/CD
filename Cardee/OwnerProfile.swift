//
//  OwnerProfile.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/7/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

final class OwnerProfile {
    
    private init() {}
    static let shared = OwnerProfile()
    
    var profileId: Int!
    var profilePhoto: UIImage?
    var name: String?
    var acceptance: String?
    var responseTime: String?
    var bookingsCount: Int!
    //var note
    var carsCount: Int!
    var cars = [SimpleCar]()
    var reviewCount: Int!
    //var reviews
    //var settings
}
