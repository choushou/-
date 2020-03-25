自定义view

(一)常用的写法

[objc] view plain copy
//  自定义View  
  
import UIKit  
  
private let  KLMargin:CGFloat  = 10  
private let  KLLabelHeight:CGFloat  = 30  
  
class CustomView: UIView {  
  
    // 闭包 类似oc中的block  
    var buttonCallBack:(() -> ())?  
      
    // 重写init方法  
    override init(frame: CGRect) {  
        super.init(frame: frame)  
          
        self.backgroundColor = UIColor.orangeColor()  
        let lable: UILabel = UILabel(frame: CGRectMake(KLMargin, KLMargin, KLScreenWidth - (22 * KLMargin), KLLabelHeight))  
        lable.text = "我丫就是一label"  
        lable.textAlignment = NSTextAlignment.Center  
        lable.backgroundColor = UIColor.lightGrayColor()  
        self.addSubview(lable)  
          
          
        let button:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton  
        button.frame = CGRectMake(KLMargin, CGRectGetMaxY(lable.frame) + KLMargin, KLScreenWidth - (22 * KLMargin), KLLabelHeight)  
        button.backgroundColor = UIColor.lightTextColor()  
        button.setTitle("俺是个按钮啊", forState: UIControlState.Normal)  
        button.addTarget(self, action: Selector("buttonCllick:"), forControlEvents: UIControlEvents.TouchUpInside)  
        button.layer.cornerRadius = 5  
        button.clipsToBounds = true  
        self.addSubview(button)  
          
    }  
  
    // 反正重写了init方法这个会根据提示自动蹦出来  
    required init(coder aDecoder: NSCoder) {  
        fatalError("init(coder:) has not been implemented")  
    }  
      
    // 按钮点击事件的调用  
    func buttonCllick(button: UIButton){  
        if buttonCallBack != nil {  
            buttonCallBack!()  
        }  
    }  
      
    // 重新绘制和oc里面效果一样（其实我也不是很明白）  
    override func drawRect(rect: CGRect) {  
        //self.backgroundColor = UIColor.whiteColor()  
    }  
  
}  
在其他类的调用
[objc] view plain copy
let  customView:CustomView = CustomView(frame: CGRectMake(0, 80, KLScreenWidth, KLScreenWidth/2))  
                // 闭包（block）的回调  
                customView.buttonCallBack = { () -> () in  
                    customView.removeFromSuperview()  
                }  
                self.view.addSubview(customView)  

(二)在一开始的时候，我是写在drawRect里的，并没有重写init方法，发现也能实现效果
[objc] view plain copy
override func drawRect(rect: CGRect) {  
        self.backgroundColor = UIColor.orangeColor()  
        let lable: UILabel = UILabel(frame: CGRectMake(KLMargin, KLMargin, KLScreenWidth - (22 * KLMargin), KLLabelHeight))  
        lable.text = "我丫就是一label"  
        lable.textAlignment = NSTextAlignment.Center  
        lable.backgroundColor = UIColor.lightGrayColor()  
        self.addSubview(lable)  
          
          
        let button:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton  
        button.frame = CGRectMake(KLMargin, CGRectGetMaxY(lable.frame) + KLMargin, KLScreenWidth - (22 * KLMargin), KLLabelHeight)  
        button.backgroundColor = UIColor.lightTextColor()  
        button.setTitle("俺是个按钮啊", forState: UIControlState.Normal)  
        button.addTarget(self, action: Selector("buttonCllick:"), forControlEvents: UIControlEvents.TouchUpInside)  
        button.layer.cornerRadius = 5  
        button.clipsToBounds = true  
        self.addSubview(button)  
    }  
在其他类调用的时候，无法调用CustomView(frame:rect) 这个方法，只有像下面的代码那样调用
[objc] view plain copy
let  customView:CustomView = CustomView()  
                customView.backgroundColor = UIColor.orangeColor()  
                customView.frame = CGRectMake(0, 80, KLScreenWidth, KLScreenWidth/2)  
                customView.buttonCallBack = { () -> () in  
                    customView.removeFromSuperview()  
                }  
                self.view.addSubview(customView)  

