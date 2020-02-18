//
//  RadarModel.swift
//  IOSRadarView
//
//  Created by 張璋 on 2020/02/17.
//  Copyright © 2020 張璋. All rights reserved.
//

import UIKit

class RadarModel: NSObject {

    var title: String!
    var percent: CGFloat!
    
    init(title: String, percent: CGFloat) {
        super.init()
        self.title = title
        self.percent = percent
    }
}
