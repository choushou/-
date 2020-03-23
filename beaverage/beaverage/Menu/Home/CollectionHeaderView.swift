//
//  CollectionHeaderView.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/22.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit
//import ZHDropDownMenu

class CollectionHeaderView: UICollectionReusableView {
        
        typealias SwitchBtBlock = (_ click: Bool) -> Void
  
        
        var switchBack: SwitchBtBlock?
    
   // @IBOutlet weak var sortMenu: ZHDropDownMenu!
    
       override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code

        }
     
        func setHearderInfo(_ headInfo: Yuanzu) {
 
        }
        
  
}
