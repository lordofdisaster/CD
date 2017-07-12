//
//  Methods.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class Methods: NSObject {
    
    // MARK - Transform date
    
    class func transformDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"//'T'HH:mm:ss.SSSZ
        return dateFormatter.string(from: date)
    }
    
    class func transformStringToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)!
    }
    
    // MARK - Car picking date transforms
    
    class func transformPickupTimeToString(pickupTime: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        dateFormatter.dateFormat = "hha"
        let date = dateFormatter.date(from: pickupTime)
        
        let finalDateFormatter = DateFormatter()
        finalDateFormatter.dateFormat = "HH:mm:ssZ"
        return finalDateFormatter.string(from: date!)
    }
    
    class func transformFullTimeFormatToLocal(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ssZ"
        let date = dateFormatter.date(from: time)
        
        let finalDateFormatter = DateFormatter()
        finalDateFormatter.amSymbol = "am"
        finalDateFormatter.pmSymbol = "pm"
        finalDateFormatter.dateFormat = "ha"
        return finalDateFormatter.string(from: date!)
    }
    
    // MARK - Encode image
    
    class func encodeImageToBase64(image: UIImage) -> String {
        let imageData: NSData = UIImageJPEGRepresentation(image, 0.1)! as NSData
        let imageStringRepresentation = imageData.base64EncodedString(options: .lineLength64Characters)
        return imageStringRepresentation
    }
    
    // MARK - Validations
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // MARK - Phone number transform
    
    class func transform(number: String) -> String {
        let components = number.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        return components.joined(separator: "")
    }

}

