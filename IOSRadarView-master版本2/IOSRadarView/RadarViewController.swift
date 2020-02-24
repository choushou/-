//
//  RadarViewController.swift
//  IOSRadarView
//
//  Created by 張璋 on 2020/02/17.
//  Copyright © 2020 張璋. All rights reserved.
//

import UIKit
import AudioToolbox

enum PointType {
    case body
    case smoky
    case woody
    case floral
    case fruity
    case winey
}

class WineKind: NSObject {
    var body: Float = 0.0
    var smoky: Float = 0.0
    var woody: Float = 0.0
    var floral: Float = 0.0
    var fruity: Float = 0.0
    var windy: Float = 0.0
}

class RadarViewController: UIViewController {
    
    var radarView: RadarView!
    var radarViewTwo: RadarView!
    var pointType: PointType!
    var wineKind: WineKind = WineKind()
    var beginPoint = CGPoint()
    var endPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wineKind.body = 0.5
        wineKind.smoky = 0.75
        wineKind.woody = 0.25
        wineKind.floral = 0.5
        wineKind.fruity = 0.25
        wineKind.windy = 0.75
        
        initSubviews()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            let point = (touch as AnyObject).location(in: self.radarView)
            
            let clickWidth = 6
            let difWidth = point.x - radarView.centerX
            let difHeight = point.y - radarView.centerY
            
            radarView.setRadiusScaleWidth(radiusScaleWidth: 1)
            radarView.setRadiusScaleHeight(radiusScaleHeight: 1)
            
