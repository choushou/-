//
//  RadarView.swift
//  IOSRadarView
//
//  Created by 張璋 on 2020/02/17.
//  Copyright © 2020 張璋. All rights reserved.
//

import UIKit

class RadarView: UIView {
    // 六個の頂点
    // var pointArray = [CGPoint]()
    
    //一番外側の頂点
    var arraySixPoint = [CGPoint]()
    //1番目のデータ
    private var data: [RadarModel]!
    //2番目のデータ
    private var dataTwo: [RadarModel]!
    
    //サイト数
    private var side: Int!
    //layer
    private var shapeLayer: CAShapeLayer!
    //領域のlayer
    private var reginLayer: CAShapeLayer!
    
    private var reginLayerTwo: CAShapeLayer!
    //text layer
    private var textShapeLayer: CAShapeLayer!
    //頂点の部分
    private var dotsShapeLayer: CAShapeLayer!
    //font
    private var font: UIFont!
    //いとの色
    private var lineColor: UIColor!
    //text color
    private var titleTextColor: CGColor!
    //line width
    private var lineWidth: CGFloat!
    //area color
    private var drawAreaColor: UIColor!
    private var dotRadius: CGFloat!
    private var dotColor: UIColor!
    
    private var drawAreaColorTwo: UIColor!
    private var dotRadiusTwo: CGFloat!
    private var dotColorTwo: UIColor!
    
    private var radiusScaleWidth: CGFloat!
    private var radiusScaleHeight: CGFloat!
    //view width
    private var width: CGFloat!
    //center x y
    var centerX: CGFloat!
    var centerY: CGFloat!
    //半径
    var radius: CGFloat!
    
    //８サイトの頂点の座標
    private var nightNodeArray: [CGPoint]!
    //隙間
    private var space: CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initData(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- methods
extension RadarView {
    
    /// init data
    ///
    /// - Parameter frame: frame
    func initData(frame: CGRect) {
        width = min(frame.size.width, frame.size.height)
        centerX = frame.size.width / 2
        centerY = frame.size.height / 2
        radius = width / 2 * 0.8
        font = UIFont.systemFont(ofSize: 14)
        lineWidth = 1
        dotRadius = 5
        dotRadiusTwo = 5
        radiusScaleWidth = 1
        radiusScaleHeight = 1
        nightNodeArray = [CGPoint]()
        
        let angle: CGFloat = CGFloat(Double.pi * 2 / Double(8))
        
        for node in 0..<8 {
            let x: CGFloat = radius * sin(angle / 1 + angle * CGFloat(node)) + centerX
            let y: CGFloat = radius * cos(angle / 1 + angle * CGFloat(node)) + centerY
            nightNodeArray.append(CGPoint(x: x, y: y))
        }
        
        titleTextColor = UIColor.black.cgColor
        lineColor = UIColor.black
        
        drawAreaColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.2)
        dotColor = drawAreaColor
        
        drawAreaColorTwo = UIColor.init(red: 0, green: 1, blue: 1, alpha: 0.2)
        dotColorTwo = drawAreaColorTwo
    }
    
    /// view update
    func updateLayer() {
        //        if data.count == 0 {
        //            return
        //        }
        //path
        let path = CGMutablePath()
        //サイトとサイト間の距離
        let radiuSpace: CGFloat = radius / CGFloat((side - 1))
        //角度
        let angle: CGFloat = CGFloat(Double.pi * 2 / Double(side))
        let centerPoint = CGPoint(x: centerX, y: centerY)
        
        for ring in 0..<side - 1 {
            var currentRadius: CGFloat = CGFloat(ring) * radiuSpace
//
//            if (side == 4) {
//                currentRadius =  0
//            }
           // let currentRadius: CGFloat = CGFloat(ring) * radiuSpace
            var array = [CGPoint]()
            for node in 0..<side {
//                let x: CGFloat = (currentRadius * 0.5) * CGFloat(sin(angle + angle * CGFloat(node))) + centerX
                let x: CGFloat = (currentRadius * radiusScaleWidth) * CGFloat(sin(angle + angle * CGFloat(node))) + centerX
                let y: CGFloat = (currentRadius * radiusScaleHeight) * CGFloat(cos(angle + angle * CGFloat(node))) + centerY
                let currentPoint = CGPoint(x: x, y: y)
                array.append(currentPoint)
                arraySixPoint = array
                path.addLines(between: [currentPoint, centerPoint])
            }
            
            array.append(array[0])
           path.addLines(between: array)
        }
        
        let percentPath = CGMutablePath()
        var array = [CGPoint]()
        for node in 0..<side {
           // let x: CGFloat = (radius - radiuSpace) * 0.5 * sin(angle + angle * CGFloat(node)) * (data[node].percent) + centerX
            let x: CGFloat = (radius - radiuSpace) * radiusScaleWidth * sin(angle + angle * CGFloat(node)) * (data[node].percent) + centerX
            let y: CGFloat = (radius - radiuSpace) * radiusScaleHeight * cos(angle + angle * CGFloat(node)) * (data[node].percent) + centerY
            array.append(CGPoint(x: x, y: y))
        }
        percentPath.addLines(between: array)
        
        let percentPathTwo = CGMutablePath()
        var arrayTwo = [CGPoint]()
        for node in 0..<side {
            //let x: CGFloat = (radius - radiuSpace)  * 0.5 * sin(angle  + angle * CGFloat(node)) * dataTwo[node].percent + centerX
            let x: CGFloat = (radius - radiuSpace) * radiusScaleWidth * sin(angle  + angle * CGFloat(node)) * dataTwo[node].percent + centerX
            let y: CGFloat = (radius - radiuSpace) * radiusScaleHeight * cos(angle + angle * CGFloat(node)) * dataTwo[node].percent + centerY
            arrayTwo.append(CGPoint(x: x, y: y))
        }
        percentPathTwo.addLines(between: arrayTwo)
        
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.35)
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.backgroundColor = UIColor.clear.cgColor
            shapeLayer.path = path
            shapeLayer.lineWidth = lineWidth
            shapeLayer.strokeColor = lineColor.cgColor
            shapeLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            layer.insertSublayer(shapeLayer, at: 0)
        } else {
            shapeLayer.path = path
        }
        
        
        
