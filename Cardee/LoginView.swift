//
//  LoginView.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var loginContainerView: UIView!
    var signUpButton: UIButton!
    var fieldView: UIView!
    var emailTextField: LoginTextField!
    var passwordTextField: LoginTextField!
    var loginButton: UIButton!
    var forgotPasswordButton: UIButton!
    var socialLoginView: SocianLoginView!
    var termsAndPolicyButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Container View
        self.loginContainerView = UIView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        self.loginContainerView.backgroundColor = Color.blue
        
        // Signup Button
        let signUpButtonWidth = Screen.width
        let signUpButtonHeight = 20
        let signUpButtonTopOffset = 60
        let signUpButtonY = CGFloat(signUpButtonTopOffset)
        let signUpButtonX = 0
        self.signUpButton = UIButton(type: .system)
        self.signUpButton.frame = CGRect(x: signUpButtonX, y: Int(signUpButtonY), width: Int(signUpButtonWidth), height: signUpButtonHeight)
        self.signUpButton.setTitle("No account? Sign up now!", for: .normal)
        //self.signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.signUpButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        let myString = "No account? Sign up now!"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: Color.yellow, range: NSRange(location: 11, length: 13))
        
        self.signUpButton.titleLabel?.attributedText = myMutableString
        
        // Common field values
        let textFieldOffset = 40
        let textFieldHeight = 50
        let textFieldWidth = Screen.width - CGFloat(2 * textFieldOffset)
        // Email textfield values
        let emailTextFieldY = self.signUpButton.frame.origin.y + self.signUpButton.frame.height + CGFloat(textFieldOffset)
        // Password textfield values
        let passwordTextFieldY = CGFloat(textFieldHeight) - 0.5
        
        // Form container view
        self.fieldView = UIView(frame: CGRect(x: CGFloat(textFieldOffset), y: emailTextFieldY, width: textFieldWidth, height: CGFloat(2 * textFieldHeight) - 0.5))
        self.fieldView.layer.cornerRadius = 5
        self.fieldView.clipsToBounds = true
        self.fieldView.layer.borderWidth = 0.5
        self.fieldView.layer.borderColor = Color.lightBlue.cgColor
        
        // Email textfield
        self.emailTextField = LoginTextField(frame: CGRect(x: 0, y: 0, width: Int(self.fieldView.frame.width), height: textFieldHeight), customPlaceholder: "Email")
        
        // Password textfield
        self.passwordTextField = LoginTextField(frame: CGRect(x: CGFloat(0), y: passwordTextFieldY, width: self.fieldView.frame.width, height: CGFloat(textFieldHeight)), customPlaceholder: "Password")
        self.passwordTextField.isSecureTextEntry = true
        
        // Login button
        let loginButtonOffset = 40
        let loginButtonTopOffset = 15
        let loginButtonY = self.fieldView.frame.origin.y + self.fieldView.frame.height + CGFloat(loginButtonTopOffset)
        let loginButtonHeight = 50
        let loginButtonWidth = Screen.width - CGFloat(2 * loginButtonOffset)
        
        self.loginButton = UIButton(type: .system)
        self.loginButton.frame = CGRect(x: loginButtonOffset, y: Int(loginButtonY), width: Int(loginButtonWidth), height: loginButtonHeight)
        self.loginButton.setTitle("Log in", for: .normal)
        self.loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.loginButton.setTitleColor(Color.blue, for: .normal)
        self.loginButton.backgroundColor = UIColor.white
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.layer.masksToBounds = true
        
        // Forgot password button
        let forgotPasswordTopOffset = 10
        let forgotPasswordWidth = Screen.width
        let forgotPasswordHeight = 15
        let forgotPasswordX = 0
        let forgotPasswordY = self.loginButton.frame.origin.y + self.loginButton.frame.height + CGFloat(forgotPasswordTopOffset)
        self.forgotPasswordButton = UIButton(type: .system)
        self.forgotPasswordButton.frame = CGRect(x: CGFloat(forgotPasswordX), y: forgotPasswordY, width: forgotPasswordWidth, height: CGFloat(forgotPasswordHeight))
        self.forgotPasswordButton.setTitleColor(Color.yellow, for: .normal)
        self.forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.forgotPasswordButton.setTitle("Forgot your password?", for: .normal)
        
        // Terms & Policy button
        let termsAndPolicyY = Screen.height - 40
        self.termsAndPolicyButton = UIButton(type: .system)
        self.termsAndPolicyButton.frame = CGRect(x: CGFloat(forgotPasswordX), y: termsAndPolicyY, width: forgotPasswordWidth, height: CGFloat(forgotPasswordHeight))
        self.termsAndPolicyButton.setTitleColor(Color.yellow, for: .normal)
        self.termsAndPolicyButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.termsAndPolicyButton.titleLabel?.numberOfLines = 2
        self.termsAndPolicyButton.titleLabel?.textAlignment = .center
        self.termsAndPolicyButton.setTitle("By signing up, you agree to Cardee's\nTerms of Service & Privacy Policy", for: .normal)
        self.termsAndPolicyButton.isHidden = true
        
        // Connect via SN
        let socialLoginViewY = self.forgotPasswordButton.frame.origin.y + self.forgotPasswordButton.frame.height + 40
        let socialLoginViewX = 0
        let socialLoginViewWidth = Screen.width
        let socialLoginViewHeight = Screen.height
        self.socialLoginView = SocianLoginView(frame: CGRect(x: CGFloat(socialLoginViewX), y: socialLoginViewY, width: socialLoginViewWidth, height: socialLoginViewHeight))
        
        // Add to superview
        self.addSubview(self.loginContainerView)
        self.loginContainerView.addSubview(self.signUpButton)
        self.loginContainerView.addSubview(self.fieldView)
        self.fieldView.addSubview(self.emailTextField)
        self.fieldView.addSubview(self.passwordTextField)
        self.loginContainerView.addSubview(self.loginButton)
        self.loginContainerView.addSubview(self.forgotPasswordButton)
        self.loginContainerView.addSubview(self.socialLoginView)
        self.loginContainerView.addSubview(self.termsAndPolicyButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