            for pointSix: CGPoint in radarView.arraySixPoint {
                
                let pointSixWidthHeight = (pointSix.x - radarView.centerX) / (pointSix.y - radarView.centerY)
                let pointWidthHeight = (point.x - radarView.centerX) / (point.y - radarView.centerY)
                
                //タップする範囲は糸のところであるかどうかを判断する
                if (pointSixWidthHeight - pointWidthHeight > -0.2) && (pointSixWidthHeight - pointWidthHeight < 0.2)  {
                    //print("535353535353")
                    
                    //Woody
                    if (Int(difWidth) > clickWidth) && (difHeight > 0) {
                        //两点之间的距离
                        let p1 = (x:point.x,y:point.y)
                        let p2 = (x:radarView.centerX,y:radarView.centerY)
                        let distance = sqrt(pow((p1.x - (p2.x!)), 2) + pow((p1.y - (p2.y!)), 2))

                        //顶点到中心的距离
                        let p3 = (x:pointSix.x,y:pointSix.y)
                        let distanceAll = sqrt(pow((p3.x - (p2.x!)), 2) + pow((p3.y - (p2.y!)), 2))
                        
                        if (distanceAll >= distance) {
                            print("click dian zhong")
                            
                            //计算所在的比例位置
                            print(distance / (distanceAll))
                            let scalePosition = distance / (distanceAll)
                            let percent = getPercentData(percent: scalePosition)
                            wineKind.woody = Float(percent)
                            
                            radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: percent), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
                            
                            var soundID:SystemSoundID = 1157
                            AudioServicesPlayAlertSound(soundID)
                        }
                        //    }
                        
                    } else if (Int(difWidth) > clickWidth) && (difHeight < 0) {
                        //Smoky
                        
                        //两点之间的距离
                        let p1 = (x:point.x,y:point.y)
                        let p2 = (x:radarView.centerX,y:radarView.centerY)
                        let distance = sqrt(pow((p1.x - (p2.x!)), 2) + pow((p1.y - (p2.y!)), 2))
                        //  if ((distance / 2 - difHeight) > -3) && ((distance / 2 - difHeight) < 3) {
                        
                        //顶点到中心的距离
                        let p3 = (x:pointSix.x,y:pointSix.y)
                        let distanceAll = sqrt(pow((p3.x - (p2.x!)), 2) + pow((p3.y - (p2.y!)), 2))
                        
                        if (distanceAll >= distance) {
                            print("click dian zhong")
                            
                            //计算所在的比例位置
                            print(distance / distanceAll)
                            let scalePosition = distance / distanceAll
                            let percent = getPercentData(percent: scalePosition)
                            wineKind.smoky = Float(percent)
                            
                            radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: percent), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
                            var soundID:SystemSoundID = 1157
                            AudioServicesPlayAlertSound(soundID)
                        }
                   
                    } else if (Int(difWidth) > -clickWidth && Int(difWidth) < clickWidth) && (point.y < radarView.centerY){
                       
                        //Body
                        //顶点到中心的距离
                        let p3 = (x:pointSix.x,y:pointSix.y)
                        let p2 = (x:radarView.centerX,y:radarView.centerY)
                        let distanceAll = sqrt(pow((p3.x - (p2.x!)), 2) + pow((p3.y - (p2.y!)), 2))
                        //两点之间的距离
                        let difHeight = radarView.centerY - point.y
                        if difHeight > 0 && difHeight <= distanceAll {
                            let scalePosition = difHeight / distanceAll
                            let percent = getPercentData(percent: scalePosition)
                            
                            wineKind.body = Float(percent)
                            
                            radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: percent), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
                            var soundID:SystemSoundID = 1157
                            AudioServicesPlayAlertSound(soundID)
                        }
                        
                    } else if (Int(difWidth) > -clickWidth && Int(difWidth) < clickWidth) && (point.y > radarView.centerY) {
                        
                        //Floral
                        //顶点到中心的距离
                        let p3 = (x:pointSix.x,y:pointSix.y)
                        let p2 = (x:radarView.centerX,y:radarView.centerY)
                        let distanceAll = sqrt(pow((p3.x - (p2.x!)), 2) + pow((p3.y - (p2.y!)), 2))
                        //两点之间的距离
                        let difHeight = point.y - radarView.centerY
                        if difHeight > 0 && difHeight <= distanceAll {
                            let scalePosition = difHeight / distanceAll
                            let percent = getPercentData(percent: scalePosition)
                            
                            wineKind.floral = Float(percent)
                            
                            radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: percent)])
                            
                            var soundID:SystemSoundID = 1157
                            AudioServicesPlayAlertSound(soundID)
                        }
                        
                    } else if (Int(difWidth) < -clickWidth) && (point.y > radarView.centerY) {
                       
                        //Fruity
                        
                        //两点之间的距离
                        let p1 = (x:point.x,y:point.y)
                        let p2 = (x:radarView.centerX,y:radarView.centerY)
                        let distance = sqrt(pow((p1.x - (p2.x!)), 2) + pow((p1.y - (p2.y!)), 2))
                       
                        //顶点到中心的距离
                        let p3 = (x:pointSix.x,y:pointSix.y)
                        let distanceAll = sqrt(pow((p3.x - (p2.x!)), 2) + pow((p3.y - (p2.y!)), 2))
                        
                        if (distanceAll >= distance) {
                            print("click dian zhong")
                            
                            //计算所在的比例位置
                            print(distance / distanceAll)
                            let scalePosition = distance / distanceAll
                            let percent = getPercentData(percent: scalePosition)
                            
                            wineKind.fruity = Float(percent)
                            radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent:CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: percent), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
                            
                            var soundID:SystemSoundID = 1157
                            AudioServicesPlayAlertSound(soundID)
                        }
                     
                    } else if (Int(difWidth) < -clickWidth) && (point.y < radarView.centerY) {
                       
                        //Winey
                        
                        //两点之间的距离
                        let p1 = (x:point.x,y:point.y)
                        let p2 = (x:radarView.centerX,y:radarView.centerY)
                        let distance = sqrt(pow((p1.x - (p2.x!)), 2) + pow((p1.y - (p2.y!)), 2))
                       
                        //顶点到中心的距离
                        let p3 = (x:pointSix.x,y:pointSix.y)
                        let distanceAll = sqrt(pow((p3.x - (p2.x!)), 2) + pow((p3.y - (p2.y!)), 2))
                        
                        if (distanceAll >= distance) {
                            print("click dian zhong")
                            
                            //计算所在的比例位置
                            print(distance / (distanceAll))
                            let scalePosition = distance / distanceAll
                            let percent = getPercentData(percent: scalePosition)
                            wineKind.windy = Float(percent)
                            radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: percent), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
                            var soundID:SystemSoundID = 1157
                            AudioServicesPlayAlertSound(soundID)
                        }
                      
                        
                    } else {
                        //
                    }
                    
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
          for touch:AnyObject in touches{
            var point = (touch as AnyObject).location(in: self.radarView)
        
       
            
        
        endPoint = CGPoint()
              
              
              if (self.radarView.layer.contains(point)) {
                         print("9999999999999")
                  } else {
                     //タプする範囲はradarViewの以外のところ
                     print("888888888888")
                     endPoint = point
                  }
              
              let beginPoingTrue: Bool
              let pointZero = CGPoint(x: 0.0, y: 0.0)
              beginPoingTrue = beginPoint.equalTo(pointZero)
              
              if (beginPoint != nil && endPoint != nil && !beginPoingTrue && !endPoint.equalTo(pointZero)) {
                  print(beginPoint)
                  print(endPoint)
                  
                  var scaleWidth:CGFloat
                  scaleWidth = abs((endPoint.x - beginPoint.x) / 300)
                  var scaleHeight: CGFloat
                  scaleHeight = abs((endPoint.y - beginPoint.y) / 300)
                  

                  if scaleWidth > 1 {
                      scaleWidth = 1
                  }
                  if scaleHeight > 1 {
                      scaleHeight = 1
                  }
                scaleWidth = 1 - scaleWidth
                scaleHeight = 1 - scaleHeight
              
                  
                                  if scaleWidth < 0.5 {
                                      scaleWidth = 0.5
                                  }
                                  if scaleHeight < 0.5 {
                                      scaleHeight = 0.5
                                  }
                  
                  radarView.setRadiusScaleWidth(radiusScaleWidth: scaleWidth)
                  radarView.setRadiusScaleHeight(radiusScaleHeight: scaleHeight)
                  
              }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches{
        var point = (touch as AnyObject).location(in: self.radarView)
    
        beginPoint = CGPoint()
         if (self.radarView.layer.contains(point)) {
                print("666666666666666666")
         } else {
            //タプする範囲はradarViewの以外のところ
            print("7777777777777")
            beginPoint = point
            }
        }
    }
    
    
    func getPercentData(percent: CGFloat) -> CGFloat {
        var percentData: CGFloat = 0
        if (0.25/2 > percent && percent > 0) {
            percentData = 0
        } else if (0.25 + 0.25/2 > percent && percent >= 0.25/2) {
            percentData = 0.25
        } else if (0.5 + 0.25/2 > percent && percent >= 0.25 + 0.25/2) {
            percentData = 0.5
        } else if (0.75 + 0.25/2 > percent && percent >= 0.5 + 0.25/2) {
            percentData = 0.75
        } else if (1 >= percent && percent >= 0.75 + 0.25/2) {
            percentData = 1
        }
        return percentData
    }
}


