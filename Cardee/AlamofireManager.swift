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
    
    //MARK: - Authentication
    
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
    
    //MARK: - Cars
    
    class func addCar(completionHandler: objectCompletionHandler? = nil) {
        
        let url = baseUrl + apiEndpoints.cars
        let headers = [
            "Authorization": keychain.get("access_token")!
        ]
        
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
            
            //"car_image": Methods.encodeImageToBase64(image: NewCar.shared.carVerification!.carImage!),
            
            "longitude": NewCar.shared.carLocation!.carLocationCoordinate!.longitude,
            "latitude": NewCar.shared.carLocation!.carLocationCoordinate!.latitude,
            "town": NewCar.shared.carLocation!.address!,
            "address": NewCar.shared.carLocation!.address!,
            "is_hide_exact_location": NewCar.shared.carLocation!.isExactLocationHidden!,            
            
            "car_documents": "",//NewCar.shared.carDocuments!.vehicleLogCard, //TO DO
            "personal_documents": "", //TO DO
            
            "name": NewCar.shared.contactInfo!.name!,
            "phone": Methods.transform(number: NewCar.shared.contactInfo!.mobileNumber!),
            "email": NewCar.shared.contactInfo!.email!
        ] as [String : Any]
        
        SharedManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print(response)
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completionHandler!(result["data"]["car_id"].intValue, nil)
            } else {
                completionHandler!(0, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func setImageFor(carId: Int, completionHandler: booleanCompletionHandler? = nil) {
        
        let headers = [
            "Authorization": keychain.get("access_token")!
        ]
        
        let url = try! URLRequest(url: URL(string: baseUrl + apiEndpoints.cars + "/\(carId)" + "/image")!, method: .put, headers: headers)
        
        let imageData = UIImageJPEGRepresentation(NewCar.shared.carVerification!.carImage!, 1.0)!
        
        SharedManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "car_image", fileName: "image.jpg", mimeType: "application/octet-stream")
        }, with: url, encodingCompletion: {
                encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                print("RESULT: \(upload)")
                completionHandler!(true, nil)
            case .failure(let encodingError):
                print("ERROR : \(encodingError.localizedDescription)")
                completionHandler!(true, nil)
            }
        })
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
                
                // Availability Daily
                
                car.availabilityDailyDates = result["data"]["car_availability_daily"].arrayValue.map {$0.stringValue}
                car.timePickup = result["data"]["order_daily_details"]["time_pickup"].stringValue
                car.timeReturn = result["data"]["order_daily_details"]["time_return"].stringValue
                
                // Availability Hourly
                
                car.availabilityHourlyDates = result["data"]["car_availability_hourly"].arrayValue.map {$0.stringValue}
                car.availabilityTimeBegin = result["data"]["car_availability_time_begin"].stringValue
                car.availabilityTimeEnd = result["data"]["car_availability_time_end"].stringValue

                // Curbside Delivery
                
                car.baseRate = result["data"]["car_details"]["delivery_rates"]["base_rate"].intValue
                car.distanceRate = result["data"]["car_details"]["delivery_rates"]["distance_rate"].intValue
                car.isProvideFreeDelivery = result["data"]["delivery_rates"]["is_provide_free_delivery"].boolValue
                car.rentalDuration = result["data"]["car_details"]["delivery_rates"]["rental_duration"].intValue
                
                // Rental Rates
                
                car.firstRates = (hourly: result["data"]["order_hourly_details"]["amnt_rate_first"].intValue, daily: result["data"]["order_daily_details"]["amnt_rate_first"].intValue)
                car.secondRates = (hourly: result["data"]["order_hourly_details"]["amnt_rate_second"].intValue, daily: result["data"]["order_daily_details"]["amnt_rate_second"].intValue)
                car.firstDiscount = (hourly: result["data"]["order_hourly_details"]["amnt_discount_first"].intValue, daily: result["data"]["order_daily_details"]["amnt_discount_first"].intValue)
                car.secondDiscount = (hourly: result["data"]["order_hourly_details"]["amnt_discount_second"].intValue, daily: result["data"]["order_daily_details"]["amnt_discount_second"].intValue)
                car.minimumRentalDuration = (hourly: result["data"]["order_hourly_details"]["min_rental_duration"].intValue, daily: result["data"]["order_daily_details"]["min_rental_duration"].intValue)
                
                // Fuel Policy
                
                car.fuelPolicyId = (hourly: result["data"]["order_hourly_details"]["fuel_policy"]["fuel_policy_id"].intValue, daily: result["data"]["order_daily_details"]["fuel_policy"]["fuel_policy_id"].intValue)
                car.fuelPolicyName = (hourly: result["data"]["order_hourly_details"]["fuel_policy"]["fuel_policy_name"].stringValue, result["data"]["order_daily_details"]["fuel_policy"]["fuel_policy_name"].stringValue)
                car.payMileage = result["data"]["order_hourly_details"]["amnt_pay_mileage"].float
                
                // Rental Terms
                
                car.driverExperience = result["data"]["car_details"]["req_dr_exp"].intValue
                car.minimumAge = result["data"]["car_details"]["req_min_age"].intValue
                
                completionHandler!(car, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    //MARK: - Car Availablity
    
    class func availabilityForCar(car: Car, completionHandler: booleanCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeAvailability
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "is_available_order_hours": true,
            "is_available_order_days": true
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
    
    class func availabilityHourlyForCar(car: Car, completionHandler: booleanCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeAvailabilityHourly
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "car_availability_time_begin": car.availabilityTimeBegin,
            "car_availability_time_end": car.availabilityTimeEnd,
            "car_availability_dates": car.availabilityHourlyDates
        ] as [String : Any]
        
        SharedManager.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let result = JSON(response.data!)
            if result["success"].boolValue {
                completionHandler!(true, nil)
            } else {
                completionHandler!(false, result["data"]["errors"]["description"].stringValue)
            }
        }
    }
    
    class func availabilityDailyForCar(car: Car, completionHandler: booleanCompletionHandler? = nil) {
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeAvailabilityDaily
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "car_availability_dates": car.availabilityDailyDates
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
    
    //MARK: - Change Car Info
    
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
        
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeDailyRentalInfo
        
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "is_instant_booking": car.isInstantBooking.daily,
            "is_curbside_delivery": car.isCurbsideDelivery.daily,
            "is_accept_cash": car.isAcceptCash.daily,
            "fuel_policy_id": car.fuelPolicyId.daily, //references/fuel_policy
            "amnt_rate_first": car.firstRates.daily,
            "amnt_rate_second": car.secondRates.daily,
            "amnt_discount_first": car.firstDiscount.daily,
            "amnt_discount_second": car.secondDiscount.daily,
            "min_rental_duration": car.minimumRentalDuration.daily,
            "time_pickup": car.timePickup,
            "time_return": car.timeReturn,
            "amnt_pay_mileage": car.baseRate // TO DO
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
    
    class func changeHourlyRentaInfoFor(car: Car, completinHandler: booleanCompletionHandler? = nil) {
        
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeHourlyRentalInfo
        
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        let parameters = [
            "is_instant_booking": car.isInstantBooking.hourly,
            "is_curbside_delivery": car.isCurbsideDelivery.hourly,
            "is_accept_cash": car.isAcceptCash.hourly,
            "fuel_policy_id": car.fuelPolicyId.hourly,
            "amnt_rate_first": car.firstRates.hourly,
            "amnt_rate_second": car.secondRates.hourly,
            "min_rental_duration": car.minimumRentalDuration.hourly,
            "amnt_pay_mileage": car.payMileage,
            "amnt_discount_first": car.firstDiscount.hourly,
            "amnt_discount_second": car.secondDiscount.hourly
            //"time_pickup": Date(),
            //"time_return": Date()
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
    
    class func changeRentalDeliveryRatesFor(car: Car, completinHandler: booleanCompletionHandler? = nil) {
        
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeDeliveryRates
        
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        
        let parameters = [
            "is_provide_free_delivery": car.isProvideFreeDelivery,
            "base_rate": car.baseRate,
            "distance_rate": car.distanceRate,
            "rental_duration": car.rentalDuration
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
    
    class func changeRentalTermsFor(car: Car, completinHandler: booleanCompletionHandler? = nil) {
        
        let url = baseUrl + apiEndpoints.cars + "/\(car.carId!)" + apiEndpoints.changeRentalTerms
        
        let headers = [
            "Authorization": self.keychain.get("access_token")!
        ]
        
        let parameters = [
            "insurance_min_age": 1,
            "insurance_min_year_dr_exp": 2,
            
            "is_req_security_deposit": true,
            "security_deposit_description": "",
            
            "compensation_excess": "",
            "compensation_other_guidelines": "",
            
            "add_ons": "",
        
            "additional_terms": ""
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

    //MARK: - Profile
    
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
    
    class func set(avatar: UIImage, completionHandler: booleanCompletionHandler? = nil) {
        
        let headers = [
            "Authorization": keychain.get("access_token")!
        ]
        
        let url = try! URLRequest(url: URL(string: baseUrl + apiEndpoints.profilePicture)!, method: .post, headers: headers)
        
        let imageData = UIImageJPEGRepresentation(avatar, 1.0)!
        
        SharedManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "data", fileName: "image.jpg", mimeType: "application/octet-stream")
        }, with: url, encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                print("RESULT: \(upload)")
                //completionHandler!(true, nil)
            case .failure(let encodingError):
                print("ERROR : \(encodingError.localizedDescription)")
                //completionHandler!(true, nil)
            }
        })
    }
}
