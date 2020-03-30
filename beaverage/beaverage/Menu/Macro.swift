//
//  Macro.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit


let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


func ViewScale(num: CGFloat) -> CGFloat{
    return (SCREEN_WIDTH / 375.0 * num)
}

/** iPhoneXの判断 */
let IsiPhonX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode!.size) : false
/** iPhoneXRの判断*/
let IsiPhonXR = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode!.size) : false
/** iPhoneXSの判断*/
let IsiPhonXS = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode!.size) : false
/** iPhoneXS_MAXの判断*/
let IsiPhonXS_MAX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode!.size) : false
/** 全画面かどうか*/
let IsFullScreen = (IsiPhonX || IsiPhonXR || IsiPhonXS || IsiPhonXS_MAX) ? true : false
/** status bar height*/
let StatusBarH = IsFullScreen ? 44.0:20.0;
/** navigation bar*/
let NavBarH = IsFullScreen ? 88.0:64.0;
/** tabbar height*/
let TabBarH = IsFullScreen ? 83.0:49.0;


/** font */
func Font(font:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: font)
}


/** 16进制color */
func RGB16(value: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(value & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

/** rgb color */
func RGB_COLOR(r: Float, g: Float, b: Float) -> UIColor{
    return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: 1)
}

/** 多行文字の高さ */
func GETSTRHEIGHT(fontSize: CGFloat, width: CGFloat, words: String) -> CGFloat {
    let font = UIFont.systemFont(ofSize: fontSize)
    let rect = NSString(string: words).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    return rect.height //ceil(rect.height)
}

func ReadData(_ fileName:String, _ type:String) -> String {
    let path = Bundle.main.path(forResource: fileName, ofType: type)
    let url = URL(fileURLWithPath: path!)
    let data = try! Data(contentsOf: url)
    return String.init(data: data, encoding: .utf8)!
}



