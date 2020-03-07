//
//  TestSanJiao.swift
//  popOver
//
//  Created by 張　璋 on 2020/03/03.
//  Copyright © 2020 rara. All rights reserved.
//

import UIKit

class TestSanJiao:UIView {
//  override  func draw(_ rect: CGRect) {
//               // 获取当前的图形上下文
//               let context = UIGraphicsGetCurrentContext()
//
//               // 设置线条的属性
//               // 1.设置线宽
//               context?.setLineWidth(2)
//               // 2.设置线条的颜色
//               context?.setStrokeColor(UIColor.gray.cgColor)
//               // 开始画线,需要将起点移动到指定的point
//               context?.move(to: CGPoint(x: 10, y: 10))
//               // 添加一根线到另一个点 (两点一线)
//               context?.addLine(to: CGPoint(x: 15, y: 20))
//               context?.addLine(to: CGPoint(x: 20, y: 10))
//               // 渲染图形到上下文
//               context?.strokePath()
//       }
//}
//
    override  func draw(_ rect: CGRect) {
               // 获取当前的图形上下文
                      let context = UIGraphicsGetCurrentContext()
                      // 设置边框颜色
                      context?.setStrokeColor(UIColor.gray.cgColor)
                      // 设置填充颜色
                      context?.setFillColor(UIColor.gray.cgColor)
                      // 开始画线,需要将起点移动到指定的point
                      context?.move(to: CGPoint(x: 5, y: 5))
                      // 添加一根线到另一个点 (两点一线)
                      context?.addLine(to: CGPoint(x: 15, y: 25))
                      // 添加一根线到另一个点 (两点一线)
                      context?.addLine(to: CGPoint(x: 25, y: 5))

                      // 画线完毕,最后将起点和终点封起来
                      context?.closePath()
                      /*
                          stroke      : 边框;
                          fill        : 填充
                          fillStroke  : 边框 + 填充
                       */
                      context?.drawPath(using: .fillStroke)
                      // 渲染上下文
                      context?.strokePath()


        }
}
