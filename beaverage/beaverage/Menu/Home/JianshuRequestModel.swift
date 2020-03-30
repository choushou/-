//
//  JianshuRequestModel.swift
//  beaverage
//
//  Created by 張璋 on 2020/03/23.
//  Copyright © 2020 sunasterisk. All rights reserved.
//

import UIKit


typealias Yuanzu = (headImge: String, name: String, sex:String, infoList: Array<String>, totalPage: Int, intro: String, headerH:CGFloat)

typealias HeadBlock = (_ str: Yuanzu) -> Void

typealias DataListBack = (_ str: [JianshuModel]) -> Void

class JianshuRequestModel: NSObject  {
    
    static func jianshuRequestDataWithPage(_ page:Int, _ itemWith:Float, _ headBlock:HeadBlock, _ dataListBack:DataListBack){
        var dataArr = [JianshuModel]()
        do {
      
            let authorId = "1b4c832fb2ca"
 
            var str = try String(contentsOf:URL.init(string: "https://www.jianshu.com/u/\(authorId)?page=\(page)")!, encoding: .utf8)
            print(str)
            
       
            str = str.replacingOccurrences(of: "\n", with: "")
            str = str.replacingOccurrences(of: " ", with: "")
            
            if page == 1 {
               
                let headTop =  "<divclass=\"main-top\">(.*?)</div><ulclass=\"trigger-menu\""
                let topInfo:String = self.extractStr(str, headTop)
              
                let headImagRegex = "(?<=aclass=\"avatar\"href=\".{0,200}\"><imgsrc=\")(.*?)(?=\"alt=\".*?\"/></a>)"
                let headImge = self.extractStr(topInfo, headImagRegex)
             
                let nameRegex = "(?<=aclass=\"name\"href=\".{0,200}\">)(.*?)(?=</a>)"
                let name = self.extractStr(topInfo, nameRegex)
                
              
                let sexRegex = "(?<=iclass=\"iconfontic-)(.*?)(?=\">.*?</i>)"
                let sex = self.extractStr(topInfo, sexRegex)
                
                let infoListRegex = "(?<=li><divclass=\"meta-block\">.{0,200}<p>)(.*?)(?=</p>.*?</li>)"
                let infoList = self.regexGetSub(infoListRegex, topInfo)
            
                let articleCount = Int(Double((infoList[2]))!)
                let totalPage = articleCount % 9 > 0 ? (articleCount / 9 + 1) : articleCount / 9
         
                let introRegex = "(?<=divclass=\"js-intro\">)(.*?)(?=</div>)"
                var intro = self.regexGetSub(introRegex, str)[0]
                intro = intro.replacingOccurrences(of: "<br>", with: "\n")
              
                let headerH = 10 + 60 + 5 + 12 + 8 + GETSTRHEIGHT(fontSize: 12, width: CGFloat(SCREEN_WIDTH - (10 + 60 + 15 + 10)) , words: intro) + 10 + 1
           
                let headCallBackInfo = (headImge:headImge, name:name, sex:sex, infoList:infoList, totalPage:totalPage, intro:intro, headerH:headerH)
                headBlock(headCallBackInfo)
            }
       
            let articleListStrRegex = "<ulclass=\"note-list\"infinite-scroll-url=\".*?\">(.*?)</ul>"
        
            let articleListStrArr = self.regexGetSub(articleListStrRegex, str)
            if articleListStrArr[0] != "" {
                let articleListStr = articleListStrArr[0]
             
                let liLableRegex = "<liid=(.*?)</li>"
              
                let liLableArr = self.regexGetSub(liLableRegex, articleListStr)
              
                for item in liLableArr {
                    //print(item)
                 
                    let wrapRegex = "(?<=aclass=\"wrap-img\".{0,300}src=\")(.*?)(?=\"alt=\".*?\"/></a>)"
                    let articleUrlRegex = "(?<=aclass=\"title\"target=\"_blank\"href=\")(.*?)(?=\">.*?</a><pclass)"
                    let titleRegex = "(?<=aclass=\"title\".{0,200}>)(.*?)(?=</a><pclass)"
                    let abstractRegex = "(?<=pclass=\"abstract\">)(.*?)(?=</p>)"
                    //let readCommentsRegex = "(?<=atarget=\"_blank\".{0,200}></i>)(.*?)(?=</a>)"
                    let readRegex = "(?<=atarget=\"_blank\".{0,200}><iclass=\"iconfontic-list-read\"></i>)(.*?)(?=</a>)"
                    let commentsRegex = "(?<=atarget=\"_blank\".{0,200}><iclass=\"iconfontic-list-comments\"></i>)(.*?)(?=</a>)"
                    let likeRegex = "(?<=span><iclass=\"iconfontic-list-like\"></i>)(.*?)(?=</span>)"
                    let timeRegex = "(?<=spanclass=\"time\"data-shared-at=\")(.*?)(?=\"></span>)"
                    
                  
                    let model = JianshuModel()
                    
                    model.wrap = "test"
                    model.imgW = itemWith - 16

                 model.imgH = 240
                 model.abstract = "test12"
                 
                    model.articleUrl = self.regexGetSub(articleUrlRegex, item)[0]
                    //文章title
                    model.title = "testTitle"

                
                    model.read = "readTestfuzhi"
  
                    model.comments = "12"
          
                    model.like = self.regexGetSub(likeRegex, item)[0]
                    //发布时间
                    var time = self.regexGetSub(timeRegex, item)[0]
                    time = time.replacingOccurrences(of: "T", with: " ")
                    time = time.replacingOccurrences(of: "+08:00", with: "")
                    model.time = time
                    
     
                    model.titleH = GETSTRHEIGHT(fontSize: 20, width: CGFloat(model.imgW!) , words: model.title!) + 1
                    model.abstractH = GETSTRHEIGHT(fontSize: 14, width: CGFloat(model.imgW!) , words: model.abstract!) + 1
                    
                    var computeH:CGFloat = 8 + 25 + 3 + 10 + 8 + (model.imgH != nil ? CGFloat(model.imgH!) : 0) + 8 + model.titleH! + 8 + model.abstractH! + 8 + 10 + 8
         
                    computeH = computeH - (model.wrap!.count > 0 ? 0 : 8)
                    model.itemHeight = String(format: "%.f", computeH)
                    dataArr.append(model)
                    
                }
                //print(dataArr)
            }
            
        } catch {
            print(error)
        }
        dataListBack(dataArr)
    }
    
