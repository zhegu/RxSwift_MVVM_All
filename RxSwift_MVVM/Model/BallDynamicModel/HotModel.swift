//
//  HotModel.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/13.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import RxDataSources

//public struct SectionModel<Section, ItemType>
//    : SectionModelType
//, CustomStringConvertible {
//    public typealias Identity = Section
//    public typealias Item = ItemType
//    public var model: Section
//    
//    public var identity: Section {
//        return model
//    }
//    
//    public var items: [Item]
//    
//    public init(model: Section, items: [Item]) {
//        self.model = model
//        self.items = items
//    }
//    
//    public var description: String {
//        return "\(self.model) > \(items)"
//    }
//}
//
//extension SectionModel {
//    public init(original: SectionModel<Section, Item>, items: [Item]) {
//        self.model = original.model
//        self.items = original.items
//    }
//}

class HotModel:NSObject {
    var image_address:String?
    var image_content:String?
    var ticket:String?
    var time:NSDate?
    
//    public var items: [Item]
    
//    public init(model: Section, items: [Item]) {
//        self.model = model
//        self.items = items
//    }
    
    init (dic:NSDictionary?) {
        if let myDic = dic {
            image_address = myDic["image_address"] as? String ?? ""
            image_content = myDic["image_content"] as? String ?? ""
            ticket        = myDic["ticket"] as? String ?? ""
            time          = NSDate()
        }
        super.init()
    }
    
    func initWithMyDic(dic:NSDictionary?)->Void {
        
        if let myDic = dic {
            image_address = myDic["image_address"] as? String ?? ""
            image_content = myDic["image_content"] as? String ?? ""
            ticket        = myDic["ticket"] as? String ?? ""
            time          = NSDate()
//            if let address = myDic["image_address"] {
//                image_address = address as! String
//            }
        }
        
    }
    
    //    - (void)loadWebPageWithString:(NSString*)urlString
    //    {
    //    1、创建UIWebView：
    //
    //    CGRect bouds = [[UIScreen manScreen]applicationFrame];
    //    UIWebView* webView = [[UIWebView alloc]initWithFrame:bounds];
    //
    //    2、设置属性：
    //
    //    webView.scalespageToFit = YES;//自动对页面进行缩放以适应屏幕
    //    webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    //
    //    3、显示网页视图UIWebView：
    //
    //    [self.view addSubview:webView];
    //
    //    4、加载内容
    //
    //    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];//创建URL
    //    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    //    [webView loadRequest:request];//加载
    //    }
    
}
