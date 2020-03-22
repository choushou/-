//
//  HomeHeadView.swift
//  SwiftApp
//
//  Created by leeson on 2018/7/25.
//  Copyright © 2018年 李斯芃 ---> 512523045@qq.com. All rights reserved.
//

import UIKit
import ZHDropDownMenu

class HomeHeadView: UIView{
    
//     //选择完后回调
//    func dropDownMenu(_ menu: ZHDropDownMenu, didSelect index: Int) {
//        print("\(menu) choosed at index \(index)")
//    }
//
//    //编辑完成后回调
//    func dropDownMenu(_ menu: ZHDropDownMenu, didEdit text: String) {
//        print("\(menu) input text \(text)")
//    }
    
    typealias SwitchBtBlock = (_ click: Bool) -> Void
    
    @IBOutlet weak var sortMenu: ZHDropDownMenu!
    
    
    
 
    
    //    ///头像
//    @IBOutlet weak var headImg: UIImageView!
//    ///用户名
//    @IBOutlet weak var userName: UILabel!
//    ///性别
//    @IBOutlet weak var sexIcon: UIImageView!
//    ///关注
//    @IBOutlet weak var focus: UILabel!
//    ///粉丝
//    @IBOutlet weak var fans: UILabel!
//    ///文章
//    @IBOutlet weak var article: UILabel!
//    ///字数
//    @IBOutlet weak var number: UILabel!
//    ///收获喜欢
//    @IBOutlet weak var totalLike: UILabel!
//    ///个人介绍
//    @IBOutlet weak var introduce: UILabel!
    
    var switchBack: SwitchBtBlock?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var  isShow:Bool?{
            
            willSet{
                   print(isShow)
                   
               }
               //属性已经改变时进行监听
               didSet{
                   print(isShow)
                  
       
        }
        }
//        if (sortMenu.isShown) {
//            print("444")
//        } else {
//            print("555")
//        }
        // Initialization code
//
//        sortMenu.options = ["2","1","3","4"]
//               sortMenu.menuHeight = 250
//                sortMenu.delegate = self
               
        
//        sortMenu.options = ["1","2","3","4"]
//        sortMenu.menuHeight = 250
//        sortMenu.delegate = self
        
//        self.userName.font = UIFont(name: "DINPro-Regular", size: 10)
//        self.focus.font = UIFont(name: "DINPro-Regular", size: 10)
//        self.fans.font = self.focus.font;
//        self.article.font = self.focus.font;
//        self.number.font = self.focus.font;
//        self.totalLike.font = self.focus.font;
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
