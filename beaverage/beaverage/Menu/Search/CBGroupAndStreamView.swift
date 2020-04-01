

import UIKit

@objc protocol CBGroupAndStreamViewDelegate : NSObjectProtocol {
    
    
    /// 選択された値を渡す
    ///
    /// - Parameters:
    ///   - selArr: 選択された値
    ///   - groupArr: gtoupIdArr
    
    @objc optional func confimrReturnAllSelValueWithDelegate(selArr : Array<Any>, groupArr : Array<Any>)
    
    /// 現在選択された値
    ///
    /// - Parameters:
    ///   - valueStr: Value
    ///   - index: index
    ///   - groupId: groupId
    @objc optional func currentSelValueWithDelegate(valueStr : String, index : Int, groupId : Int)
}


func initSubviewsTwo() -> RadarView {
    var radarView: RadarView!
    var wineKind: WineKind = WineKind()
    wineKind.body = 0.5
    wineKind.smoky = 0.75
    wineKind.woody = 0.25
    wineKind.floral = 0.5
    wineKind.fruity = 0.25
    wineKind.windy = 0.75
    radarView = RadarView(frame: CGRect(x: 110, y: 150, width: UIScreen.main.bounds.size.width - 250, height: UIScreen.main.bounds.size.width - 220))
    radarView.setLineColor(color: UIColor.init(red: 136 / 255, green: 136 / 255, blue: 136 / 255, alpha: 1))
    radarView.setTextColor(color: UIColor.init(red: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1))
    
    radarView.setLineWidth(width: 0.5)
    
    radarView.setDrawAreaColorTwo(color: UIColor.init(red: 202 / 255, green: 148 / 255, blue: 195 / 255, alpha: 0.8))
    radarView.setDotRadiusTwo(radiusTwo: 3)
    radarView.setDotColorTwo(colorTwo: UIColor.init(red: 237 / 255, green: 94 / 255, blue: 219 / 255, alpha: 1))
    
    radarView.setDataTwo(dataTwo: [RadarModel(title: "Woody", percent: CGFloat(wineKind.woody)), RadarModel(title: "Smoky", percent: CGFloat(wineKind.smoky)), RadarModel(title: "Body", percent: CGFloat(wineKind.body)), RadarModel(title: "Winey", percent: CGFloat(wineKind.windy)), RadarModel(title: "Fruity", percent: CGFloat(wineKind.fruity)), RadarModel(title: "Floral", percent: CGFloat(wineKind.floral))])
    return radarView
}


class CBGroupAndStreamView: UIView {
    var radarView: RadarView!
    
    //MARK:----publish
    /// group height
    public var titleLabHeight = 30
    ///
    public var titleTextFont : UIFont = .boldSystemFont(ofSize: 14)
    ///
    public var titleTextColor : UIColor = .black
    ///
    public var content_height = 60
    /// botton margin
    public var content_y = 10
    /// left right margin
    public var content_x = 10
    /// title default color
    public var content_norTitleColor : UIColor = .black
    /// title选中颜色
    public var content_selTitleColor : UIColor = .white
    /// 背景默认原色
    public var content_backNorColor : UIColor = .white
    /// 背景选中颜色
    public var content_backSelColor : UIColor = UIColor(red: 181/255, green: 21/255, blue: 8/255, alpha: 1)
    /// 字体大小
    public var content_titleFont : UIFont = .systemFont(ofSize: 18)
    /// 圆角
    public var content_radius : Int = 8
    /// 是否单选，默认 true 是单选
    public var isSingle : Bool = true
    /// 是否设置默认选中 默认 true 默认选中
    public var isDefaultChoice : Bool = true
    /// isDefaultChoice 为true时 改属性有效，默认为 0
    public var defaultSelIndex : Int = 0
    /// isDefaultChoice 为true时 改属性有效 defaultSelIndex 属性无效，为每各组设置单选选项
    public var defaultSelSingleIndeArr : Array = Array<Any>()
    /// 为每个组设置单选或多选，设置该属性时 isSingle 参数无效, 0 = 多选， 1 = 单选
    public var defaultGroupSingleArr = Array<Int>(){
        didSet{
            for value in defaultGroupSingleArr {
                if !(value == 0 || value == 1){
                    assert((value == 0 || value == 1), "defaultGroupSingleArr的值只能是 0 和 1")
                }
            }
        }
    }
    /// isDefaultChoice 为true时 该属性有效，设置每组默认选择项，可传数组
    public var defaultSelIndexArr = Array<Any>() {
        didSet{
            for (index,value) in defaultSelIndexArr.enumerated() {
                //当Value的类型是数组时则 isSingle 为false 多选
                if value is Array<Any>{
                    if !defaultGroupSingleArr.isEmpty{
                        //Value 是数组，并 defaultGroupSingleArr 不为空
                        defaultGroupSingleArr[index] = 0
                    }
                    isSingle = true
                }
            }
        }
    }
    /// 闭包传值，传出所有选择的值和groupid
    public var confirmReturnValueClosure : ((Array<Any>,Array<Any>) -> Void)?
    /// 闭包传值，传出当前选中的值
    public var currentSelValueClosure : ((String,Int,Int) -> Void)?
    /// 代理
    public weak var delegate : CBGroupAndStreamViewDelegate?
    
