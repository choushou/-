//
//  ViewController.swift
//  labelGroupAndStreamSwift
//
//  Created by kms on 2018/8/13.
//  Copyright © 2018年 KMS. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var labGroup = CBGroupAndStreamView()
    var contentArray : [[String]] = [[]]
    var contentArrayDa: [[String]] = [[]]
    var titleArray : [String] = []
    var selectedButton: String = ""
    //定义一个数组保存是否选中的状态
    var selectArray : [String] = ["false","false","false","false","false","false"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //self.view.backgroundColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        
        let resetBut = UIButton.init(type: .custom)
        resetBut.setTitle("重置", for: .normal)
        resetBut.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        resetBut.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resetBut.setTitleColor(UIColor.brown, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: resetBut)
        resetBut.addTarget(self, action: #selector(resetLabGroup), for: .touchUpInside)
        
        let confirmBut = UIButton.init(type: .custom)
        confirmBut.setTitle("确定", for: .normal)
        confirmBut.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        confirmBut.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        confirmBut.setTitleColor(UIColor.brown, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: confirmBut)
        confirmBut.addTarget(self, action: #selector(confirmLabGroup), for: .touchUpInside)
        
        let titleArr = ["Woody","Winey","Fruity","Floral","Malty","Smokey"]
        titleArray = titleArr
        let contentArr = [["vanilla","honey","caramel","Nutty-cocount","caramel","Nutty-cocount","caramel","Nutty-cocountone","carameltow","Nutty-cocountthree","caramelforu","Nutty-cocountfive","caramelsix","Nutty-cocountserven","収まる１"],["sherryone","sherrytwo","sherrythree","sherryfour","sherry5","sherry6","sherry7","sherry8","sherr9y","sherry1010101","sherry1111111","sherry1212121","sherry1313131","収まる２"],["wax","wax2","wax3","wax4","wax5","wax6","wax7","収まる３"],["rose","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","収まる４"],["potato","potato2","potato3","potato4","potato5","potato6","potato7","potato8","potato9","potato10","potato11","収まる5"],["seaweed1","seaweed2","seaweed3","seaweed4","seaweed5","seaweed6","seaweed7","seaweed8","seaweed9","収まる6"]]
        
        var contentArFirst: [String] = []
        
        for indexGroup in 0..<6 {
            
            let indexArray = contentArr[indexGroup]
            
            if indexArray.count > 2 {
                for index in 0..<3 {
                    contentArFirst.append(indexArray[index])
                }
            } else {
                for indexTwo in 0..<indexArray.count {
                    contentArFirst.append(indexArray[indexTwo])
                }
            }
            
            contentArFirst.append("もっとを見る+")
            contentArrayDa.append(contentArFirst)
            contentArFirst.removeAll()
            
        }
        
        contentArrayDa.remove(at: 0)
        
        contentArray = contentArr
        labGroup = CBGroupAndStreamView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        labGroup.titleTextFont = .systemFont(ofSize: 14)
        labGroup.titleLabHeight = 30;
        labGroup.titleTextColor = .red
        labGroup.isSingle = true
        //        labGroup.defaultSelIndex = 1
        //        labGroup.defaultSelSingleIndeArr = [1,1,0,0]
        //使用该参数则默认为多选 isSingle 无效 defaultSelSingleIndeArr 设置无效
        labGroup.defaultSelIndexArr = [[0,5,8,3,2],1,0,3,1,1]
        //分别设置每个组的单选与多选
        labGroup.defaultGroupSingleArr = [0,1,1,0,1,1]
        
        labGroup.setDataSource(contetnArr: contentArrayDa, titleArr: titleArr)
        
        labGroup.delegate = self
        
        self.view.addSubview(labGroup)
        labGroup.confirmReturnValueClosure = {
            (selArr,groupIdArr) in
            //            print(selArr)
        }
        labGroup.currentSelValueClosure = {
            (valueStr,index,groupId) in
            //            print("\(valueStr) index = \(index), groupid = \(groupId)")
        }
        
    }
    
    @objc func resetLabGroup(){
        labGroup.reload()
    }
    
    @objc func confirmLabGroup(){
        labGroup.comfirm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : CBGroupAndStreamViewDelegate{
    
    func currentSelValueWithDelegate(valueStr: String, index: Int, groupId: Int) {
        print("\(valueStr) index = \(index), groupid = \(groupId)")
        //contentArray[4].prefix(5)
     
        
       
        
        print(selectArray[groupId])
        print(index)
        print(contentArray[groupId].count - 1)
        
        if ((selectArray[groupId] == "true") && (index == contentArray[groupId].count - 1)) || ((selectArray[groupId] != "true") && (index == 3)) {
            
            var contentArrayTest : [[String]] = [[]]
               
               for indexAppend in 0..<6 {
                   
                   if indexAppend == groupId {
                       
                       contentArrayDa.remove(at: groupId)
                    
                    
                       
                       if selectArray[groupId] == "true" {
                           
                           var conArr: [String] = []
                           
                           let indexArr = contentArray[groupId]
                           
                           if indexArr.count > 2 {
                               for index in 0..<3 {
                                   conArr.append(indexArr[index])
                               }
                           } else {
                               for indexTwo in 0..<indexArr.count {
                                   conArr.append(indexArr[indexTwo])
                               }
                           }
                           
                           conArr.append("もっとを見る+")
                           
                           contentArrayDa.insert(conArr, at: groupId)
                           
                           selectedButton = ""
                        
                        selectArray.remove(at: groupId)
                        selectArray.insert("false", at: groupId)
                        
                       } else {
                        selectArray.remove(at: groupId)
                        selectArray.insert("true", at: groupId)
                        
                           selectedButton = "selected"
                           contentArrayDa.insert(contentArray[groupId], at: groupId)
                       }
                    
                   }
               }
            

            contentArrayTest.remove(at: 0)
            
            labGroup.setDataSource(contetnArr: contentArrayDa , titleArr: titleArray)
            labGroup.reload()
     
        }
    

    }
    
    func confimrReturnAllSelValueWithDelegate(selArr: Array<Any>, groupArr: Array<Any>) {
        print(selArr)
    }
}

