//
//  ScanCodeController.swift
//  AlipayScanQRCode
//
//  Created by 張璋 on 2020/02/26.
//  Copyright © 2020 張璋. All rights reserved.
//

let kMargin = 185
let kBorderW = 140
let scanViewW = UIScreen.main.bounds.width - CGFloat(kMargin * 2)
let scanViewH = UIScreen.main.bounds.width - CGFloat(kMargin * 2)

import UIKit
import AVFoundation

class ScanCodeController: UIViewController {

    var scanView: UIView? = nil
    var scanImageView: UIImageView? = nil
    var session = AVCaptureSession()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetAnimatinon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        setupMaskView()
        setupScanView()
        scaning()
        NotificationCenter.default.addObserver(self, selector: #selector(resetAnimatinon), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// スキャン以外の地域
    fileprivate func setupMaskView() {
        let maskView = UIView(frame: CGRect(x: -(view.bounds.height - view.bounds.width) / 2, y: 0, width: view.bounds.height, height: view.bounds.height))
        maskView.layer.borderWidth = (view.bounds.height - scanViewW) / 2
    
        maskView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
    
        view.addSubview(maskView)
    }
    
    /// スキャンの地域
    fileprivate func setupScanView() {
        
        scanView = UIView(frame: CGRect(x: CGFloat(kMargin), y: CGFloat((view.bounds.height - scanViewW) / 2), width: scanViewW, height: scanViewH))
        scanView?.backgroundColor = UIColor.clear
        scanView?.clipsToBounds = true
        view.addSubview(scanView!)
        
        scanImageView = UIImageView(image: UIImage.init(named: "sweep_bg_line.png"));
        let widthOrHeight: CGFloat = 18
        
        let topLeft = UIButton(frame: CGRect(x: 0, y: 0, width: widthOrHeight, height: widthOrHeight))
        topLeft.setImage(UIImage.init(named: "sweep_kuangupperleft.png"), for: .normal)
        scanView?.addSubview(topLeft)
        
        let topRight = UIButton(frame: CGRect(x: scanViewW - widthOrHeight, y: 0, width: widthOrHeight, height: widthOrHeight))
        topRight.setImage(UIImage.init(named: "sweep_kuangupperright.png"), for: .normal)
        scanView?.addSubview(topRight)

        let bottomLeft = UIButton(frame: CGRect(x: 0, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
        bottomLeft.setImage(UIImage.init(named: "sweep_kuangdownleft.png"), for: .normal)
        scanView?.addSubview(bottomLeft)
        
        let bottomRight = UIButton(frame: CGRect(x: scanViewH - widthOrHeight, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
        bottomRight.setImage(UIImage.init(named: "sweep_kuangdownright.png"), for: .normal)
        scanView?.addSubview(bottomRight)
    }
    
    
    /// スキャン開始
    fileprivate func scaning() {
        
        //設備ゲット
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        do {

            let input = try AVCaptureDeviceInput.init(device: device!)
            
            let output = AVCaptureMetadataOutput()
            output.rectOfInterest = CGRect(x: 0.1, y: 0, width: 0.9, height: 1)
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
         
            session.canSetSessionPreset(AVCaptureSession.Preset.high)
            session.addInput(input)
            session.addOutput(output)

            //スキャンする時支持されるふフォーマット
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8, AVMetadataObject.ObjectType.code128]
            
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            layer.frame = view.layer.bounds
            view.layer.insertSublayer(layer, at: 0)
            //細く開始
            session.startRunning()
            
        } catch let error as NSError  {
            print("errorInfo\(error.domain)")
        }
    }
    
    ///アニメーションをリセット
    @objc fileprivate func resetAnimatinon() {
        let anim = scanImageView?.layer.animation(forKey: "translationAnimation")
        if (anim != nil) {
   
            let pauseTime = scanImageView?.layer.timeOffset
           
            let beginTime = CACurrentMediaTime() - pauseTime!

            scanImageView?.layer.timeOffset = 0.0
      
            scanImageView?.layer.beginTime = beginTime
            scanImageView?.layer.speed = 1.1
        } else {
            
            let scanImageViewH = 241
            let scanViewH = view.bounds.width - CGFloat(kMargin) * 2
            let scanImageViewW = scanView?.bounds.width
            
            scanImageView?.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW!), height: scanImageViewH)
            let scanAnim = CABasicAnimation()
            scanAnim.keyPath = "transform.translation.y"
            scanAnim.byValue = [scanViewH]
            scanAnim.duration = 1.8
            scanAnim.repeatCount = MAXFLOAT
            scanImageView?.layer.add(scanAnim, forKey: "translationAnimation")
            scanView?.addSubview(scanImageView!)
        }
    }
}

extension ScanCodeController:AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count > 0 {
            session.stopRunning()
            let object = metadataObjects[0]
            let string: String = (object as AnyObject).stringValue
            
            print(string)
//            let vc = TestViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//            
            
            let testVC:UIStoryboard = UIStoryboard(name: "TestViewController", bundle: nil)

            let vc = testVC.instantiateViewController(withIdentifier: "testview") as! TestViewController
            self.navigationController?.pushViewController(vc, animated: true)
     
//                        if let url = URL(string: "https://www.google.co.jp/?client=safari") {
//                        if UIApplication.shared.canOpenURL(url) {
//                            _ = self.navigationController?.popViewController(animated: true)
//                            if #available(iOS 10.0, *) {
//                                UIApplication.shared.open(url)
//                            } else {
//                                UIApplication.shared.openURL(url)
//                            }
//
//                        } else {
//
//                            }}
            
            
            
//            if let url = URL(string: string) {
//            if UIApplication.shared.canOpenURL(url) {
//                _ = self.navigationController?.popViewController(animated: true)
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url)
//                } else {
//                    UIApplication.shared.openURL(url)
//                }
//
//            } else {
//
//                let alertViewController = UIAlertController(title: "結果", message: (object as AnyObject).stringValue, preferredStyle: .alert)
//                let actionCancel = UIAlertAction(title: "退出", style: .cancel, handler: { (action) in
//                    _ = self.navigationController?.popViewController(animated: true)
//                })
//                let actinSure = UIAlertAction(title: "再度スキャン", style: .default, handler: { (action) in
//                    self.session.startRunning()
//                })
//                alertViewController.addAction(actionCancel)
//                alertViewController.addAction(actinSure)
//                self.present(alertViewController, animated: true, completion: nil)
//            }
 //           }
        }
    }
}
