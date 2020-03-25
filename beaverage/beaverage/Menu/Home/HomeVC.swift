//
// HomeVC.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit
import AudioToolbox

enum PointType {
    case body
    case smoky
    case woody
    case floral
    case fruity
    case winey
}

class WineKind: NSObject {
    var body: Float = 0.0
    var smoky: Float = 0.0
    var woody: Float = 0.0
    var floral: Float = 0.0
    var fruity: Float = 0.0
    var windy: Float = 0.0
}

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var radarView: RadarView!
    var radarViewTwo: RadarView!
    var pointType: PointType!
    var wineKind: WineKind = WineKind()
    
    // data source
    var dataArr = [JianshuModel]()
    // data index
    var index:Int = 1
    // column count
    var columnCount:Int = 2;
    // layout
    var flowLayout: HomeFlowLayout!
    // loading
    var loading = false
    //head info
    var headInfo:Yuanzu?
    
    var itemWidth:CGFloat = 0
    
    var collectionView: UICollectionView!
    var headerView: HomeHeadView?
    var collectionHeaderView: CollectionHeaderView?
    var footerView: HomeFootView?
    
    private var topIndicator: UIActivityIndicatorView?
    
    var darkView: UIView!
    
    @objc func leftClick(){
        
    }
    
    @objc private func backBtnClick() {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wineKind.body = 0.5
        wineKind.smoky = 0.75
        wineKind.woody = 0.25
        wineKind.floral = 0.5
        wineKind.fruity = 0.25
        wineKind.windy = 0.75
        
        self.navigationController?.navigationBar.isHidden = true
        
        let navBar = UINavigationBar(frame: CGRect(x:0, y:20, width:self.view.frame.size.width, height:64))
        
        navBar.backgroundColor = UIColor.white
        
        
        let titleLabel = UILabel(frame: CGRect(x:0,y:20,width:50,height:64))
        titleLabel.text = "メニューリスト"
        titleLabel.textColor = UIColor.black
        
        let navItem = UINavigationItem()
        
        navItem.titleView = titleLabel
        
        
        
        let button =   UIButton(type: .system)
        button.frame = CGRect(x:0, y:0, width:65, height:30)
        button.setImage(UIImage(named:"left_back"), for: .normal)
        button.setTitle("戻る", for: .normal)
        button.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        button.tintColor = UIColor.black
        let leftBarBtn = UIBarButtonItem(customView: button)
        
        //スペースが必要です。じゃないと、前に置けない
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,
                                     action: nil)
        spacer.width = -10;
        
        
        let rightButton = UIBarButtonItem(title: "rightButton", style: .plain, target: self, action: nil)
        rightButton.tintColor = UIColor.black
        
        navItem.leftBarButtonItems = [spacer,leftBarBtn]
        
        navigationItem.setHidesBackButton(true, animated: false)
        navBar.pushItem(navItem, animated: false)
        
        self.view.addSubview(navBar)
        
        
        
        
        let homeHeadView = Bundle.main.loadNibNamed("HomeHeadView", owner: nil, options: nil)?.first as? HomeHeadView
        homeHeadView!.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height:  530)
        
        self.view.addSubview(homeHeadView!)
        
        self.createUI()
        self.dataRefresh()
        
        
        let darkView = Bundle.main.loadNibNamed("DarkView", owner: nil, options: nil)?.first as? DarkView
        darkView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        darkView?.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.8)
        
        darkView?.showScanCodeBtn.addTarget(self, action: #selector(showScanCode), for: .touchUpInside)
        
        self.view.addSubview(darkView!)
        
        initSubviews()
        
        
        homeHeadView?.buttonCallBack =  { () -> () in
              let searchView = Bundle.main.loadNibNamed("SearchView", owner: nil, options: nil)?.first as? SearchView
                  searchView?.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64)
                  
                  searchView?.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.8)
                  
                //  searchView?.showScanCodeBtn.addTarget(self, action: #selector(showScanCode), for: .touchUpInside)
                  
                  self.view.addSubview(searchView!)
        }
    }
    
    func addSearchConditionView() {
        let darkView = Bundle.main.loadNibNamed("DarkView", owner: nil, options: nil)?.first as? DarkView
               darkView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
               
               darkView?.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.8)
               
