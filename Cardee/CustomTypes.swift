//
//  CustomTypes.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

enum DocumentType: Int {
    case car = 0
    case personal
}

enum VehicleType: Int {
    case personal = 1
    case uber
    case taxi
    case commercial
}

enum Transmission: Int {
    case automatic = 1
    case manual
}

enum BodyType: Int {
    case sedan = 1
    case liftback
    case suv
    case hatchback
    case wagon
    case coupe
    case convertible
    case minivan
    case pickup
    case van
    case limousin
}
