//
//  ViewController.swift
//  Sample
//
//  Created by Roy Marmelstein on 05/08/2015.
//  Copyright (c) 2015 Roy Marmelstein. All rights reserved.
//

import UIKit
import Localize_Swift

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var testLanguage: UILabel!
    var actionSheet: UIAlertController!
    
    let availableLanguages = Localize.availableLanguages()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
    }
    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Localized Text
    
    @objc func setText(){
        textLabel.text = "Hello world".localized();
	changeButton.setTitle("Change".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        resetButton.setTitle("Reset".localized(using: "ButtonTitles"), for: UIControl.State.normal)
        
        let stringText = "日本語にします"
        
        testLanguage.text = "world".localized();
    }
    
    // MARK: IBActions

    @IBAction func doChangeLanguage(_ sender: AnyObject) {
        actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertController.Style.actionSheet)
        for language in availableLanguages {
            
            /*de
            he
            ja
            en
            zh-Hant
            es
            Base
            zh-Hans
            it
            fr*/
            
            
            print(language)
                 let displayName = Localize.displayNameForLanguage(language)
            
            if (language == "en") {
                Localize.setCurrentLanguage(language)
            }

             }
        
    }

    @IBAction func doResetLanguage(_ sender: AnyObject) {
        Localize.resetCurrentLanguageToDefault()
    }
}

