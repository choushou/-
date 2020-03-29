//
//  SKButton.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/28.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class SKButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        clipsToBounds = true
        setTitleColor(UIColor.black, for: .normal)
        //setTitleColor(UIColor.init(rgb: 0x555555), for: .highlighted)
        //           backgroundColor =  UIColor(red: 181/255, green: 21/255, blue: 8/255, alpha: 1)
        
        backgroundColor = UIColor.red
        
        //           setBackgroundColor(color: UIColor.init(rgb: 0xbe4e46), forState: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //       required init?(coder aDecoder: NSCoder) {
    //           fatalError("init(coder:) has not been implemented")
    //       }
    
}
