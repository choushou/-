//
//  DarkView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class Tools: NSObject {
    
    ///MARK: - --- date to string
    class func DATETOSTR(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    
    ///MARK: - date to string
    class func dateToStr(dateFormat:String,date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let dateStr = formatter.string(from: date)
        return dateStr
    }
}
