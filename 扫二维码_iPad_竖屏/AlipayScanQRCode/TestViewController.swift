//
//  TestViewController.swift
//  AlipayScanQRCode
//
//  Created by 張璋 on 2020/02/26.
//  Copyright © 2020 ShaoFeng. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.brown
        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func testBtn(_ sender: Any) {
       
//        let vc = ViewController()
//        vc.view.backgroundColor = UIColor.blue
//        self.navigationController?.popToViewController(vc, animated: true)
        
        let firstVC:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

          let vc = firstVC.instantiateViewController(withIdentifier: "view") as! ViewController
          self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
