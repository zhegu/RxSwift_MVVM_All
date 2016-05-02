//
//  ViewModel.swift
//  RxTableViewDemo
//
//  Created by Marco Sun on 16/4/28.
//  Copyright © 2016年 com.MarcoSun. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class ViewModel: NSObject {
    var users = [User(followersCount: 19_901_990, followingCount: 1990, screenName: "Marco Sun"),
                 User(followersCount: 19_890_000, followingCount: 1989, screenName: "Taylor Swift"),
                 User(followersCount: 250_000, followingCount: 25, screenName: "Rihanna"),
                 User(followersCount: 13_000_000_000, followingCount: 13, screenName: "Jolin Tsai"),
                 User(followersCount: 25_000_000, followingCount: 25, screenName: "Adele")]
    var section:[SectionModel<String, User>]?
    
//    var obs:Observable<[SectionModel<String, User>]>?
    
    var obs = PublishSubject<[SectionModel<String, User>]>()
    override init() {
        section = [SectionModel(model: "", items: users)]
        
        
        super.init()
    }
    
    func getUsers() -> Observable<[SectionModel<String, User>]> {
        
        obs.onNext(self.section!)
        
//        obs = Observable.create { (observer) -> Disposable in
//            
//            
//            observer.onNext(self.section!)
//            //            observer.onCompleted()
//            return AnonymousDisposable{}
//        }
        return obs
    }
    
    func btn () -> Void {
        obs.onNext(self.section!)
    }
    
    
    
    
    
    
}


