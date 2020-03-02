//
//  ViewController.swift
//  PlayAudioDemo-System
//
//  Created by Julie on 23/11/17.
//  Copyright © 2017 ZHOU DENGFENG DEREK. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapPlayVoiceButton() {
//        var soundID:SystemSoundID = 0
//
//        let path = Bundle.main.path(forResource: "test", ofType: "caf")!
//        let url = URL(fileURLWithPath: path)
//
//        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
//        AudioServicesPlaySystemSound(soundID)
//        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, { (soundID, clientData) in
//            print("End of playing voice.")
//        }, nil)
        
        var soundID:SystemSoundID = 1157 //1057,1103,1104,1157，1309

//        let path = Bundle.main.path(forResource: "test", ofType: "caf")!
//        let url = URL(fileURLWithPath: path)
//
//        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
       // AudioServicesPlaySystemSound(soundID)
        AudioServicesPlayAlertSound(soundID)
        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, { (soundID, clientData) in
            print("End of playing voice.")
        }, nil)
        
    }
    
    @IBAction func tapPlayAlertButton() {
        var soundID:SystemSoundID = 0

        let path = Bundle.main.path(forResource: "test", ofType: "caf")!
        let url = URL(fileURLWithPath: path)
        
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlayAlertSound(soundID)
        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, { (soundID, clientData) in
            print("End of playing alert.")
        }, nil)
    }
    
    @IBAction func tapVibrateButton() {
        let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(soundID)
        AudioServicesAddSystemSoundCompletion(soundID, nil, nil, { (soundID, clientData) in
            print("End of vibrating.")
        }, nil)
    }
}

