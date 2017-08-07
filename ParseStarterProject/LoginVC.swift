//
//  LoginVC.swift
//  moveMyApt
//
//  Created by Yury on 8/6/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    var isLogin = true
    var isCustomer = true

    @IBOutlet weak var userType: UISegmentedControl!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var loginSignupButton: UIButton!
    @IBOutlet weak var loginSignupSwitcher: UIButton!
    
    @IBAction func userTypeSwitched(_ sender: Any) {
        isCustomer = false
    }
    
    @IBAction func loginSignupButtonClicked(_ sender: Any) {
        
        var readyForSegue = true
        var pass = ""
        for subView in self.view.subviews as [UIView] {
            if let stackView = subView as? UIStackView {
                for textField in stackView.subviews as! [UITextField] {
                    if textField.text == "" && textField.alpha != 0 {
                        textField.layer.borderWidth = 1
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
            isLogin = false
            password2.alpha = 1
        } else {
            loginSignupButton.setTitle("Login", for: .normal)
            loginSignupSwitcher.setTitle("or sign up", for: .normal)
            isLogin = true
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