    //MARK: - ---
    static func extractStr(_ str:String, _ pattern:String) -> String{
        
        do{
            let regex = try NSRegularExpression(pattern: pattern , options: .caseInsensitive)
            
            let firstMatch = regex.firstMatch(in: str, options: .reportProgress, range: NSMakeRange(0, str.count))
            if firstMatch != nil {
                let resultRange = firstMatch?.range(at: 0)
                let result = (str as NSString).substring(with: resultRange!)
                //print(result)
                return result
            }
        }catch{
            print(error)
            return ""
        }
        return ""
    }
    
    //MARK: -
    static func regexGetSub(_ pattern:String, _ str:String) -> [String] {
        var subStr = [String]()
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
            let results = regex.matches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
            //解析出子串
            for  rst in results {
                let nsStr = str as  NSString  //可以方便通过range获取子串
                subStr.append(nsStr.substring(with: rst.range))
            }
        }catch{
            print(error)
            return [""]
        }
        return subStr.count == 0 ? [""]:subStr
    }
    
    //MARK: - -
    static func matchingStr(str:String) -> String{
        let regex = "w/\\d+/h/\\d+$"
        let rangeindex = str.range(of: regex, options: .regularExpression, range: str.startIndex..<str.endIndex, locale:Locale.current)
        var value:String?
        if rangeindex != nil {
            value = String(str[rangeindex!])
            //print(value!) //str.substring(with: rangeindex!)
            return value!
        }
        return ""
    }
}
