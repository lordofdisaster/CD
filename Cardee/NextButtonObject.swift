//
//  NextButtonView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/6/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class NextButtonObject: NSObject {
    
    let backView = UIView()
    var nextButton: NextButtonView!
    
    override init() {
        super.init()
    }
    
    func addButton(on view: UIView) {
        self.initializeButtonInterface(for: view)
    }
    
    func changeLabelColor() {
        self.nextButton.nextLabel.textColor = UIColor.red
    }
    
    func initializeButtonInterface(for view: UIView) {
        
        // Back view
        
        self.backView.frame = CGRect(x: 0, y: view.frame.height - 73 - 64, width: view.frame.width, height: 73)
        
        // Next button
        
        let nextButtonOffset = 13
        let nextButtonWidth = 100
        let nextButtonX = view.frame.width - CGFloat(nextButtonWidth) - CGFloat(nextButtonOffset)
        let nextButtonY = 0
        let nextButtonHeight = 56
        
        self.nextButton = NextButtonView(frame: CGRect(x: Int(nextButtonX), y: nextButtonY, width: nextButtonWidth, height: nextButtonHeight))
        self.backView.addSubview(self.nextButton)
        view.addSubview(self.backView)
    }
}
