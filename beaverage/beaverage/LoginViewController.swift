//
//  LoginViewController.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/21.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var shopIdentifierTextField: UITextField!
    
    @IBOutlet weak var identifierTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 5
        shopIdentifierTextField.delegate = self
        identifierTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        shopIdentifierTextField.resignFirstResponder()
        identifierTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if (self.shopIdentifierTextField.text == "111") && (self.identifierTextField.text == "111") && (self.passwordTextField.text == "111") {
            
            let homeVC = HomeVC()
                self.navigationController?.pushViewController(homeVC, animated: true)
        }
        
    
        
        //        //ログイン画面へ遷移する
        //        self.window?.rootViewController = UINavigationController.init(rootViewController: loginVC)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return false
    }
    
}
