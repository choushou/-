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
    var titleArray : [String] = []
    var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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

        let titleArr = ["关系","花","节日","枝数"]
        titleArray = titleArr
        let contentArr = [["恋人","朋友朋友朋友朋友朋友朋友","亲人恩师恩师","恩师恩师","病人","其他","恋人","朋友朋友朋友朋友朋友朋友","亲人恩师恩师","恩师恩师","病人","其他"],["玫","百合","康乃馨","郁金香","扶郎","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲","马蹄莲"],["情人节","母亲节","圣诞节","元旦节","春节","恋人","朋友朋友朋友朋友朋友朋友","亲人恩师恩师","恩师恩师","病人","其他"],["9枝","100000000枝","11枝","21枝","33枝","99枝","99999999枝以上","恋人","朋友朋友朋友朋友朋友朋友","亲人恩师恩师","恩师恩师","病人","其他","恋人","朋友朋友朋友朋友朋友朋友","亲人恩师恩师","恩师恩师","病人","其他","恋人","朋友朋友朋友朋友朋友朋友","亲人恩师恩师","恩师恩师","病人","収まる"]]

        contentArray = contentArr
         labGroup = CBGroupAndStreamView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        labGroup.titleTextFont = .systemFont(ofSize: 14)
        labGroup.titleLabHeight = 30;
        labGroup.titleTextColor = .red
        labGroup.isSingle = true
//        labGroup.defaultSelIndex = 1
//        labGroup.defaultSelSingleIndeArr = [1,1,0,0]
        //使用该参数则默认为多选 isSingle 无效 defaultSelSingleIndeArr 设置无效
        labGroup.defaultSelIndexArr = [[0,5,8,3,2],1,0,3]
        //分别设置每个组的单选与多选
        labGroup.defaultGroupSingleArr = [0,1,1,0]
        labGroup.setDataSource(contetnArr: contentArr, titleArr: titleArr)
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
        //print(contentArray[3])
        
        print(contentArray[groupId])
        print(contentArray[groupId][index])
     
        
        var contentArTest: [String] = []
        var contentArrayTest : [[String]] = [[]]
        contentArrayTest.append(contentArray[0])
        contentArrayTest.append(contentArray[1])
        contentArrayTest.append(contentArray[2])
        //contentArrayTest.append(contentArray[3])
        
        contentArrayTest.remove(at: 0)
        //contentArrayTest = contentArray
        
    
        
        //contentArTest = contentArray[3]
        
        for index in 0..<3 {
            let item = contentArray[3][index]
           // print(item)
            contentArTest.append(item)
            if index == 2 {
                contentArTest.append("もっと見る")
            }
            
        }
        
   
        
       // print(contentArTest)
        contentArrayTest.append(contentArTest)
        
        if text == "test" {
            if contentArrayTest[groupId][index] == "もっとを見る" {
                                  print("343434343")
                              }
            text = ""
            labGroup.setDataSource(contetnArr: contentArray , titleArr: titleArray)
        } else {
            text = "test"
            labGroup.setDataSource(contetnArr: contentArrayTest , titleArr: titleArray)
        }
      
        
        print(contentArray)
        //print(contentArrayTest)
        
       // labGroup.setDataSource(contetnArr: contentArray , titleArr: titleArray)
        
        labGroup.reload()
    }

    func confimrReturnAllSelValueWithDelegate(selArr: Array<Any>, groupArr: Array<Any>) {
        print(selArr)
    }
}

