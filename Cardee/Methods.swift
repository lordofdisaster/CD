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
    
    class func encodeImageToBase64(image: UIImage) -> String {
        let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
        let imageStringRepresentation = imageData.base64EncodedString(options: .lineLength64Characters)
        return imageStringRepresentation
    }

}
