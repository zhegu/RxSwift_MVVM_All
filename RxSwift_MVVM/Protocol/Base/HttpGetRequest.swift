//
//  HttpGetRequest.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/19.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class HttpGetRequest: NSObject {
    let url:String
    let param:[String : String]
    let timeOut:Int
    
    init(url:String, param:[String : String], timeOut:Int) {
        self.url = url
        self.param = param
        self.timeOut = timeOut
        super.init()
    }
    
}
