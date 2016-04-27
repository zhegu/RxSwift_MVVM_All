//
//  MyWebViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/20.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class MyWebViewController: UIViewController {

    let webView:UIWebView
    let myStr:String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.backgroundColor = UIColor.redColor()
        loadWebPageWithString(myStr)
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(str:String?) {
//        url = NSURL(string: str)
        myStr = str ?? ""
        
        webView  =  UIWebView.init(frame: CGRect(x: 0, y: 0, width: SCR_W, height: SCR_H))
        super.init(nibName:nil, bundle:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadWebPageWithString(str:String)->Void {
        //        webView.scalespageToFit = YES;//自动对页面进行缩放以适应屏幕
        //        webView.detectsPhoneNumbers = true;//自动检测网页上的电话号码，单击可以拨打
        view.addSubview(webView)
        if let url = NSURL(string: myStr) {
            let  request = NSURLRequest(URL: url)
            webView.loadRequest(request)
            
        }
    }
}
