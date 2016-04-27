//
//  LoginVM.swift
//  RxSwift_MVVM
//
//  Created by lizhe on 16/4/21.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import RxSwift
class LoginVM: BaseVM {
    
    
    // MARK: Creat Legal Events
    func legalAccount(account: String) -> Observable<LegalResult> {
        // 如果用户名为空
        if account.characters.count == 0 {
            return .just((false, StrAccountNotNull))
        }
        
        // 如果用户名中出现非法字符
        if account.rangeOfCharacterFromSet(NSCharacterSet.alphanumericCharacterSet().invertedSet) != nil {
            return .just((false, StrAccountOnlyNum))
        }
        
        if account.characters.count != 11 {
            return .just((false,StrAccountFormat))
        }
        
        return .just((true, StrLegal))
    }
    
    func legalPassord(password:String) -> Observable<LegalResult> {
        let length = password.characters.count
        if length == 0 {
            return .just((false,StrPasswordNotNull))
        }
        
        if length < 6 || length > 18 {
            return .just((false, StrPasswordNum))
        }
        
        return .just((true, StrLegal))
    }
    
    // MARK: Http Event
    
    
}
