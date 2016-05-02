//
//  LoginViewController.swift
//  RxSwift_MVVM
//
//  Created by lizhe on 16/4/21.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class LoginViewController: BaseViewController {
    
    let loginViewModel = LoginVM()
    let textFieldAccount:UITextField = UITextField(frame: CGRectMake(100,100,150,30))
    let textFieldPassword:UITextField = UITextField(frame: CGRectMake(100,140,150,30))
    let btn = UIButton(frame: CGRect(x: 120, y: 180, width: 50, height: 40));
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor();
        
        
        initLoginUI()
        initRxEvent()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLoginUI()->Void {
        
        textFieldAccount.placeholder = "请输入手机号"
        textFieldAccount.backgroundColor = UIColor.grayColor()
        view.addSubview(textFieldAccount)

       
        textFieldPassword.secureTextEntry = true
        textFieldPassword.backgroundColor = UIColor.grayColor()
        view.addSubview(textFieldPassword)
        
        
        btn.setTitle("login", forState: UIControlState.Normal);
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        btn.backgroundColor = UIColor.redColor()
        self.view.addSubview(btn);
    }
    
    func initRxEvent() -> Void {
        let accountOb = textFieldAccount.rx_text.map { (text) -> Observable<LegalResult> in
            return self.loginViewModel.legalAccount(text)
        }.switchLatest()
        .shareReplay(1)
        
        accountOb.subscribe {[unowned self] (event) in
            print("event:\(event)")
            //textFieldAccount.backgroundColor = event.element?.valid! == true ? UIColor.greenColor():UIColor.grayColor()
            self.refreshAccountUI((event.element?.valid!)!)
            
        }.addDisposableTo(disposeBag)
        
        let passwordOb = textFieldPassword.rx_text.map { [unowned self](text) -> Observable<LegalResult> in
            return self.loginViewModel.legalPassord(text)
        }.switchLatest()
        .shareReplay(1)
        
        passwordOb.subscribe { [unowned self] (event) in
//            self.textFieldPassword.backgroundColor = event.element?.valid! == true ? UIColor.greenColor():UIColor.grayColor()
            self.refreshPasswordUI((event.element?.valid)!)
        }.addDisposableTo(disposeBag)
        
        let combine = Observable.combineLatest(accountOb, passwordOb) { (account, password) -> Bool in
            //问题1： 在这个地方能对btn的属性进行设置， 但是是在这个地方还是在订阅的时候才进行设置（关于）
//            btn.enabled = (account.valid! && password.valid!)
//            
//            return btn.enabled
            return (account.valid! && password.valid!)
            
        }.subscribe { [unowned self](event) in
            //所有对UI的操作 应该是放在订阅的方法里面去执行，而不是在组合的
            
            self.btn.enabled = !(event.element)!
            
            self.refreshBtnUI(event.element!)
        }.addDisposableTo(disposeBag)
//        RxSwift.Just<(Swift.Optional<Swift.Bool>, Swift.Optional<Swift.String>)>
//        RxSwift.Just<(Swift.Optional<Swift.Bool>, Swift.Optional<Swift.String>)>

        
        btn.rx_controlEvent(.TouchUpInside).subscribeNext { [unowned self] (a) in
            print(a)
            self.login()
            
        }
    }
   
    
    func  login() -> Void {
        print("login")
        let tabBarVC = TabBarViewControlelr()
        
//        let tabBarVC = RxTableViewController()
        
//        let tabBarVC = ViewController()
        
        self.presentViewController(tabBarVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(tabBarVC, animated: true)
    }
    
    func refreshAccountUI(valid:Bool) -> Void {
        if valid {
            textFieldAccount.backgroundColor = UIColor.greenColor()
        } else {
            textFieldAccount.backgroundColor = UIColor.grayColor()
        }
    }
    
    func refreshPasswordUI(valid:Bool) -> Void {
        if valid {
            textFieldPassword.backgroundColor = UIColor.greenColor()
        } else {
            textFieldPassword.backgroundColor = UIColor.grayColor()
        }
    }
    
    func refreshBtnUI(valid:Bool) -> Void {
        if valid {
            btn.backgroundColor = UIColor.greenColor()
        } else {
            btn.backgroundColor = UIColor.grayColor()
        }
    }
    
    
}
