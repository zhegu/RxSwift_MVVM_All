//
//  HotMV.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/30.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON
import RxDataSources

class HotVM: BaseVM {
    let disposeBage = DisposeBag()
    
    let url = "http://120.76.130.252:10086/dongtai/recommend&cells&1234567"
    
    let urlAddress = "http://120.76.130.252:10086/dongtai/cells/recommend"
    
    var modelArray:[HotModel] = Array()
    
    var requestCount:Int = 0
    var isLastDataFromNet:Bool = false
    let limit:Int = 2
    var obs = PublishSubject<[SectionModel<String, HotModel>]>()
    var section:[SectionModel<String, HotModel>]?
    
    var refreshTag = PublishSubject<Bool>()
    
    override init() {

        super.init()
    }
    
    
    func httpGetRequset(type:LoadDataByType)->Void {
        
        var dic:[String:AnyObject]
        var refreshTicket:String = "0"
        var urlLast:String
        if type == .loadNew {
            
            if modelArray.count == 0 {
                refreshTicket = "0"
            } else  {
                let hot = modelArray[0]
                refreshTicket = (hot.ticket)!
            }
            
            urlLast = "\(urlAddress)&0&\(limit)&\(refreshTicket)"
            dic = ["type":0, "ticket":refreshTicket,"limit":limit]
        } else {
            if modelArray.count != 0 {
                let hot = modelArray.last
                refreshTicket = (hot!.ticket)!
            }
            
            dic = ["type":1, "ticket":refreshTicket,"limit":limit]
            urlLast = "\(urlAddress)&1&\(limit)&\(refreshTicket)"
        }
        
        RxAlamofire.requestJSON(.GET, urlLast)
        .observeOn(MainScheduler.instance)
//        .debug()
        .subscribe(onNext: { [unowned self](response, json) in
            print("response:\(response)")
            print("json:\(json)")
            
                if let array = json as? [AnyObject] {
                    if array.count < self.limit {
                        self.isLastDataFromNet = true
                    }
                    
                    if type == .loadNew {
                        self.modelArray.removeAll()
                    }
                    
                    for data in array {
                        if let hot:HotModel  = HotModel(dic: data as? NSDictionary) {
                            self.modelArray.append(hot)
                        }
                    }
                    self.stopRefreshAnimation()
                    self.refreshData()
                    
                }
            }, onError: { (error)->Void in
                print("error:\(error)")

            }) .addDisposableTo(disposeBage)
    }
    
    func getHotModels() -> Observable<[SectionModel<String, HotModel>]> {
        

        section = [SectionModel(model: "", items: self.modelArray)]
        return obs
        
    }
    
    func getRefreshTag() -> Observable<Bool> {
        return refreshTag
    }
    
    func refreshData() -> Void {
        section = [SectionModel(model: "", items: self.modelArray)]
        obs.onNext(section!)
    }
    
    func stopRefreshAnimation() -> Void {
        refreshTag.onNext(true)
    }
}
