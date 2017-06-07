//
//  CardeeAlert.swift
//  Cardee
//
//  Created by Alexander Lisovik on 6/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class CardeeAlert: NSObject {
    
    class func showAlert(withTitle title: String, message: String, sender: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        sender.present(alertController, animated: true, completion: nil)
    }

}
