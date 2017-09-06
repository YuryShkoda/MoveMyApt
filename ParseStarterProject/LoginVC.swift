//
//  LoginVC.swift
//  MoveMyStuff
//
//  Created by Yury on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

//TODO: add phone number at sign up

import UIKit
import Parse

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var isLogin    = true
    var isCustomer = true

    @IBOutlet weak var userType: UISegmentedControl!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var loginSignupButton: UIButton!
    @IBOutlet weak var loginSignupSwitcher: UIButton!
    @IBOutlet weak var phone: UITextField!
    
    @IBAction func userTypeSwitched(_ sender: Any) {
        if isCustomer { isCustomer = false } else { isCustomer = true }
    }
    
    @IBAction func loginSignupButtonClicked(_ sender: Any) {
        
        var readyForSegue = true
        var pass = ""
        for subView in self.view.subviews as [UIView] {
            if let stackView = subView as? UIStackView {
                for textField in stackView.subviews as! [UITextField] {
                    if textField.text == "" && textField.alpha != 0 {
                        textField.layer.borderWidth = 1
                        readyForSegue = false
                    } else if textField.isSecureTextEntry && textField.alpha != 0 {
                        if pass == "" {
                            pass = password.text!
                        } else if pass != password2.text! {
                            alertLabel.text = "Passwords are not equel!"
                            alertLabel.isHidden = false
                            readyForSegue = false
                        }
                    }
                }
            }
        }
        
        if readyForSegue {
            
            if readyForSegue {
                if isLogin {
                    
                    PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: { (user, error) in
                        
                        if error != nil {
                            
                            var errorMessage = "Login failed - please try again"
                            let error = error as NSError?
                            
                            if let parseError = error?.userInfo["error"] as? String {
                                errorMessage = parseError
                            }
                            self.alertLabel.text = errorMessage
                        } else {
                            if let userType = user?.object(forKey: "UserType") as? String {
                                
                                if self.isCustomer && userType == "Customer" {
                                    
                                    let customer   = Customer.sharedInstance
                                    customer.id    = user?.objectId
                                    customer.email = self.email.text!
                                    customer.name  = self.name.text!
                                    
                                    self.performSegue(withIdentifier: "toCustomerMainViewSegue", sender: nil)
                                } else if !self.isCustomer && userType == "Mover" {
                                    
                                    let mover      = Mover.sharedInstance
                                    mover.email    = self.email.text!
                                    mover.id       = user?.objectId
                                    mover.isActive = user?.object(forKey: "isActive") as? Bool
                                    mover.name     = user?.object(forKey: "Name") as? String
                                    
                                    self.performSegue(withIdentifier: "toMoverMainViewSegue", sender: nil)
                                } else {
                                    self.alertLabel.text     = "Wrong user type!"
                                    self.alertLabel.isHidden = false
                                }
                            }
                        }
                    })
                } else {
                    
                    let user = PFUser()
                    user.username = email.text!
                    user.password = password.text!
                    
//                    let acl = PFACL()
//                    acl.getPublicReadAccess = true
//                    acl.getPublicWriteAccess = true
                    
//                    user.acl = acl
                    
                    user.signUpInBackground(block: { (success, error) in
                        
                        if error != nil {
                            
                            var errorMessage = "Signup failed - please try again"
                            let error = error as NSError?
                            
                            if let parseError = error?.userInfo["error"] as? String {
                                errorMessage = parseError
                            }
                            self.alertLabel.text = errorMessage
                        } else {
                            if self.isCustomer {
                                
                                PFUser.current()?["Name"]     = self.name.text!
                                PFUser.current()?["Phone"]    = self.phone.text!
                                PFUser.current()?["UserType"] = "Customer"
                                PFUser.current()?.saveInBackground(block: { (success, error) in
                                    
                                    if error != nil {
                                        
                                        var errorMessage = "Signup failed - please try again"
                                        let error = error as NSError?
                                        
                                        if let parseError = error?.userInfo["error"] as? String {
                                            errorMessage = parseError
                                        }
                                        self.alertLabel.text = errorMessage
                                        
                                    } else {
                                        self.performSegue(withIdentifier: "toCustomerMainViewSegue", sender: nil)
                                    }
                                })
                            } else {
                                
                                PFUser.current()?["Name"]     = self.name.text!
                                PFUser.current()?["Phone"]    = self.phone.text!
                                PFUser.current()?["UserType"] = "Mover"
                                PFUser.current()?["isActive"] = false
                                PFUser.current()?.saveInBackground(block: { (success, error) in
                                    
                                    if error != nil {
                                        
                                        var errorMessage = "Signup failed - please try again"
                                        let error = error as NSError?
                                        
                                        if let parseError = error?.userInfo["error"] as? String {
                                            errorMessage = parseError
                                        }
                                        self.alertLabel.text = errorMessage
                                        
                                    } else {
                                        self.performSegue(withIdentifier: "toMoverMainViewSegue", sender: nil)
                                    }
                                })
                            }
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func loginSignupSwitcherClicked(_ sender: Any) {
        
        alertLabel.isHidden = true
        
        for subView in self.view.subviews as [UIView] {
            if let stackView = subView as? UIStackView {
                for textField in stackView.subviews as! [UITextField] {
                    textField.layer.borderWidth = 0
                    textField.delegate = self
                }
            }
        }
        
        if isLogin {
            loginSignupButton.setTitle("Sign up", for: .normal)
            loginSignupSwitcher.setTitle("or login", for: .normal)
            isLogin         = false
            name.alpha      = 1
            phone.alpha     = 1
            password2.alpha = 1
        } else {
            loginSignupButton.setTitle("Login", for: .normal)
            loginSignupSwitcher.setTitle("or sign up", for: .normal)
            isLogin         = true
            name.alpha      = 0
            phone.alpha     = 0
            password2.alpha = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subView in self.view.subviews as [UIView] {
            if let stackView = subView as? UIStackView {
                for textField in stackView.subviews as! [UITextField] {
                    textField.layer.borderColor = UIColor.red.cgColor
                    textField.delegate = self
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
