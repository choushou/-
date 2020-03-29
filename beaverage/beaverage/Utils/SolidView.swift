//
//  SolidView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/28.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class SolidView: UIView {
    
    var dotColor: UIColor = UIColor.gray
    var lineWidth: CGFloat = 2.0
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.lineWidth = self.lineWidth
        
        // 他にround, squareを設定出来る
        path.lineCapStyle = .butt
        
        // 起点
        path.move(to: CGPoint(x: 0, y: 0))
        // 帰着点
        path.addLine(to: CGPoint(x: rect.width, y: rect.minY))
        
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
}
