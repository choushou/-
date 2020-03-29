//
//  MenuDetailHeaderView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/29.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

enum DetailPointType {
    case body
    case smoky
    case woody
    case floral
    case fruity
    case winey
}

class DetailWineKind: NSObject {
    var body: Float = 0.0
    var smoky: Float = 0.0
    var woody: Float = 0.0
    var floral: Float = 0.0
    var fruity: Float = 0.0
    var windy: Float = 0.0
}

class MenuDetailHeaderView: UIView {
    
    
    var detailPointType: DetailPointType!
    var detailWineKind: DetailWineKind = DetailWineKind()
    
    var radarView: RadarView!
    var radarViewTwo: RadarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailWineKind.body = 0.5
        detailWineKind.smoky = 0.75
        detailWineKind.woody = 0.25
        detailWineKind.floral = 0.5
        detailWineKind.fruity = 0.25
        detailWineKind.windy = 0.75
        
        initSubviews()
    }
    
    func initSubviews() {
        
        
        radarView = RadarView(frame: CGRect(x: SCREEN_WIDTH - 280, y: 290, width: 220, height: 220))
        //        radarView = RadarView()
        //        radarView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        radarView.setLineColor(color: UIColor.init(red: 136 / 255, green: 136 / 255, blue: 136 / 255, alpha: 1))
        radarView.setTextColor(color: UIColor.init(red: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1))
        
        radarView.setLineWidth(width: 0.5)
        
        //        radarView.setDotRadius(radius: 3)
        //        radarView.setDrawAreaColor(color: UIColor.init(red: 113 / 255, green: 113 / 255, blue: 113 / 255, alpha: 0.6))
        //        radarView.setDotColor(color: UIColor.init(red: 143 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1))
        
        radarView.setDrawAreaColorTwo(color: UIColor.init(red: 202 / 255, green: 148 / 255, blue: 195 / 255, alpha: 0.8))
        radarView.setDotRadiusTwo(radiusTwo: 3)
        radarView.setDotColorTwo(colorTwo: UIColor.init(red: 237 / 255, green: 94 / 255, blue: 219 / 255, alpha: 1))
        
        // radarView.setData(data: [RadarModel(title: "Woody", percent: 0.75), RadarModel(title: "Smoky", percent: 0.25), RadarModel(title: "Body", percent: 0.75), RadarModel(title: "Winey", percent: 0.25), RadarModel(title: "Fruity", percent: 0.75), RadarModel(title: "Floral", percent: 0.75)])
        
        
        radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(detailWineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(detailWineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(detailWineKind.body)), RadarModel(title: "Winey", percent: CGFloat(detailWineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(detailWineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(detailWineKind.floral))])
        
        self.addSubview(radarView)
    }
    
}
