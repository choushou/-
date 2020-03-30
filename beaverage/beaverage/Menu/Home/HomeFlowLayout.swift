//
//  HomeFlowLayout.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit

class HomeFlowLayout: UICollectionViewFlowLayout {

    var columnCount:Int = 0
 
    var findList = [JianshuModel]()
 
    private var maxH:Int?
   
    var headerH:CGFloat = 0

    fileprivate var layoutAttributesArray = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        let contentWidth:CGFloat = (self.collectionView?.bounds.size.width)! - self.sectionInset.left - self.sectionInset.right
        let marginX = self.minimumInteritemSpacing
        let itemWidth = (contentWidth - marginX * CGFloat(self.columnCount - 1)) / CGFloat.init(self.columnCount)
        self.computeAttributesWithItemWidth(CGFloat(itemWidth))
    }
  
    func computeAttributesWithItemWidth(_ itemWidth:CGFloat){
     
        print(self.sectionInset.top)
        print(self.headerH)
        var columnHeight = [Int](repeating: Int(self.sectionInset.top + self.headerH), count: self.columnCount)
  
        var columnItemCount = [Int](repeating: 0, count: self.columnCount)
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        let headerAttr:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath.init(item: 0, section: 0))
        headerAttr.frame = CGRect(x: 0, y: CGFloat(0), width: self.collectionView!.bounds.size.width, height: self.headerH)
        attributesArray.append(headerAttr)
    
        var index = 0
        for data in self.findList {
            
            let indexPath = IndexPath.init(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            // 最短の列
            let minHeight:Int = columnHeight.sorted().first!
            print(minHeight)
            let column = columnHeight.index(of: minHeight)
           
            columnItemCount[column!] += 1
            let itemX = (itemWidth + self.minimumInteritemSpacing) * CGFloat(column!) + self.sectionInset.left
            let itemY = minHeight
           
            let itemH = Int(Double(data.itemHeight!)!)
            // frameを設定する
            print(itemY)
            attributes.frame = CGRect(x: itemX, y: CGFloat(itemY), width: itemWidth, height: CGFloat(itemH))
            
            attributesArray.append(attributes)
            
            columnHeight[column!] += itemH + Int(self.minimumLineSpacing)
            index += 1
        }
        
        // 最高列を見つけ出す
        let maxHeight:Int = columnHeight.sorted().last!
        let column = columnHeight.index(of: maxHeight)
        
        let itemH = (maxHeight - Int(self.minimumLineSpacing) * (columnItemCount[column!] + 1)) / columnItemCount[column!]
        self.itemSize = CGSize(width: itemWidth, height: CGFloat(itemH))
        // 後ろのパロパティーを設定する
        let footerIndexPath:IndexPath = IndexPath.init(item: 0, section: 0)
        let footerAttr:UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: footerIndexPath)
        footerAttr.frame = CGRect(x: 0, y: CGFloat(maxHeight), width: self.collectionView!.bounds.size.width, height: 30)
        attributesArray.append(footerAttr)
        // arrayの値を設定する
        self.layoutAttributesArray = attributesArray
        self.maxH = maxHeight + 30
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.layoutAttributesArray
    }
    
    ///contentSizeの再設定
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: CGFloat(self.maxH!))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    
}