        if reginLayerTwo == nil {
            reginLayerTwo = CAShapeLayer()
            reginLayerTwo.fillColor = drawAreaColorTwo.cgColor
            reginLayerTwo.backgroundColor = UIColor.clear.cgColor
            reginLayerTwo.path = percentPathTwo
            reginLayerTwo.lineWidth = lineWidth
            reginLayerTwo.strokeColor = dotColorTwo.cgColor
            reginLayerTwo.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            
            layer.insertSublayer(reginLayerTwo, above: shapeLayer)
            
            
        } else {
            reginLayerTwo.path = percentPathTwo
        }
        if reginLayer == nil {
            reginLayer = CAShapeLayer()
            reginLayer.fillColor = drawAreaColor.cgColor
            reginLayer.backgroundColor = UIColor.clear.cgColor
            reginLayer.path = percentPath
            reginLayer.lineWidth = lineWidth
            reginLayer.strokeColor = dotColor.cgColor
            reginLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            
            layer.insertSublayer(reginLayer, above: shapeLayer)
            
            
        } else {
            reginLayer.path = percentPath
        }
        
        if dotsShapeLayer != nil {
            dotsShapeLayer.removeFromSuperlayer()
        }
        
        dotsShapeLayer = CAShapeLayer()
        dotsShapeLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.insertSublayer(dotsShapeLayer, above: reginLayerTwo)
        
