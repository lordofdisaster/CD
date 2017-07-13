//
//  ViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 4/18/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import MBProgressHUD
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {
    
    var loginView: LoginView!
    var signUpView: SignUpView!
    var isUserWantSignUp = true
    var showSignUpScreen = false
    var tapGestureRecognizer: UITapGestureRecognizer!
    let imagePicker = UIImagePickerController()
   
    //MARK:- Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLoginView()
        self.initImagePicker()
        if showSignUpScreen {
            self.startSignUpAction()
        }
    }
    
    //MARK:- Actions
    
    func loginAction() {
        self.view.endEditing(true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AlamofireManager.loginWith(username: self.loginView.emailTextField.text!, password: self.loginView.passwordTextField.text!) { success, error in
            MBProgressHUD.hide(for: self.view, animated: true)
            if success {
                self.performSegue(withIdentifier: "openMyCarsListSegue", sender: self)
            } else {
                CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
            }
        }
    }
    
    func loginWithFacebookAction() {
        let loginManager = LoginManager()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        loginManager.logIn([.publicProfile, .email, .custom("user_birthday")], viewController: self) { loginResult in
            MBProgressHUD.hide(for: self.view, animated: true)
            switch loginResult {
            case .failed(let error):
                CardeeAlert.showAlert(withTitle: "Error", message: error as! String, sender: self)
                break
            case .cancelled:
                CardeeAlert.showAlert(withTitle: "Error", message: "You cancelled login", sender: self)
                break
            case .success(_, _, let accessToken):
                AlamofireManager.loginWithSocial(type: .facebook, token: accessToken.authenticationToken, expirationDate: accessToken.expirationDate) { success, error in
                    if success {
                        self.performSegue(withIdentifier: "openCarListSegue", sender: self)
                    } else {
                        CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                    }
                }
            }
        }
    }
    
    func loginWithGoogleAction() {
        print("Login G+")
        self.performSegue(withIdentifier: "openCarListSegue", sender: self)
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
        self.view.endEditing(true)
        if !(self.signUpView.yourNameTextField.text?.isEmpty)! {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            AlamofireManager.signUpWith(username: self.loginView.emailTextField.text!, password: self.loginView.passwordTextField.text!, name: self.signUpView.yourNameTextField.text!, picture: self.signUpView.youPhotoImageView.image) { success, error in
                MBProgressHUD.hide(for: self.view, animated: true)
                if success {
                    self.performSegue(withIdentifier: "openCarListSegue", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        } else {
            CardeeAlert.showAlert(withTitle: "Error", message: "Please enter your name", sender: self)
        }
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
    
    //MARK:- States
    
    func setSignUpState() {
        self.loginView.signUpButton.setTitle(Login.noAccountString, for: .normal)
        self.loginView.emailTextField.attributedPlaceholder = NSAttributedString(string: Login.emailString, attributes: [NSForegroundColorAttributeName: Color.lightBlue])
        self.loginView.passwordTextField.attributedPlaceholder = NSAttributedString(string: Login.passwordString, attributes: [NSForegroundColorAttributeName: Color.lightBlue])
        self.loginView.forgotPasswordButton.isHidden = false
        self.loginView.loginButton.setTitle(Login.loginString, for: .normal)
        self.loginView.loginButton.removeTarget(nil, action: nil, for: .allEvents)
        self.loginView.loginButton.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        
        
        
        
        
        
        self.loginView.socialLoginView.isHidden = false
        self.loginView.termsAndPolicyButton.isHidden = true
        self.isUserWantSignUp = true
    }
    
    func setLoginState() {
        self.loginView.signUpButton.setTitle(Login.alreadyHaveAccountString, for: .normal)
        self.loginView.forgotPasswordButton.isHidden = true
        self.loginView.loginButton.setTitle(Login.signUpString, for: .normal)
        self.loginView.loginButton.removeTarget(nil, action: nil, for: .allEvents)
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
            self.signUpView.getStartedButton.addTarget(self, action: #selector(self.signUpAction), for: .touchUpInside)
            self.signUpView.backButton.addTarget(self, action: #selector(self.backToLoginAction), for: .touchUpInside)
        }
        self.loginView.isHidden = true
        self.signUpView.isHidden = false
        self.view.addSubview(self.signUpView)
    }
    
    //MARK:- Initializers
    
    func initLoginView() {
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.loginView = LoginView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height))
        //Test
        
        self.loginView.passwordTextField.isSecureTextEntry = true
        self.loginView.emailTextField.text = "alex"
        self.loginView.passwordTextField.text = "12345"
        //
        self.loginView.addGestureRecognizer(self.tapGestureRecognizer)
        self.view.addSubview(self.loginView)
        self.loginView.loginButton.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        
        if let fbButton = self.loginView.socialLoginView.facebookButton {
        
            fbButton.addTarget(self, action: #selector(self.loginWithFacebookAction), for: .touchUpInside)
            
            fbButton.setImage(UIImage(named:"facebook"), for: .normal)
            fbButton.imageEdgeInsets = UIEdgeInsets(top: 15.0, left: -30.0, bottom: 15.0, right: 0.0)
            fbButton.imageView?.contentMode = .scaleAspectFit
            fbButton.tintColor = .white
            
        }
        
        
        
        
        if let gButton = self.loginView.socialLoginView.googleButton {
        
            gButton.addTarget(self, action: #selector(self.loginWithGoogleAction), for: .touchUpInside)
            gButton.setImage(UIImage(named:"googleplus"), for: .normal)
            
            gButton.imageEdgeInsets = UIEdgeInsets(top: 15.0, left: -30.0, bottom: 15.0, right: 0.0)
            gButton.imageView?.contentMode = .scaleAspectFit
            gButton.tintColor = .white
            
        }
        
        
        
        
        
        self.loginView.signUpButton.addTarget(self, action: #selector(self.startSignUpAction), for: .touchUpInside)
        self.loginView.forgotPasswordButton.addTarget(self, action: #selector(self.forgotPasswordAction), for: .touchUpInside)
    }
    
    func initImagePicker() {
        self.imagePicker.delegate = self
    }
    
    //MARK:- Memory Warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:- Keyboard Behavior Handling

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

//MARK:- UIImagePicker Delegate

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

