//
//  TestSanJiao.swift
//  popOver
//
//  Created by 張　璋 on 2020/03/03.
//  Copyright © 2020 rara. All rights reserved.
//

import UIKit



class TestSanJiao:UIView {
  // Inspectorで点線の色と幅を設定出来るようにする
var dotColor: UIColor = UIColor.gray
 var lineWidth: CGFloat = 2.0

    override func draw(_ rect: CGRect) {
           let path = UIBezierPath()

           path.lineWidth = self.lineWidth

           // 他にround, squareを設定出来る
           path.lineCapStyle = .butt

           // 起点
        path.move(to: CGPoint(x: rect.midX, y: 0))
           // 帰着点
        path.addLine(to: CGPoint(x: rect.midX, y: rect.width))

           let dashes = [path.lineWidth, path.lineWidth]

           // 第一引数 点線の大きさ, 点線間の間隔
           // 第二引数 第一引数で指定した配列の要素数
           // 第三引数 開始位置
           path.setLineDash(dashes, count: dashes.count, phase: 0)

           // 点線の色設定
           dotColor.setStroke()

           // 点線の描画
           path.stroke()
       }
    
//    override func draw(_ rect: CGRect) {
//        let path = UIBezierPath()
//
//        path.lineWidth = self.lineWidth
//
//        // 他にround, squareを設定出来る
//        path.lineCapStyle = .butt
//
//        // 起点
//        path.move(to: CGPoint(x: 0, y: rect.midY))
//        // 帰着点
//        path.addLine(to: CGPoint(x: rect.width, y: rect.midY))
//
//        let dashes = [path.lineWidth, path.lineWidth]
//
//        // 第一引数 点線の大きさ, 点線間の間隔
//        // 第二引数 第一引数で指定した配列の要素数
//        // 第三引数 開始位置
//        path.setLineDash(dashes, count: dashes.count, phase: 0)
//
//        // 点線の色設定
//        dotColor.setStroke()
//
//        // 点線の描画
//        path.stroke()
//    }
    
    }