        for item in array {
            let dotLayer = CATextLayer()
            dotLayer.cornerRadius = dotRadius
            dotLayer.frame = CGRect(x: item.x - dotRadius, y: item.y - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
            dotLayer.backgroundColor = dotColor.cgColor
            
            dotsShapeLayer.addSublayer(dotLayer)
        }
        
        for item in arrayTwo {
            let dotLayer = CATextLayer()
            dotLayer.cornerRadius = dotRadiusTwo
            dotLayer.frame = CGRect(x: item.x - dotRadiusTwo, y: item.y - dotRadiusTwo, width: dotRadiusTwo * 2, height: dotRadiusTwo * 2)
            dotLayer.backgroundColor = dotColorTwo.cgColor
            //pointArray.append(dotLayer.position)
            dotsShapeLayer.addSublayer(dotLayer)
        }
        
        if textShapeLayer != nil {
            textShapeLayer.removeFromSuperlayer()
        }
        
        //TODO
        //                if textShapeLayer == nil {
        textShapeLayer = CAShapeLayer()
        textShapeLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        layer.insertSublayer(textShapeLayer, above: reginLayer)
        //                } else {
        //        layer.insertSublayer(textShapeLayer, above: reginLayer)
        //                }
        
        for node in 0..<side {
            let size = getViewHeight(content: data[node].title)
            var x: CGFloat = (radius + size.height * 0) * sin(angle + angle * CGFloat(node)) + centerX
            var y: CGFloat = (radius + size.height * 0) * cos(angle + angle * CGFloat(node)) + centerY
            let textLayer = CATextLayer()
            textLayer.fontSize = 14
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.alignmentMode = CATextLayerAlignmentMode.center
            textLayer.foregroundColor = titleTextColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.string = data[node].title //"\(node)\(data[node].title)"
            
            //文字とサイト間の距離の調整
            if x >= nightNodeArray[4].x && x <= nightNodeArray[3].x && y < frame.size.height / 2 {
                x = x - size.width / 2
                y = y + size.height / 5 ///333
            } else if x > nightNodeArray[5].x && x < nightNodeArray[4].x &&
                y > nightNodeArray[4].y && y < nightNodeArray[5].y {
                x = x - size.width / 2
                y = y - size.height / 5 * 3 ///444
            } else if y >= nightNodeArray[5].y && y <= nightNodeArray[6].y && x < frame.size.width / 2 {
                if y > frame.size.height / 2 {
                    x = x - size.width / 2
                    y = y - size.height / 5 * 3  ///555
                } else {
                    x = x - size.width - space
                    y = y - size.height / 3 * 2
                }
            } else if x > nightNodeArray[0].x && x < nightNodeArray[1].x &&
                y > nightNodeArray[1].y && y < nightNodeArray[0].y {
                x = x - size.width / 5 * 3
                y = y - size.height / 5 * 3 ///111
            } else if y >= nightNodeArray[2].y && y <= nightNodeArray[1].y && x > frame.size.width / 2 {
                x = x - size.width / 5 * 3 ///222
                y = y - size.height / 5 * 3
                
            } else {
                ///666
                x = x - size.width / 2
                y = y - size.height * 5 / 4
            }
            
            textLayer.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            textShapeLayer.addSublayer(textLayer)
        }
        
        UIView.commitAnimations()
        
    }
    
    /// text height width
    ///
    /// - Parameter content: 内容
    /// - Returns: width height
    func getViewHeight(content: String) -> CGRect {
        let size = content.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return size
    }
}

//MARK:- public methods
extension RadarView {
    
    /// data setting
    ///
    /// - Parameter data:
    func setData(data: [RadarModel]) {
        //        print("setData:\(data)")
        self.data = data
        self.side = self.data.count
        // self.updateLayer()
    }
    
    func setDataTwo(dataTwo: [RadarModel]) {
        self.dataTwo = dataTwo
        self.side = self.dataTwo.count
        self.updateLayer()
    }
    
    /// set text color
    ///
    /// - Parameter color: color
    func setTextColor(color: UIColor) {
        if color == nil {
            return
        }
        self.titleTextColor = color.cgColor
    }
    
    /// set font
    ///
    /// - Parameter font: font
    func setTextFont(font: UIFont) {
        if font == nil {
            return
        }
        self.font = font
    }
    
    /// set line color
    ///
    /// - Parameter font: color
    func setLineColor(color: UIColor) {
        if color == nil {
            return
        }
        self.lineColor = color
    }
    
    /// set line width
    ///
    /// - Parameter width: width
    func setLineWidth(width: CGFloat) {
        if width == nil {
            return
        }
        self.lineWidth = width
    }
    
    /// 頂点の色
    ///
    /// - Parameter color: 色
    func setDotColor(color: UIColor) {
        if color == nil {
            return
        }
        self.dotColor = color
    }
    
    func setDotColorTwo(colorTwo: UIColor) {
        if colorTwo == nil {
            return
        }
        self.dotColorTwo = colorTwo
    }
    
    /// 頂点の半径
    ///
    /// - Parameter radius: 半径
    func setDotRadius(radius: CGFloat) {
        if radius == nil {
            return
        }
        self.dotRadius = radius
    }
    
    func setDotRadiusTwo(radiusTwo: CGFloat) {
        if radius == nil {
            return
        }
        self.dotRadiusTwo = radiusTwo
    }
    
    func setRadiusScaleWidth(radiusScaleWidth: CGFloat) {
        if radiusScaleWidth == nil {
            return
        }
        self.radiusScaleWidth = radiusScaleWidth
        
        self.updateLayer()
    }
    
    func setRadiusScaleHeight(radiusScaleHeight: CGFloat) {
        if radiusScaleHeight == nil {
            return
        }
        self.radiusScaleHeight = radiusScaleHeight
        
        self.updateLayer()
    }
    
    /// area color
    ///
    /// - Parameter color: color
    func setDrawAreaColor(color: UIColor) {
        if color == nil {
            return
        }
        self.drawAreaColor = color
    }
    
    func setDrawAreaColorTwo(color: UIColor) {
        if color == nil {
            return
        }
        self.drawAreaColorTwo = color
    }
    
    /// load
    func load() {
        self.updateLayer()
    }
}
