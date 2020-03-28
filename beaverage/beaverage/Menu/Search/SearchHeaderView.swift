//
//  SearchHeaderView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/26.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class SearchHeaderView: UIView {

    @IBOutlet weak var priceFirst: UIButton!
    @IBOutlet weak var priceTwo: UIButton!
    @IBOutlet weak var priceThree: UIButton!
    @IBOutlet weak var priceFour: UIButton!
    @IBOutlet weak var priceFive: UIButton!
    @IBOutlet weak var priceSix: UIButton!
    @IBOutlet weak var priceSeven: UIButton!
    
    public var button_backSelColor : UIColor = UIColor(red: 181/255, green: 21/255, blue: 8/255, alpha: 1)
    
    override func awakeFromNib() {
        priceFirst.addTarget(self, action: #selector(priceFirstTap), for: .touchUpInside)
          priceTwo.addTarget(self, action: #selector(priceTwoTap), for: .touchUpInside)
          priceThree.addTarget(self, action: #selector(priceThreeTap), for: .touchUpInside)
          priceFour.addTarget(self, action: #selector(priceFourTap), for: .touchUpInside)
          priceFive.addTarget(self, action: #selector(priceFiveTap), for: .touchUpInside)
          priceSix.addTarget(self, action: #selector(priceSixTap), for: .touchUpInside)
          priceSeven.addTarget(self, action: #selector(priceSevenTap), for: .touchUpInside)
    }
    
    @objc func priceFirstTap() {
        priceFirst.backgroundColor = button_backSelColor
        
        priceTwo.backgroundColor = UIColor.white
        priceThree.backgroundColor = UIColor.white
        priceFour.backgroundColor = UIColor.white
        priceFive.backgroundColor = UIColor.white
        priceSix.backgroundColor = UIColor.white
        priceSeven.backgroundColor = UIColor.white
       
         priceFirst.isSelected = true
       
              priceThree.isSelected = false
                    priceFour.isSelected = false
                    priceFive.isSelected = false
                    priceSix.isSelected = false
                    priceSeven.isSelected = false

         priceTwo.isSelected = false
        priceFirst.setTitleColor(UIColor.white, for: .selected)
        priceFirst.setTitleColor(UIColor.black, for: .normal)
        
    }
    @objc func priceTwoTap() {
        priceTwo.backgroundColor = button_backSelColor
        
        priceFirst.backgroundColor = UIColor.white
        priceThree.backgroundColor = UIColor.white
        priceFour.backgroundColor = UIColor.white
        priceFive.backgroundColor = UIColor.white
        priceSix.backgroundColor = UIColor.white
        priceSeven.backgroundColor = UIColor.white
      
                    priceThree.isSelected = false
                    priceFour.isSelected = false
                    priceFive.isSelected = false
                    priceSix.isSelected = false
                    priceSeven.isSelected = false
        priceFirst.isSelected = false
         priceTwo.isSelected = true
        
    priceTwo.setTitleColor(UIColor.white, for: .selected)
    }
    @objc func priceThreeTap() {
        priceThree.backgroundColor = button_backSelColor
        
        priceFirst.backgroundColor = UIColor.white
        priceTwo.backgroundColor = UIColor.white
        
        priceFour.backgroundColor = UIColor.white
        priceFive.backgroundColor = UIColor.white
        priceSix.backgroundColor = UIColor.white
        priceSeven.backgroundColor = UIColor.white
         priceThree.isSelected = true
         priceFirst.isSelected = false
                     priceTwo.isSelected = false
                    
                     priceFour.isSelected = false
                     priceFive.isSelected = false
                     priceSix.isSelected = false
                     priceSeven.isSelected = false
        priceThree.setTitleColor(UIColor.white, for: .selected)
    }
    @objc func priceFourTap() {
        priceFour.backgroundColor = button_backSelColor
        
        priceFirst.backgroundColor = UIColor.white
        priceTwo.backgroundColor = UIColor.white
        priceThree.backgroundColor = UIColor.white
        
        priceFive.backgroundColor = UIColor.white
        priceSix.backgroundColor = UIColor.white
        priceSeven.backgroundColor = UIColor.white
         priceFour.isSelected = true
        priceFirst.isSelected = false
                    priceTwo.isSelected = false
                    priceThree.isSelected = false
                  
                    priceFive.isSelected = false
                    priceSix.isSelected = false
                    priceSeven.isSelected = false
         priceFour.setTitleColor(UIColor.white, for: .selected)
        priceFour.setTitleColor(UIColor.black, for: .normal)
    }
    @objc func priceFiveTap() {
        priceFive.backgroundColor = button_backSelColor
        
        priceFirst.backgroundColor = UIColor.white
        priceTwo.backgroundColor = UIColor.white
        priceThree.backgroundColor = UIColor.white
        priceFour.backgroundColor = UIColor.white
        
        priceSix.backgroundColor = UIColor.white
        priceSeven.backgroundColor = UIColor.white
        
        priceFirst.isSelected = false
               priceTwo.isSelected = false
               priceThree.isSelected = false
               priceFour.isSelected = false

               priceSix.isSelected = false
               priceSeven.isSelected = false
        
         priceFive.isSelected = true
         priceFive.setTitleColor(UIColor.white, for: .selected)
        priceFive.setTitleColor(UIColor.black, for: .normal)
    }
    @objc func priceSixTap() {
        priceSix.backgroundColor = button_backSelColor
        
         priceFirst.backgroundColor = UIColor.white
        priceTwo.backgroundColor = UIColor.white
        priceThree.backgroundColor = UIColor.white
        priceFour.backgroundColor = UIColor.white
        priceFive.backgroundColor = UIColor.white
       
        priceSeven.backgroundColor = UIColor.white
        
        priceFirst.isSelected = false
               priceTwo.isSelected = false
               priceThree.isSelected = false
               priceFour.isSelected = false
               priceFive.isSelected = false
              
               priceSeven.isSelected = false
        
         priceSix.isSelected = true
        priceSix.setTitleColor(UIColor.white, for: .selected)
        priceSix.setTitleColor(UIColor.black, for: .normal)
    }
    @objc func priceSevenTap() {
        priceSeven.backgroundColor = button_backSelColor
        
        priceFirst.backgroundColor = UIColor.white
        priceTwo.backgroundColor = UIColor.white
        priceThree.backgroundColor = UIColor.white
        priceFour.backgroundColor = UIColor.white
        priceFive.backgroundColor = UIColor.white
        priceSix.backgroundColor = UIColor.white
        
        priceFirst.isSelected = false
        priceTwo.isSelected = false
        priceThree.isSelected = false
        priceFour.isSelected = false
        priceFive.isSelected = false
        priceSix.isSelected = false
        priceSeven.isSelected = true
     
        priceSeven.setTitleColor(UIColor.white, for: .selected)
         priceSeven.setTitleColor(UIColor.black, for: .normal)
        
    }
    
}
