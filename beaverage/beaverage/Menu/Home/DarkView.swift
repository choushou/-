//
//  DarkView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class DarkView: UIView {

    @IBOutlet weak var showScanCodeBtn: UIButton!
    @IBAction func showMenu(_ sender: Any) {
        self.removeFromSuperview()
    }
//
//    @IBAction func showScanCode(_ sender: Any) {
//
//       let scanCodeController = ScanCodeController()
//
//    }
    
}