    //MARK:----private
    private let scrollView : UIScrollView = {
        let scrollview = UIScrollView()
        //content_totalHeight
        
        scrollview.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 30, height: UIScreen.main.bounds.size.height - 64 - 110 - 100)
        
        scrollview.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    private var tempContentArr : Array = Array<Any>()
    private var tempTitleArr : Array = Array<Any>()
    private var frameRect : CGRect = .zero
    private var dataSourceArr : Array = Array<Any>()
    private var saveSelButValueArr : Array = Array<Any>()
    private var saveSelGroupIndexeArr : Array = Array<Any>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(scrollView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDataSource(contetnArr : Array<Any>, titleArr : Array<String>){
        saveSelButValueArr.removeAll()
        saveSelGroupIndexeArr.removeAll()
        
        if defaultGroupSingleArr.count != titleArr.count && !defaultGroupSingleArr.isEmpty{
          
            return
        }
        
        tempContentArr = contetnArr.count > 0 ? contetnArr : tempContentArr
        tempTitleArr = titleArr.count > 0 ? titleArr : tempTitleArr
        
        //2番目のコンポーネントの開始位置
        frameRect = CGRect(x: 0, y: 0, width: 0, height: 385)
        //frameRect = .zero
        dataSourceArr.removeAll()
        dataSourceArr.append(contentsOf: tempContentArr)
        
        for (index,title) in titleArr.enumerated() {
            saveSelButValueArr.append("")
            saveSelGroupIndexeArr.append("")
            frameRect = setupGroupAndStream(content: contetnArr[index] as! Array<Any>, titleStr: title, currFrame: frameRect, groupId: index)
        }
        //设置滚动范围
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width - 60, height: frameRect.size.height + frameRect.origin.y + 20 + 900)
    }
    //MARK:----设置数据源，创建
    func setupGroupAndStream(content : Array<Any>, titleStr : String, currFrame : CGRect, groupId : Int) -> CGRect{
        
        //组标题
        let groupTitleLab = UILabel.init(frame: CGRect(x: 30, y: currFrame.size.height + currFrame.origin.y + 10, width: 0, height: CGFloat(titleLabHeight)))
        
        groupTitleLab.text = titleStr
        groupTitleLab.font = titleTextFont
        groupTitleLab.textColor = titleTextColor
        groupTitleLab.frame.size.width = calcuateLabSizeWidth(str: titleStr, font: titleTextFont, maxHeight: CGFloat(titleLabHeight))
        
        let viewGroup =  UIView()
        viewGroup.backgroundColor = UIColor.red
        viewGroup.frame = CGRect(x: 15, y: currFrame.size.height + currFrame.origin.y + 20, width: 10, height: 10)
        
        scrollView.addSubview(groupTitleLab)
        scrollView.addSubview(viewGroup)
        
        //内容
        let margian_y = 5 + groupTitleLab.frame.origin.y + groupTitleLab.frame.size.height
        var content_totalHeight = CGFloat(margian_y)
        var alineButWidth = CGFloat(0)
        var current_rect = CGRect()
        var margin_x = CGFloat(content_x)
        //建立个临时数组,保存默认选中的index
        var tempSaveSelIndexArr = Array<Any>()
        
        for (index,value) in content.enumerated() {
            
            
            let sender = UIButton.init(type: .custom)
            let viewButton =  UIView()
            
            if (content.count == index + 1) {
                // print("最后一个了")
                
                sender.setTitle(value as? String, for: .normal)
                sender.tag = index + groupId * 100 + 1
                sender.titleLabel?.font = content_titleFont
                sender.backgroundColor = UIColor(red: 201/255, green: 201/255, blue: 201/255, alpha: 1)
                sender.setTitleColor(content_norTitleColor, for: .normal)
                sender.setTitleColor(content_selTitleColor, for: .selected)
                sender.layer.cornerRadius = CGFloat(content_radius)
            } else {
                
                
                viewGroup.backgroundColor = UIColor.red
                        
                sender.setTitle(value as? String, for: .normal)
                sender.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
                sender.tag = index + groupId * 100 + 1
                sender.titleLabel?.font = content_titleFont
                sender.backgroundColor = content_backNorColor
                sender.setTitleColor(content_norTitleColor, for: .normal)
                sender.setTitleColor(content_selTitleColor, for: .selected)
                sender.layer.cornerRadius = CGFloat(content_radius)
                let subview = UIView()
                subview.backgroundColor = UIColor.red
                subview.frame = CGRect(x: 10, y: 25, width: 10, height: 10)
                sender.addSubview(subview)
            }
            
            sender.addTarget(self, action: #selector(senderEvent), for: .touchUpInside)
            //标签流
            let but_width = calcuateLabSizeWidth(str: value as! String, font:content_titleFont, maxHeight: CGFloat(content_height)) + 20 + 20
            //计算每个button的 X
            margin_x = CGFloat(alineButWidth) + CGFloat(content_x)
            //计算一行的宽度
            alineButWidth = CGFloat(content_x) + but_width + CGFloat(alineButWidth)
            //判断是否需要换行
            if alineButWidth >= self.frame.size.width{
                margin_x = CGFloat(content_x)
                alineButWidth = margin_x + but_width
                content_totalHeight = current_rect.size.height + current_rect.origin.y + CGFloat(content_x)
            }
            
            
            sender.frame = CGRect(x: margin_x, y: content_totalHeight, width: but_width, height: CGFloat(content_height))
            
            viewButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            
            
            let searchFooterView = Bundle.main.loadNibNamed("SearchFooterView", owner: nil, options: nil)?.first as? SearchFooterView
            
            
            let searchHeaderView = Bundle.main.loadNibNamed("SearchHeaderView", owner: nil, options: nil)?.first as? SearchHeaderView
            searchHeaderView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 30, height: 250)
            
            scrollView.addSubview(searchHeaderView!)
            
            if (tempTitleArr.count - 1 == groupId) && (content.count == index + 1) {
                searchFooterView?.frame = CGRect(x: 0, y: content_totalHeight + 80, width: UIScreen.main.bounds.size.width - 30, height: 900)
                
                radarView = initSubviewsTwo()
                searchFooterView!.addSubview(radarView)
                scrollView.addSubview(searchFooterView!)
            }
            
            
            
            //[btn addSubview:subView];
            scrollView.addSubview(sender)
            
            //临时保存frame，以进行下一次坐标计算
            current_rect = sender.frame
            
            
            if isDefaultChoice{
                //设置默认选中
                if defaultSelIndexArr.isEmpty{//单选
                    setDefaultSingleSelect(index: index, groupId: groupId, value: value as! String, sender: sender, content: content)
                }
                else{//多选
                    let arr =  setDefaultMultipleSelect(index: index, groupId: groupId, value: value as! String, sender: sender, content: content)
                    tempSaveSelIndexArr.append(contentsOf: arr)
                }
            }
            if index == content.count - 1{
                frameRect = sender.frame
            }
        }
        //保存默认选中的值
        if !defaultSelIndexArr.isEmpty{
            saveSelButValueArr[groupId] = tempSaveSelIndexArr
        }
        return frameRect
    }
    //MARK:---设置默认---单选
    private func setDefaultSingleSelect(index : Int , groupId : Int ,value : String, sender : UIButton, content : Array<Any>){
        //单选
        let valueStr = "\(index)/\(value)"
        if defaultSelSingleIndeArr.isEmpty{
            assert( !(defaultSelIndex  > content.count - 1), "在groupId = \(groupId) 设置默认选中项不能超过\(content.count - 1)")
            if index == defaultSelIndex{
                //sender.isSelected = true
                sender.backgroundColor = content_backSelColor
                saveSelButValueArr[groupId] = valueStr
            }
        }else{
            assert(!((defaultSelSingleIndeArr[groupId] as? Int)! > content.count - 1), "在groupId = \(groupId) 设置默认选中项不能超过\(content.count - 1)")
            if index == defaultSelSingleIndeArr[groupId] as? Int{
                //sender.isSelected = true
                sender.backgroundColor = content_backSelColor
                saveSelButValueArr[groupId] = valueStr
            }
        }
        saveSelGroupIndexeArr[groupId] = String(groupId)
    }
    //MARK:---设置默认---多选
    private func setDefaultMultipleSelect(index : Int , groupId : Int ,value : String, sender : UIButton, content : Array<Any>) -> Array<Any>{
        let content = defaultSelIndexArr[groupId]
        var tempSaveSelIndexArr = Array<Any>()
        if content is Int{
            if index == content as! Int{
                sender.isSelected = true
                sender.backgroundColor = content_backSelColor
                tempSaveSelIndexArr.append("\(index)/\(value)")
            }
        }
        if content is Array<Any>{
            for contenIndex in content as! Array<Any>{
                if index == contenIndex as! Int{
                    sender.isSelected = true
                    sender.backgroundColor = content_backSelColor
                    tempSaveSelIndexArr.append("\(index)/\(value)")
                    continue
                }
            }
        }
        saveSelGroupIndexeArr[groupId] = String(groupId)
        return tempSaveSelIndexArr
    }
    //                self.defaultSelIndexArr = [0,0,0,0,0,1]

