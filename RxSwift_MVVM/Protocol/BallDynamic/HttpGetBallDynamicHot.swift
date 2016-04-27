//
//  HttpGetBallDynamicHot.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/29.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class HttpGetBallDynamicHot: HttpGetRequest {
    
    override init(url:String, param:[String : String], timeOut:Int) {
        
        super.init(url: url, param: param, timeOut: timeOut)
    }
    
    func request()->Void {
        Alamofire.request(.GET, url, parameters: ["limit": 20]).responseString{ (response) -> Void in
            if let result = response.result.value {
                let par = JSON.parse(result)
                print("res: \(par)")
                //                let datas = result.dataUsingEncoding(NSUTF8StringEncoding)!
                //                JSON(data: datas)
                if let m = par.arrayObject{
                    for data in m  {
                        if let hot:HotModel  = HotModel(dic: data as? NSDictionary) {
//                            self.modelArray.append(hot)
                        }
                    }
//                    self.myTableView.reloadData()
                }
                
            }
//            self.myTableView.mj_header.endRefreshing()
        }
    }
    
    
}
