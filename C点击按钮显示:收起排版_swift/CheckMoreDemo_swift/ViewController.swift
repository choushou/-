//
//  ViewController.swift
//  CheckMoreDemo_swift
//
//  Created by 張璋 on 2020/03/18.
//  Copyright © 2020 張璋. All rights reserved.
//

import UIKit
    
class ViewController: UITableViewDataSource, UITableViewDelegate {

@IBOutlet weak var tableView: UITableView!
var isOpen = false
 var showButtonNumber = 0
   var titleArr: [AnyHashable] = []
   var theButton: UIButton?

    func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem?.title = "查看更多/收起demo"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TheCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "TheCollectionTableViewCell")
        showButtonNumber = 8

        titleArr = [
        "标题1",
        "标题2",
        "标题3",
        "标题4",
        "标题5",
        "标题6",
        "标题7",
        "标题8",
        "标题9",
        "标题10",
        "标题11",
        "标题12",
        "标题13",
        "标题14",
        "标题15"
        ]

    }
    
func theTextButton() -> UIButton? {

    if !theButton {
        theButton = UIButton(type: .custom)

        theButton.frame = CGRect(x: 15, y: 0, width: (UIApplication.shared.keyWindow?.frame.size.width ?? 0.0) - 30, height: 30)
        theButton.setTitle("查看更多", for: .normal)
       // theButton.addTarget(self, action: #selector(NSSliderAccessoryBehavior.handleAction(_:)), for: .touchUpInside)
        theButton.setTitleColor(UIColor.blue, for: .normal)
        theButton.backgroundColor = UIColor.white
        theButton.layer.cornerRadius = 15
        theButton.layer.masksToBounds = true
        theButton.layer.borderWidth = 1
        theButton.layer.borderColor = UIColor.green.cgColor
    }
    return theButton

}

func handleAction(_ sender: UIButton) {

    isOpen = !isOpen
    if isOpen {
        showButtonNumber = titleArr.count
        sender.setTitle("收起", for: .normal)
    } else {
        showButtonNumber = 8
        sender.setTitle("查看更多", for: .normal)
    }

    tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
}

        //  Converted to Swift 5 by Swiftify v5.0.40498 - https://objectivec2swift.com/
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            // 根据是否打开的标识 _isOpen返回不同row高度.
            if isOpen {
                // 按照整数/整数丢失精度仍为整数的思想(例如 9/5=1), 显示按钮的行数 = 显示按钮的个数/(每行显示的按钮个数+1) 行数为_titleArr.count / (4+1)
                let height1 = (4 + 1) + 1
                let height: CGFloat = (CGFloat(titleArr.count / height1 * 30)

                return 100
            } else {
                return 60
            }

        }

        //  Converted to Swift 5 by Swiftify v5.0.40498 - https://objectivec2swift.com/
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 0.05

        }

        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

            return 30
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "TheCollectionTableViewCell", for: indexPath) as? CollectionTableViewCell

            cell?.setupCell(withNumber: showButtonNumber, andButtonNameArr: titleArr)
            cell?.buttonClicked = { index in

                print(String(format: "点击的按钮下标为: %ld", index))

            }

            return cell!

        }

        //  Converted to Swift 5 by Swiftify v5.0.40498 - https://objectivec2swift.com/
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

            let firstFooter = UIView(frame: theButton.frame)

            firstFooter.addSubview(theButton)

            return firstFooter
        }

        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        
}
