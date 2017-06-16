//
//  NetworkingConstants.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

let kLogin = "login"
let kPassword = "password"
let kSocialProvider = "social_provider"
let kToken = "token"
let kExpiredIn = "expired_in"

//let baseUrl = "http://192.168.1.50:5550/api/dev"
let baseUrl = "http://labracode.itg5.com/api/dev"

struct apiEndpoints {
    
    // Authenticaton
    static let login = "/auth/login"
    static let socialLogin = "/auth/login_social"
    static let signUp = "/auth/signup"
    static let logout = "/auth/logout"
    static let forgotPassword = "/auth/forgot_password"
    static let verifyPassword = "/auth/verify_password"
    
    //Cars
    static let cars = "/cars"
    static let changeDailyRentalInfo = "/rental/daily"
    static let changeHourlyRentalInfo = "/rental/hourly"
    static let changeDeliveryRates = "/delivery/rates"
    static let changeRentalTerms = "/rental/terms"
    
    //Profile
    static let ownerProfile = "/profiles/owner"
}
