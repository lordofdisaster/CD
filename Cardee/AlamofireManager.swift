//
//  AlamofireManager.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/5/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift

class AlamofireManager: NSObject {

    typealias booleanCompletionHandler = (Bool, String?) -> Swift.Void
    
    public static let sharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    //MARK: Authentication
    
    class func loginWith(username: String, password: String, completionHandler: booleanCompletionHandler? = nil) {
        
        let parameters = [
            kLogin: username,
            kPassword: password
        ]
        
        let url = baseUrl + apiEndpoints.login
        let keychain = KeychainSwift()
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                keychain.set(result["data"].stringValue, forKey: "access_token")
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["error"].stringValue)
            }
        }
    }
 
    class func loginWithSocial(type: SocialType, token: String, expirationDate: Date, completionHandler: booleanCompletionHandler? = nil) {
        
        let parameters = [
            kSocialProvider: type.rawValue,
            kToken: token,
            kExpiredIn: Methods.transformDateToString(date: expirationDate)
        ] as [String : Any]
        
        let url = baseUrl + apiEndpoints.socialLogin
        let keychain = KeychainSwift()
        
        sharedManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                keychain.set(result["data"].stringValue, forKey: "access_token")
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    //MARK: Cars
    
    class func addCar(completionHandler: booleanCompletionHandler? = nil) {
        let keychain = KeychainSwift()
        let parameters = [
            "type_vehicle_id": NewCar.shared.vehicleType!.rawValue,
            "is_insurance_comprehensive": NewCar.shared.insuranceInfo!.comprehensiveInsurance,
            "is_insurance_unnamed_driver": NewCar.shared.insuranceInfo!.coversDrivers,
            "insurance_min_age": NewCar.shared.insuranceInfo!.minimumAge!,
            "insurance_min_year_dr_exp": NewCar.shared.insuranceInfo!.minimumExperience!,
            "date_insurance_expired": Methods.transformDateToString(date: NewCar.shared.insuranceInfo!.insuranceExpiresDate!),
            
            "car_make": NewCar.shared.carInfo!.carBrand!,
            "car_model": NewCar.shared.carInfo!.carModel!,
            "year_manufacture": NewCar.shared.carInfo!.yearOfManufacture!,
            "car_title": NewCar.shared.carInfo!.carTitle!,
            "license_plate_number": NewCar.shared.carInfo!.licensePlateNumber!,
            "seating_capacity": NewCar.shared.carInfo!.seatingCapacity!,
            "car_engine_capacity": NewCar.shared.carInfo!.engineCapacity!,
            "car_transmission_id": NewCar.shared.carInfo!.transmission!.rawValue,
            "car_body_type_id": NewCar.shared.carInfo!.bodyType!.rawValue,
            
            "car_image": Methods.encodeImageToBase64(image: NewCar.shared.carVerification!.carImage!),
            
            "longitude": NewCar.shared.carLocation!.carLocationCoordinate!.longitude,
            "latitude": NewCar.shared.carLocation!.carLocationCoordinate!.latitude,
            "town": "Test Town", //TO DO
            "address": "Test Adress", //TO DO
            "is_hide_exact_location": false, //TO DO
            
            "car_documents": "",//NewCar.shared.carDocuments!.vehicleLogCard, //TO DO
            
            "personal_documents": "", //TO DO
            
            "name": NewCar.shared.contactInfo!.name!,
            "phone": NewCar.shared.contactInfo!.mobileNumber!,
            "email": NewCar.shared.contactInfo!.email!
        ] as [String : Any]
        

        let url = baseUrl + apiEndpoints.cars
        let headers = [
            "Authorization": keychain.get("access_token")!
        ]
        
        sharedManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }

    //MARK: Profile
    
    class func getOwnerProfile(completionHandler: booleanCompletionHandler? = nil) {
        let keychain = KeychainSwift()
        let url = baseUrl + apiEndpoints.ownerProfile
        let headers = [
            "Authorization": keychain.get("access_token")!
        ]
        
        sharedManager.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            let result = JSON(response.data!)
            if result["success"].boolValue {
                OwnerProfile.shared.profileId = result["data"]["profile_id"].intValue
                OwnerProfile.shared.profilePhoto = nil
                OwnerProfile.shared.name = result["data"]["name"].stringValue
                OwnerProfile.shared.bookingsCount = result["data"]["cnt_bookings"].intValue
                OwnerProfile.shared.carsCount = result["data"]["car_cnt"].intValue
                OwnerProfile.shared.reviewCount = result["data"]["review_cnt"].intValue
                OwnerProfile.shared.cars.removeAll()
                for i in 0..<OwnerProfile.shared.carsCount {
                    let simpleCar = SimpleCar()
                    simpleCar.carId = result["data"]["cars"][i]["car_details"]["car_id"].intValue
                    simpleCar.carTitle = result["data"]["cars"][i]["car_details"]["car_title"].stringValue
                    simpleCar.licensePlateNumber = result["data"]["cars"][i]["car_details"]["license_plate_number"].stringValue
                    simpleCar.yearManufacture = result["data"]["cars"][i]["car_details"]["year_manufacture"].stringValue
                    simpleCar.carImage = result["data"]["cars"][i]["car_details"]["car_image"].stringValue
                    OwnerProfile.shared.cars.append(simpleCar)
                }
                
                
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }


}
