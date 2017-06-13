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
    typealias objectCompletionHandler = (Any, String?) -> Swift.Void
    
    public static let SharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        let manager = Alamofire.SessionManager(configuration: configuration)
        let contentTypes: Set<String> = ["Content-Type", "binary/octet-stream"]
        DataRequest.addAcceptableImageContentTypes(contentTypes)
        return manager
    }()
    
    public static let keychain = KeychainSwift()
    
    //MARK: Authentication
    
    class func loginWith(username: String, password: String, completionHandler: booleanCompletionHandler? = nil) {
        
        let parameters = [
            kLogin: username,
            kPassword: password
        ]
        
        let url = baseUrl + apiEndpoints.login
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                keychain.set(result["data"].stringValue, forKey: "access_token")
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func signUpWith(username: String, password: String, name: String, picture: UIImage?, completionHandler: booleanCompletionHandler? = nil) {
        
        var parameters = [
            "login": username,
            "password": password,
            "pwd_confirm": password,
            "name": name,
        ]
        
        if let userImage = picture {
            parameters["picture"] = Methods.encodeImageToBase64(image: userImage)
        }
        
        let url = baseUrl + apiEndpoints.signUp
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                keychain.set(result["data"].stringValue, forKey: "access_token")
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
 
    class func loginWithSocial(type: SocialType, token: String, expirationDate: Date, completionHandler: booleanCompletionHandler? = nil) {
        
        let parameters = [
            kSocialProvider: type.rawValue,
            kToken: token
        ] as [String : Any]
        
        let url = baseUrl + apiEndpoints.socialLogin
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
            "town": NewCar.shared.carLocation!.town!,
            "address": NewCar.shared.carLocation!.address!,
            "is_hide_exact_location": NewCar.shared.carLocation!.isExactLocationHidden!,            
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
        
        SharedManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func getCarWith(id: Int, completionHandler: objectCompletionHandler? = nil) {
        
        let url = baseUrl + apiEndpoints.cars + "/\(id)"
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        
        SharedManager.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Detail car: \(response)")
            let result = JSON(response.data!)
            if result["success"].boolValue {
                let car = Car()
                car.carId = result["data"]["car_details"]["car_id"].intValue
                car.carTitle = result["data"]["car_details"]["car_title"].stringValue
                car.licensePlateNumber = result["data"]["car_details"]["license_plate_number"].stringValue
                car.yearManufacture = result["data"]["car_details"]["year_manufacture"].stringValue
                car.carImage = result["data"]["car_details"]["car_image"].stringValue
                car.address = result["data"]["car_details"]["address"].stringValue
                car.town = result["data"]["car_details"]["town"].stringValue
                car.isExactLocationHidden = result["data"]["car_details"]["is_hide_exact_location"].boolValue
                car.carDescription = result["data"]["car_details"]["description"].stringValue
                car.latitude = result["data"]["car_details"]["latitude"].doubleValue
                car.longitude = result["data"]["car_details"]["longitude"].doubleValue
                
                // Rental Info
                
                car.isInstantBooking = (hourly: result["data"]["order_hourly_details"]["is_instant_booking"].boolValue, daily: result["data"]["order_daily_details"]["is_instant_booking"].boolValue)
                car.isCurbsideDelivery = (hourly: result["data"]["order_hourly_details"]["is_curbside_delivery"].boolValue, daily: result["data"]["order_daily_details"]["is_curbside_delivery"].boolValue)
                car.isAcceptCash = (hourly: result["data"]["order_hourly_details"]["is_accept_cash"].boolValue, daily: result["data"]["order_daily_details"]["is_accept_cash"].boolValue)
                
                // Curbside Delivery
                
                car.baseRate = result["data"]["delivery_rates"]["base_rate"].intValue
                car.distanceRate = result["data"]["delivery_rates"]["distance_rate"].floatValue
                car.isProvideFreeDelivery = result["data"]["delivery_rates"]["is_provide_free_delivery"].boolValue
                car.rentalDuration = result["data"]["delivery_rates"]["rental_duration"].intValue
                
                // Rental Rates
                
                car.firstRates = (hourly: result["data"]["order_hourly_details"]["amnt_rate_first"].floatValue, daily: result["data"]["order_daily_details"]["amnt_rate_first"].floatValue)
                car.secondRates = (hourly: result["data"]["order_hourly_details"]["amnt_rate_second"].floatValue, daily: result["data"]["order_daily_details"]["amnt_rate_second"].floatValue)
                car.firstDiscount = (hourly: result["data"]["order_hourly_details"]["amnt_discount_first"].floatValue, daily: result["data"]["order_daily_details"]["amnt_discount_first"].floatValue)
                car.secondDiscount = (hourly: result["data"]["order_hourly_details"]["amnt_discount_second"].floatValue, daily: result["data"]["order_daily_details"]["amnt_discount_second"].floatValue)
                car.minimumRentalDuration = (hourly: result["data"]["order_hourly_details"]["min_rental_duration"].intValue, daily: result["data"]["order_daily_details"]["min_rental_duration"].intValue)
                
                // Fuel Policy
                
                car.fuelPolicyId = (hourly: result["data"]["order_hourly_details"]["fuel_policy"]["fuel_policy_id"].intValue, daily: result["data"]["order_daily_details"]["fuel_policy"]["fuel_policy_id"].intValue)
                car.fuelPolicyName = (hourly: result["data"]["order_hourly_details"]["fuel_policy"]["fuel_policy_name"].stringValue, result["data"]["order_daily_details"]["fuel_policy"]["fuel_policy_name"].stringValue)
                
                
                completionHandler!(car, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func change(description: String, forCarWith id: Int, completionHandler: booleanCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.cars + "/\(id)" + "/description"
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "note": description
        ]
        
        SharedManager.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func change(location: CarLocation, forCarWith id: Int, completinHandler: booleanCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.cars + "/\(id)" + "/location"
        
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "longitude": location.carLocationCoordinate!.longitude,
            "latitude": location.carLocationCoordinate!.latitude,
            "town": location.town,
            "address": location.address,
            "is_hide_exact_location": location.isExactLocationHidden
        ] as [String: Any]
        
        SharedManager.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completinHandler!(true, nil)
            } else {
                completinHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func changeDailyRentaInfoFor(car: Car, completinHandler: booleanCompletionHandler? = nil) {
        
        
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId)" + apiEndpoints.changeDailyRentalInfo
        
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "is_instant_booking": true,
            "is_curbside_delivery": true,
            "is_accept_cash": true,
            "fuel_policy_id": 1,/// references/fuel_policy
            "rate_first": 60.0,
            "rate_second": 20.0,
            "amnt_discount_first": 10.0,
            "amnt_discount_second": 10.0,
            "min_rental_duration": 5,
            "time_pickup": Date(),
            "time_return": Date(),
            "amnt_pay_mileage": 5
        ] as [String : Any]
        
        SharedManager.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completinHandler!(true, nil)
            } else {
                completinHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }

    //MARK: Profile
    
    class func getOwnerProfile(completionHandler: booleanCompletionHandler? = nil) {
        
        let url = baseUrl + apiEndpoints.ownerProfile
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        
        SharedManager.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
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
