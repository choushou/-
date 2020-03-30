//
//  MenuDetailViewController.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/29.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit
import AudioToolbox

class MenuDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //var labGroup = CBGroupAndStreamView()
    var contentArray : [[String]] = [[]]
    var contentArrayDa: [[String]] = [[]]
    var titleArray : [String] = []
    var selectedButton: String = ""
    //定义一个数组保存是否选中的状态
    var selectArray : [String] = ["false","false","false","false","false","false"]
    
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
    var menuDetailHeaderView: MenuDetailViewController?
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
        
        setNavigationBar()
        
        let menuDetailHeaderView = Bundle.main.loadNibNamed("MenuDetailHeaderView", owner: nil, options: nil)?.first as? MenuDetailHeaderView
        menuDetailHeaderView!.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height:  680)
        
        self.view.addSubview(menuDetailHeaderView!)
        
        self.createUI()
        self.dataRefresh()
        
    }
    
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        let navBar = UINavigationBar(frame: CGRect(x:0, y:20, width:self.view.frame.size.width, height:64))
        
        navBar.backgroundColor = UIColor.white
        
        
        let titleLabel = UILabel(frame: CGRect(x:0,y:20,width:50,height:64))
        titleLabel.text = "詳細"
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
        
        let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 680 + 64), size: CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 49 - (IsFullScreen ? 34 : 0)))
        self.collectionView = UICollectionView.init(frame: rect, collectionViewLayout:self.flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = RGB16(value: 0xffffff)
        self.view.addSubview(self.collectionView)
        
        
        self.collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        self.collectionView.register(UINib.init(nibName: "HomeFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HomeFootView")
        self.collectionView.register(UINib.init(nibName: "MenuDetailHeaderView", bundle: nil), forCellWithReuseIdentifier: "MenuDetailHeaderView")
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
    
        
        //        let menuDetailViewController = MenuDetailViewController()
        //         self.navigationController?.pushViewController(menuDetailViewController, animated: true)
        
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