    @objc private func senderEvent(sender : UIButton){
        //        print("----\(sender/.tag)")
        sender.isSelected = !sender.isSelected
  //      print(defaultGroupSingleArr)
//        if defaultGroupSingleArr.isEmpty{
//            //singalSelectEvent(sender: sender)
//            //统一设置单选或多选
//            singalSelectEvent(sender: sender)
//           // isSingle ? singalSelectEvent(sender: sender) : multipleSelectEvent(sender: sender)
//            return
//        }
        singalSelectEvent(sender: sender)
        //为每个组设置单选和多选
       // defaultGroupSingleArr[sender.tag / 100] != 0 ? multipleSelectEvent(sender: sender) : singalSelectEvent(sender: sender)
    }
    
    //MARK:---单选
    private func singalSelectEvent(sender : UIButton){
        var valueStr : String = ""
        let tempDetailArr = dataSourceArr[sender.tag / 100] as! Array<Any>
        if sender.isSelected {
            for (index, _) in tempDetailArr.enumerated(){
                if index + 1 == sender.tag % 100{
                   // sender.isSelected = true
                    sender.backgroundColor = content_backSelColor
                    continue
                }
                let norSender = scrollView.viewWithTag((sender.tag / 100) * 100 + index + 1) as! UIButton
                norSender.isSelected = false
                norSender.backgroundColor = content_backNorColor
            }
            valueStr = "\(sender.tag % 100 - 1)/\(tempDetailArr[sender.tag % 100 - 1])"
            //闭包传值
            if currentSelValueClosure != nil {
                currentSelValueClosure!(valueStr,sender.tag % 100 - 1,sender.tag / 100)
            }
            //代理传值
            delegate?.currentSelValueWithDelegate?(valueStr: valueStr, index: sender.tag % 100 - 1, groupId: sender.tag / 100)
        }else{
            sender.backgroundColor = content_backNorColor
        }
        //保存选中的值
        saveSelButValueArr[sender.tag / 100] = valueStr
        //保存groupId
        saveSelButValueArr[sender.tag / 100] as! String == "" ? (saveSelGroupIndexeArr[sender.tag / 100] = "") : (saveSelGroupIndexeArr[sender.tag / 100] = String(sender.tag / 100))
        
        self.defaultSelIndexArr = [2,3,4,4,1,1]
        
    }
    
//    //MARK:---多选
//    private func multipleSelectEvent(sender : UIButton){
//        var valueStr = ""
//        var tempSaveArr = Array<Any>()
//        if ((saveSelButValueArr[sender.tag / 100]) is Array<Any>){
//            tempSaveArr = saveSelButValueArr[sender.tag / 100] as! Array<Any>
//        }else{
//            tempSaveArr.append(saveSelButValueArr[sender.tag / 100])
//        }
//
//        let tempDetailArr = dataSourceArr[sender.tag / 100] as! Array<Any>
//        valueStr = "\(sender.tag % 100 - 1)/\(tempDetailArr[sender.tag % 100 - 1])"
//        if sender.isSelected {
//            sender.backgroundColor = content_backSelColor
//            //不存在相同的元素
//            tempSaveArr.append(valueStr)
//            //闭包传值
//            if currentSelValueClosure != nil {
//                currentSelValueClosure!(valueStr,sender.tag % 100 - 1,sender.tag / 100)
//            }
//            //代理传值
//            delegate?.currentSelValueWithDelegate?(valueStr: valueStr, index: sender.tag % 100 - 1, groupId: sender.tag / 100)
//        }else{
//            sender.backgroundColor = content_backNorColor
//            //获取元素的下标
//            //            let index : Int = tempSaveArr.index(where: {$0 as! String == valueStr})!
//            //            tempSaveArr.remove(at: index)
//        }
//
//        saveSelButValueArr[sender.tag / 100] = tempSaveArr
//        tempSaveArr.isEmpty ? (saveSelGroupIndexeArr[sender.tag / 100] = "") : (saveSelGroupIndexeArr[sender.tag / 100] = String(sender.tag / 100))
//
//    }
    
