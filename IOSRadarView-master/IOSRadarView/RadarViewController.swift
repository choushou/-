//
//  RadarViewController.swift
//  IOSRadarView
//
//  Created by 張璋 on 2020/02/17.
//  Copyright © 2020 張璋. All rights reserved.
//

import UIKit
import SnapKit

class RadarViewController: UIViewController {
    
    var radarView: RadarView!
    var radarViewTwo: RadarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        
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
        
        radarView.setDrawAreaColor(color: UIColor.init(red: 121 / 255, green: 212 / 255, blue: 253 / 255, alpha: 0.6))
        radarView.setDotRadius(radius: 3)
        radarView.setDotColor(color: UIColor.init(red: 121 / 255, green: 212 / 255, blue: 253 / 255, alpha: 1))
        
      radarView.setDrawAreaColorTwo(color: UIColor.init(red: 10 / 255, green: 22 / 255, blue: 53 / 255, alpha: 0.2))
        
        radarView.setData(data: [RadarModel(title: "Body", percent: 0.9), RadarModel(title: "Winey", percent: 0.4), RadarModel(title: "Fruity", percent: 0.9), RadarModel(title: "Floral", percent: 1), RadarModel(title: "Woody", percent: 1), RadarModel(title: "Smoky", percent: 0.2)])
       
        radarView.setDataTwo(dataTwo: [RadarModel(title: "Body", percent: 0.6), RadarModel(title: "Winey", percent: 0.9), RadarModel(title: "Fruity", percent: 0.3), RadarModel(title: "Floral", percent: 0.6), RadarModel(title: "Woody", percent: 0.6), RadarModel(title: "Smoky", percent: 1)])
        
        view.addSubview(radarView)
        
        let sixButton = UIButton()
        sixButton.layer.cornerRadius = 8
        sixButton.backgroundColor = UIColor.red
        sixButton.setTitle("六角形", for: .normal)
        sixButton.addTarget(self, action: #selector(onSixAction), for: .touchUpInside)
        view.addSubview(sixButton)
        sixButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
        
    }

    @objc func onSixAction() {
        radarView.setDataTwo(dataTwo: [RadarModel(title: "Body", percent: 0.9), RadarModel(title: "Winey", percent: 0.2), RadarModel(title: "Fruity", percent: 0.9), RadarModel(title: "Floral", percent: 0.8), RadarModel(title: "Woody", percent: 0.6), RadarModel(title: "Smoky", percent: 0.2)])
    }
}