// MARK: - private methods
private extension RadarViewController {
    
    func initSubviews() {
        print("initSubviews")
        
        radarView = RadarView(frame: CGRect(x: (UIScreen.main.bounds.width
            - 350) / 2, y: 50, width: 350, height: 350))
        
        radarView.setLineColor(color: UIColor.init(red: 136 / 255, green: 136 / 255, blue: 136 / 255, alpha: 1))
        radarView.setTextColor(color: UIColor.init(red: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1))
        
        radarView.setLineWidth(width: 0.5)
        radarView.setDotRadius(radius: 3)
        radarView.setDrawAreaColor(color: UIColor.init(red: 113 / 255, green: 113 / 255, blue: 113 / 255, alpha: 0.6))
        radarView.setDotColor(color: UIColor.init(red: 143 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1))
        
        radarView.setDrawAreaColorTwo(color: UIColor.init(red: 202 / 255, green: 148 / 255, blue: 195 / 255, alpha: 0.8))
        radarView.setDotRadiusTwo(radiusTwo: 3)
        radarView.setDotColorTwo(colorTwo: UIColor.init(red: 237 / 255, green: 94 / 255, blue: 219 / 255, alpha: 1))
        
        radarView.setData(data: [RadarModel(title: "Woody", percent: 0.75), RadarModel(title: "Smoky", percent: 0.25), RadarModel(title: "Body", percent: 0.75), RadarModel(title: "Winey", percent: 0.25), RadarModel(title: "Fruity", percent: 0.75), RadarModel(title: "Floral", percent: 0.75)])
        
        radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
        
        view.addSubview(radarView)
        
        //        let sixButton = UIButton()
        //        sixButton.layer.cornerRadius = 8
        //        sixButton.backgroundColor = UIColor.red
        //        sixButton.setTitle("六角形", for: .normal)
        //        sixButton.addTarget(self, action: #selector(onSixAction), for: .touchUpInside)
        //        view.addSubview(sixButton)
        //        sixButton.snp.makeConstraints { (make) in
        //            make.width.equalTo(150)
        //            make.height.equalTo(60)
        //            make.bottom.equalToSuperview().offset(-8)
        //            make.left.equalToSuperview().offset(8)
        //        }
    }
    
    //    @objc func onSixAction() {
    //        radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: 0.9), RadarModel(title: "Smoky", percent: 0.2), RadarModel(title: "Body", percent: 0.9), RadarModel(title: "Floral", percent: 0.8), RadarModel(title: "Fruity", percent: 0.6), RadarModel(title: "Floral", percent: 0.2)])
    //    }
}