//               darkView?.showScanCodeBtn.addTarget(self, action: #selector(showScanCode), for: .touchUpInside)
               
               self.view.addSubview(darkView!)
    }
    
    @objc func showScanCode() {
        let scanCodeViewController = ScanCodeController()
        self.navigationController?.pushViewController(scanCodeViewController, animated: true)
    }
    
    //MARK:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    
    func createUI(){
        
        self.flowLayout = HomeFlowLayout()
        //let layout = UICollectionViewFlowLayout()
        
        let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 530 + 64), size: CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 49 - (IsFullScreen ? 34 : 0)))
        self.collectionView = UICollectionView.init(frame: rect, collectionViewLayout:self.flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = RGB16(value: 0xffffff)
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        self.collectionView.register(UINib.init(nibName: "HomeFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HomeFootView")
        self.collectionView.register(UINib.init(nibName: "HomeHeadView", bundle: nil), forCellWithReuseIdentifier: "HomeHeadView")
        self.collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        
        //
        self.topIndicator = UIActivityIndicatorView.init(frame: CGRect(x: (SCREEN_WIDTH - 50) / 2.0, y: 90, width: 50, height: 50))
        self.topIndicator?.color = .red
        //self.view.addSubview(self.topIndicator!)
        
        self.setHomeFlowLayouts()
        
    }
    
    //MARK: - --- item layout
    func setHomeFlowLayouts(){
        //item widths
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let minLine:CGFloat = 10.0
        self.itemWidth = (SCREEN_WIDTH - inset.left - inset.right - minLine * (CGFloat(self.columnCount - 1))) / CGFloat(self.columnCount)
        
        
        self.flowLayout.columnCount = self.columnCount
        self.flowLayout.sectionInset = inset
        self.flowLayout.minimumLineSpacing = minLine
    }
    
    //MARK: - --- data layout
    func dataRefresh(){
        
        if self.headInfo != nil {
            if self.index > self.headInfo!.totalPage{
                print("nothing data")
                self.topIndicator?.stopAnimating()
                self.loading = false
                return;
            }
        }
        
        //network request
        JianshuRequestModel.jianshuRequestDataWithPage(self.index, Float(self.itemWidth), { (headInfo) in
            self.headInfo = headInfo
            self.flowLayout.headerH = 0 //headInfo.headerH
            print(headInfo)
        }) { (dataArr) in
            self.topIndicator?.stopAnimating()
            
            if self.index == 1 {
                self.dataArr.removeAll()
            }
            self.dataArr.append(contentsOf: dataArr)
            print("pageIndex: \(self.index)")
            self.index += 1
            
            //layout
            self.flowLayout.findList = self.dataArr
            //self.collectionView.collectionViewLayout = self.flowLayout
            
            //reload
            self.collectionView?.reloadData()
        }
        
    }
    
    //MARK: - --- delegate，dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell:HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let  model = self.dataArr[indexPath.row]
        cell.setModel(model)
        if self.headInfo != nil {
            cell.setHeadInfo(self.headInfo!)
        }
        
        return cell
        
    }
    
    //MARK: - --
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:HomeCell = collectionView.cellForItem(at: indexPath) as! HomeCell
        let model = self.dataArr[indexPath.row]
        
