//
//  HomeHeadView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit


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

class HomeHeadView: UIView{
    
    
    @IBOutlet weak var hexagonView: UIView!
    
    var pointType: PointType!
    var wineKind: WineKind = WineKind()
    
    var buttonCallBack:(() -> ())?
    var radarView: RadarView!
    
    @IBAction func searchCondition(_ sender: Any) {
        
        buttonCllick(button: sender as! UIButton)
    }
    
    func buttonCllick(button: UIButton){
        if buttonCallBack != nil {
            buttonCallBack!()
        }
    }
    

    //    @IBOutlet weak var headImg: UIImageView!

    //    @IBOutlet weak var userName: UILabel!

    //    @IBOutlet weak var sexIcon: UIImageView!

    //    @IBOutlet weak var focus: UILabel!

    //    @IBOutlet weak var fans: UILabel!

    //    @IBOutlet weak var article: UILabel!

    //    @IBOutlet weak var number: UILabel!

    //    @IBOutlet weak var totalLike: UILabel!

    //    @IBOutlet weak var introduce: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wineKind.body = 0.5
        wineKind.smoky = 0.75
        wineKind.woody = 0.25
        wineKind.floral = 0.5
        wineKind.fruity = 0.25
        wineKind.windy = 0.75
        
        initSubviews()
        
        //        self.userName.font = UIFont(name: "DINPro-Regular", size: 10)
        //        self.focus.font = UIFont(name: "DINPro-Regular", size: 10)
        //        self.fans.font = self.focus.font;
        //        self.article.font = self.focus.font;
        //        self.number.font = self.focus.font;
        //        self.totalLike.font = self.focus.font;
    }
    
    func initSubviews() {
        
        
        radarView = RadarView(frame: CGRect(x: SCREEN_WIDTH - 280, y: 240, width: 220, height: 220))
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
        
        radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
        
        self.addSubview(radarView)
    }
    
    func setHearderInfo(_ headInfo: Yuanzu) {
        
        //        let headImgArr = headInfo.headImge.components(separatedBy: "?")
        ////        self.headImg.sd_setImage(with: URL.init(string: String(format: "https:%@", headImgArr[0])), placeholderImage: UIImage.init(named: "headImg"))
        //        self.userName.text = headInfo.name
        //        if headInfo.sex == "woman" {
        //            self.sexIcon.image = UIImage(named: "sex_w")
        //        }else if (headInfo.sex == "man") {
        //            self.sexIcon.image = UIImage(named: "sex_m")
        //        }else {
        //            self.sexIcon.isHidden = true
        //        }
        //        self.focus.text = headInfo.infoList[0]
        //        self.fans.text = headInfo.infoList[1]
        //        self.article.text = headInfo.infoList[2]
        //        self.number.text = headInfo.infoList[3]
        //        self.totalLike.text = headInfo.infoList[4]
        //        self.introduce.text = headInfo.intro
    }
    
    //切换布局按钮
    //    @IBAction func switchBtClick(_ sender: UIButton) {
    //        sender.isSelected = !sender.isSelected
    //        self.switchBack!(sender.isSelected)
    //    }
    
}
