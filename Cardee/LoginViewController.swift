//
//  ViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var isUserWantSignUp = true
    var loginView: LoginView!
    var signUpView: SignUpView!
    var tapGestureRecognizer: UITapGestureRecognizer!
    let imagePicker = UIImagePickerController()
    
    enum LoginFlow: Int {
        case Login = 0
        case RegistrationName
        case RegistrationPassword
    }
    
    //MARK: Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLoginView()
        self.initImagePicker()
    }
    
    //MARK: Actions
    
    func loginAction() {
        print("Login")
    }
    
    func loginWithFacebookAction() {
        print("Login FB")
    }
    
    func loginWithGoogleAction() {
        print("Login G+")
    }
    
    func startSignUpAction() {
        if (self.isUserWantSignUp) {
            self.setLoginState()
        } else {
            self.setSignUpState()
        }
    }
    
    func nextSignUpAction() {
        self.setFinishSignUpState()
    }
    
    func signUpAction() {
        print("Sign Up")
    }
    
    func forgotPasswordAction() {
        print("Forgot Password")
    }
    
    func backToLoginAction() {
        NotificationCenter.default.removeObserver(self)
        self.loginView.isHidden = false
        self.signUpView.isHidden = true
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK: States
    
    func setSignUpState() {
        self.loginView.signUpButton.setTitle(Login.noAccountString, for: .normal)
        self.loginView.emailTextField.attributedPlaceholder = NSAttributedString(string: Login.emailString, attributes: [NSForegroundColorAttributeName: Color.lightBlue])
        self.loginView.passwordTextField.attributedPlaceholder = NSAttributedString(string: Login.passwordString, attributes: [NSForegroundColorAttributeName: Color.lightBlue])
        self.loginView.forgotPasswordButton.isHidden = false
        self.loginView.loginButton.setTitle(Login.loginString, for: .normal)
        self.loginView.loginButton.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        self.loginView.socialLoginView.isHidden = false
        self.loginView.termsAndPolicyButton.isHidden = true
        self.isUserWantSignUp = true
    }
    
    func setLoginState() {
        self.loginView.signUpButton.setTitle(Login.alreadyHaveAccountString, for: .normal)
        self.loginView.forgotPasswordButton.isHidden = true
        self.loginView.loginButton.setTitle(Login.signUpString, for: .normal)
        self.loginView.loginButton.addTarget(self, action: #selector(self.nextSignUpAction), for: .touchUpInside)
        self.isUserWantSignUp = false
        self.loginView.socialLoginView.isHidden = false
        self.loginView.termsAndPolicyButton.isHidden = false
    }
    
    func setFinishSignUpState() {
        self.hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if !(self.signUpView != nil) {
            self.signUpView = SignUpView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
            self.signUpView.addGestureRecognizer(self.tapGestureRecognizer)
            let chooseAvatarGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage))
            self.signUpView.youPhotoImageView.addGestureRecognizer(chooseAvatarGestureRecognizer)
            self.signUpView.backButton.addTarget(self, action: #selector(self.backToLoginAction), for: .touchUpInside)
        }
        self.loginView.isHidden = true
        self.signUpView.isHidden = false
        self.view.addSubview(self.signUpView)
    }
    
    //MARK: Initializers
    
    func initLoginView() {
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.loginView = LoginView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        self.loginView.addGestureRecognizer(self.tapGestureRecognizer)
        self.view.addSubview(self.loginView)
        self.loginView.loginButton.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        self.loginView.socialLoginView.facebookButton.addTarget(self, action: #selector(self.loginWithFacebookAction), for: .touchUpInside)
        self.loginView.socialLoginView.googleButton.addTarget(self, action: #selector(self.loginWithGoogleAction), for: .touchUpInside)
        self.loginView.signUpButton.addTarget(self, action: #selector(self.startSignUpAction), for: .touchUpInside)
        self.loginView.forgotPasswordButton.addTarget(self, action: #selector(self.forgotPasswordAction), for: .touchUpInside)
    }
    
    func initImagePicker() {
        self.imagePicker.delegate = self
    }
    
    //MARK: Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: Keyboard Behavior Handling

extension LoginViewController {
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

//MARK: UIImagePicker Delegate

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func chooseImage() {
        let alert = UIAlertController(title: Login.chooseImageString, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Login.cameraString, style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: Login.galleryString, style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: Login.cancelString, style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.signUpView.youPhotoImageView.contentMode = .scaleAspectFill
            self.signUpView.youPhotoImageView.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

