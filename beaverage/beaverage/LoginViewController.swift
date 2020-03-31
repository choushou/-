//
//  LoginViewController.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/21.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController,UITextFieldDelegate {
    let URL_KEY = "http://ec2-52-193-104-190.ap-northeast-1.compute.amazonaws.com/api/signin?login_id=shop1&password=test1234"
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var shopIdentifierTextField: UITextField!
    
    @IBOutlet weak var identifierTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestSigninKey(url: URL_KEY)
        
        
        errorLabel.isHidden = true
        
        if (shopIdentifierTextField.text == "" || shopIdentifierTextField == nil)
            || (identifierTextField.text == "" || identifierTextField == nil)
            || (passwordTextField.text == "" || passwordTextField == nil) {
            loginButton.backgroundColor = UIColor.lightGray
            loginButton.isEnabled = false
        } else {
            loginButton.backgroundColor = UIColor.white
            loginButton.isEnabled = true
        }
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 5
        shopIdentifierTextField.delegate = self
        identifierTextField.delegate = self
        passwordTextField.delegate = self
        
        shopIdentifierTextField.isSecureTextEntry = true
        identifierTextField.isSecureTextEntry = true
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
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       textFieldTextCheck()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldTextCheck()
        return false
    }
    //入力状態のチェック
    func textFieldTextCheck() {
        if (shopIdentifierTextField.text != "" && shopIdentifierTextField != nil)
                 && (identifierTextField.text != "" && identifierTextField != nil)
                 && (passwordTextField.text != "" && passwordTextField != nil) {
                 loginButton.backgroundColor = UIColor.white
                 loginButton.isEnabled = true
             } else {
                 loginButton.backgroundColor = UIColor.lightGray
                 loginButton.isEnabled = false
             }
    }
    
    //signinのkeyをリクエスト
    func requestSigninKey(url: String) {
        
        Alamofire.request(url, method: .post).responseJSON {
            response in
            if response.result.isSuccess {
                
                let apiKeyJSON : JSON = JSON(response.result.value!)
                
                let key = apiKeyJSON["api_key"].stringValue
                print(key)
                // let key="2C1f7DC76dsjcIqo6671"
                
                let requestURL = "http://ec2-52-193-104-190.ap-northeast-1.compute.amazonaws.com/api/whiskies/1?api_key=\(key)"
                self.requestSigninData(url: requestURL)
                
            }
            else {
                print(response)
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    
    //signinのurlをリクエスト
    func requestSigninData(url: String) {
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: configHeaders()).responseJSON {
            response in
            if response.result.isSuccess {
                
                let signinJSON : JSON = JSON(response.result.value!)
                
                print(signinJSON)
                
            }
            else {
                print(response)
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    
    func configHeaders() -> HTTPHeaders {
        
        let headers:HTTPHeaders = ["Content-type":"application/json;charset=utf-8",
                                   "Accept":"application/json",
                                   "systemtype":"ios"]
        
        return headers
    }
    
    
}