    //MARK:---确定
    public func comfirm(){
        if (confirmReturnValueClosure != nil) {
            confirmReturnValueClosure!(saveSelButValueArr,saveSelGroupIndexeArr)
        }
        
        delegate?.confimrReturnAllSelValueWithDelegate?(selArr: saveSelButValueArr, groupArr: saveSelGroupIndexeArr)
        
    }
    //MARK:---重置
    public func reload(){
        for value in scrollView.subviews {
            value.removeFromSuperview()
        }
        
        let contentArr = [["vanilla","honey","caramel","Nutty-cocount","caramel","Nutty-cocount","caramel","Nutty-cocountone","carameltow","Nutty-cocountthree","caramelforu","Nutty-cocountfive","caramelsix","Nutty-cocountserven","収まる１"],["sherryone","sherrytwo","sherrythree","sherryfour","sherry5","sherry6","sherry7","sherry8","sherr9y","sherry1010101","sherry1111111","sherry1212121","sherry1313131","収まる２"],["wax","wax2","wax3","wax4","wax5","wax6","wax7","収まる３"],["rose","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","lavender","収まる４"],["potato","potato2","potato3","potato4","potato5","potato6","potato7","potato8","potato9","potato10","potato11","収まる5"],["seaweed1","seaweed2","seaweed3","seaweed4","seaweed5","seaweed6","seaweed7","seaweed8","seaweed9","収まる6"]]
        
        setDataSource(contetnArr: tempContentArr, titleArr: tempTitleArr as! Array<String>)
        
        
    }
    
    //MARK:---计算文字宽度
    private func calcuateLabSizeWidth(str : String, font : UIFont, maxHeight : CGFloat) -> CGFloat{
        let attributes = [kCTFontAttributeName: font]
        let norStr = NSString(string: str)
        let size = norStr.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: maxHeight), options: .usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return size.width
    }
    
}
