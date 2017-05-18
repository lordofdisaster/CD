//
//  LoginTextField.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    init(frame: CGRect, customPlaceholder: String) {
        super.init(frame: frame)
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Color.lightBlue.cgColor
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 14)
        self.tintColor = UIColor.white
        self.autocorrectionType = .no
        self.attributedPlaceholder = NSAttributedString(string: customPlaceholder, attributes: [NSForegroundColorAttributeName: Color.lightBlue])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: CGFloat(15), dy: CGFloat(0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: CGFloat(15), dy: CGFloat(0))
    }
    
    
}
