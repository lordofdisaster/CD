//
//  Methods.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class Methods: NSObject {
    
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
    
    class func encodeImageToBase64(image: UIImage) -> String {
        let imageData: NSData = UIImageJPEGRepresentation(image, 0.1)! as NSData
        let imageStringRepresentation = imageData.base64EncodedString(options: .lineLength64Characters)
        return imageStringRepresentation
    }

}

