//
//  LoginViewController.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/21.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var shopIdentifierTextField: UITextField!
    
    @IBOutlet weak var identifierTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        shopIdentifierTextField.delegate = self
        identifierTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
    }
 
    @IBAction func loginAction(_ sender: Any) {
         
        shopIdentifierTextField.resignFirstResponder()
        identifierTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
     }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
          
       }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        return false
     }
    
}