//        print("{\n第\(indexPath.row)个item\ntitle: \(cell.titleLb.text!)\nabstract: \(model.abstract!)\narticleUrl: https://www.jianshu.com\(model.articleUrl!)\n}")
        
        let webVC = ArticleVC()
        webVC.aticleID = model.articleUrl!
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    //MARK: - --- HeaderView  FooterView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView?
        if kind == UICollectionView.elementKindSectionFooter {
            self.footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeFootView", for: indexPath) as? HomeFootView
            reusableView = self.footerView
            return self.footerView!
        }
        else if kind == UICollectionView.elementKindSectionHeader {
            self.collectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView
            
            reusableView = self.collectionHeaderView
            self.collectionHeaderView?.setHearderInfo(self.headInfo!)
            //
            self.collectionHeaderView?.switchBack = { (click) in
                print(click)
                self.columnCount = (click == true) ? 1 : 2
                self.setHomeFlowLayouts()
                //高さを計算する
                var num = 0
                for model in self.dataArr {
                    //计算标题和摘要的高度
                    model.imgW = Float(self.itemWidth - 16)
                    model.imgH = model.wrap!.count > 0 ? model.imgW! * 120 / 150 : nil
                    model.titleH = GETSTRHEIGHT(fontSize: 20, width: CGFloat(model.imgW!) , words: model.title!) + 1
                    model.abstractH = GETSTRHEIGHT(fontSize: 14, width: CGFloat(model.imgW!) , words: model.abstract!) + 1
                    
                    //item高度
                    var computeH:CGFloat = 8 + 25 + 3 + 10 + 8 + (model.imgH != nil ? CGFloat(model.imgH!) : 0) + 8 + model.titleH! + 8 + model.abstractH! + 8 + 10 + 8
                    //如果没有图片减去一个间隙8
                    computeH = computeH - (model.wrap!.count > 0 ? 0 : 8)
                    model.itemHeight = String(format: "%.f", computeH)
                    self.dataArr[num] = model;
                    num += 1
                }
                self.flowLayout.findList = self.dataArr
                self.collectionView?.reloadData()
            }
            return self.collectionHeaderView!
        }
        return reusableView!
    }
    
    //MARK:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -120.0 {
            if self.loading == true {
                return;
            }
            self.topIndicator?.startAnimating()
            self.loading = true
            self.collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }, completion: { (finished) in
                    self.topIndicator?.stopAnimating()
                    self.loading = false
                })
                self.index = 1
                self.dataRefresh()
                
            })
        }
        
        if self.footerView == nil || self.loading == true {
            return
        }
        
        if self.footerView!.frame.origin.y < (scrollView.contentOffset.y + scrollView.bounds.size.height) {
            NSLog("refresh");
            self.loading = true
            self.footerView?.indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                self.footerView = nil
                self.dataRefresh()
                self.loading = false
            })
        }
        
    }
    
    //MARK: - ---
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //print(decelerate)
        if scrollView.contentOffset.y < -120.0 {
            self.topIndicator?.startAnimating()
            self.collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        }
        
        if scrollView.contentOffset.y > -120 &&  scrollView.contentOffset.y < -88{
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                self.collectionView.contentOffset.y = -88;
            }, completion: { (finished) in
                
            })
            self.topIndicator?.stopAnimating()
            self.loading = false
        }
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}

private extension HomeVC {
    func initSubviews() {
      
        radarView = RadarView(frame: CGRect(x: (UIScreen.main.bounds.width
                    - 80 - 230), y: 64 + 150 + 40, width: 220, height: 220))
        radarView.setLineColor(color: UIColor.init(red: 136 / 255, green: 136 / 255, blue: 136 / 255, alpha: 1))
        radarView.setTextColor(color: UIColor.init(red: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1))
        
        radarView.setLineWidth(width: 0.5)
        
//        radarView.setDotRadius(radius: 3)
//        radarView.setDrawAreaColor(color: UIColor.init(red: 113 / 255, green: 113 / 255, blue: 113 / 255, alpha: 0.6))
//        radarView.setDotColor(color: UIColor.init(red: 143 / 255, green: 143 / 255, blue: 143 / 255, alpha: 1))
        
        radarView.setDrawAreaColorTwo(color: UIColor.init(red: 202 / 255, green: 148 / 255, blue: 195 / 255, alpha: 0.8))
        radarView.setDotRadiusTwo(radiusTwo: 3)
        radarView.setDotColorTwo(colorTwo: UIColor.init(red: 237 / 255, green: 94 / 255, blue: 219 / 255, alpha: 1))
        
       // radarView.setData(data: [RadarModel(title: "Woody", percent: 0.75), RadarModel(title: "Smoky", percent: 0.25), RadarModel(title: "Body", percent: 0.75), RadarModel(title: "Winey", percent: 0.25), RadarModel(title: "Fruity", percent: 0.75), RadarModel(title: "Floral", percent: 0.75)])
        
        radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
      
        view.addSubview(radarView)
    }
}
