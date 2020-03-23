//
//  HomeVC.swift
//  SwiftApp
//
//  Created by leeson on 2018/6/14.
//  Copyright © 2018年 李斯芃 ---> 512523045@qq.com. All rights reserved.
//

import UIKit
import ZHDropDownMenu

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ZHDropDownMenuDelegate  {
    
    // 数据源
    var dataArr = [JianshuModel]()
    // 当前的数据索引
    var index:Int = 1
    // 列数
    var columnCount:Int = 2;
    // 瀑布流布局
    var flowLayout: HomeFlowLayout!
    // 是否正在加载数据标记
    var loading = false
    //头部信息
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
    
    public func setBackBtn(_ tintColor: UIColor = .black) {
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "返回白"), style: UIBarButtonItem.Style.done, target: self, action: #selector(backBtnClick))//
        leftBarButtonItem.tintColor = tintColor
        if #available(iOS 11.0, *){ // ios11 以上偏移
            leftBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -11, bottom: 0, right: 0)
            navigationItem.leftBarButtonItem = leftBarButtonItem
        } else {
            let nagetiveSpacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            nagetiveSpacer.width = -11//这个值可以根据自己需要自己调整
            navigationItem.leftBarButtonItems = [nagetiveSpacer, leftBarButtonItem]
        }
        if (navigationController?.viewControllers.count ?? 0) > 1 {
            navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate // 重要 自定义返回按钮恢复返回手势
        }
    }
    
    @objc private func backBtnClick() {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        // navItem.setRightBarButton(rightButton, animated: false)
        
        navigationItem.setHidesBackButton(true, animated: false)
        navBar.pushItem(navItem, animated: false)
        
        self.view.addSubview(navBar)
        
        
        
        
        let homeHeadView = Bundle.main.loadNibNamed("HomeHeadView", owner: nil, options: nil)?.first as? HomeHeadView
        homeHeadView!.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height:  400)
        homeHeadView!.sortMenu.options = ["2","1","3","4"]
        homeHeadView!.sortMenu.menuHeight = 250
        homeHeadView!.sortMenu.delegate = self
        
        self.view.addSubview(homeHeadView!)
        
        self.createUI()
        
        
        self.dataRefresh()
        
        
        let darkView = Bundle.main.loadNibNamed("DarkView", owner: nil, options: nil)?.first as? DarkView
        darkView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        
        
        darkView?.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.8) // 设置半透明颜色
        
        // self.view.insertSubview(darkView!, aboveSubview: self.view)
        
        self.view.addSubview(darkView!)
    }
    
    func dorpClickMenu(isShow: Bool) {
        if (isShow) {
            print("true")
        }else{
            print("false")
        }
    }
    
    //选择完后回调
    func dropDownMenu(_ menu: ZHDropDownMenu, didSelect index: Int) {
        print("\(menu) choosed at index \(index)")
    }
    
    //编辑完成后回调
    func dropDownMenu(_ menu: ZHDropDownMenu, didEdit text: String) {
        print("\(menu) input text \(text)")
    }
    
    //MARK: - --- 视图即将出现
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //
        //        let loginViewControllerStoryboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        //        let loginVC = loginViewControllerStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        //        let topVC = TopViewController()
        //        self.navigationController?.pushViewController(topVC, animated: true)
        
    }
    
    //MARK: - --- 创建UI
    func createUI(){
        
        
        
        
        //        let layout = HeadersFlowLayout()
        //        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height:view.bounds.height - 64)
        //        let collectionViewT = UICollectionView(frame: frame, collectionViewLayout: layout)
        //
        //        self.view.addSubview(collectionViewT)
        
        self.flowLayout = HomeFlowLayout()
        //let layout = UICollectionViewFlowLayout()
        
        let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 400 + 64), size: CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 49 - (IsFullScreen ? 34 : 0)))
        self.collectionView = UICollectionView.init(frame: rect, collectionViewLayout:self.flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = RGB16(value: 0xffffff)
        
        // self.collectionView.insertSubview(self.view, aboveSubview: homeHeadView)
        // self.view.insertSubview(self.collectionView, belowSubview: homeHeadView!)
        // self.view.insertSubview(homeHeadView!, aboveSubview: self.collectionView)
        self.view.addSubview(self.collectionView)
        //self.view.insertSubview(homeHeadView!.sortMenu, aboveSubview: collectionView)
        
        //注册xib
        self.collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        self.collectionView.register(UINib.init(nibName: "HomeFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HomeFootView")
        self.collectionView.register(UINib.init(nibName: "HomeHeadView", bundle: nil), forCellWithReuseIdentifier: "HomeHeadView")
        self.collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        
        //顶部加载“菊花”
        self.topIndicator = UIActivityIndicatorView.init(frame: CGRect(x: (SCREEN_WIDTH - 50) / 2.0, y: 90, width: 50, height: 50))
        self.topIndicator?.color = .red
        //self.view.addSubview(self.topIndicator!)
        
        self.setHomeFlowLayouts()
        
    }
    
    //MARK: - --- 设置item的布局
    func setHomeFlowLayouts(){
        //通过layout的一些参数设置item的宽度
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let minLine:CGFloat = 10.0
        self.itemWidth = (SCREEN_WIDTH - inset.left - inset.right - minLine * (CGFloat(self.columnCount - 1))) / CGFloat(self.columnCount)
        
        //设置布局属性
        self.flowLayout.columnCount = self.columnCount
        self.flowLayout.sectionInset = inset
        self.flowLayout.minimumLineSpacing = minLine
    }
    
    //MARK: - --- 数据及布局
    func dataRefresh(){
        
        if self.headInfo != nil {
            if self.index > self.headInfo!.totalPage{
                print("没有更多数据了")
                self.topIndicator?.stopAnimating()
                self.loading = false
                return;
            }
        }
        
        //网络请求回调
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
            
            //layout布局
            self.flowLayout.findList = self.dataArr
            //self.collectionView.collectionViewLayout = self.flowLayout
            //刷新视图
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
    
    //MARK: - --- 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:HomeCell = collectionView.cellForItem(at: indexPath) as! HomeCell
        let model = self.dataArr[indexPath.row]
        
        print("{\n第\(indexPath.row)个item\ntitle: \(cell.titleLb.text!)\nabstract: \(model.abstract!)\narticleUrl: https://www.jianshu.com\(model.articleUrl!)\n}")
        
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
            
            
            //            self.collectionHeaderView?.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height:  50)
            //            self.collectionHeaderView?.sortMenu.options = ["2","1","3","4"]
            //            self.collectionHeaderView?.sortMenu.menuHeight = 250
            //            self.collectionHeaderView?.sortMenu.delegate = self
            //
            //
            
            //self.collectionHeaderView?.sortMenu.insertSubview(self.collectionView, belowSubview: )
            //self.collectionHeaderView?.sortMenu.insertSubview(self.view, aboveSubview: self.collectionView)
            
            reusableView = self.collectionHeaderView
            self.collectionHeaderView?.setHearderInfo(self.headInfo!)
            //点击切换布局
            self.collectionHeaderView?.switchBack = { (click) in
                print(click)
                self.columnCount = (click == true) ? 1 : 2
                self.setHomeFlowLayouts()
                //遍历数组 重新计算高度
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
    
    //MARK: - --- scrollViewDelegate 监听scrollView.contentOffset.y，用以刷新数据
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
            NSLog("开始刷新");
            self.loading = true
            self.footerView?.indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                self.footerView = nil
                self.dataRefresh()
                self.loading = false
            })
        }
        
    }
    
    //MARK: - --- 监听手指停止滑动
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
