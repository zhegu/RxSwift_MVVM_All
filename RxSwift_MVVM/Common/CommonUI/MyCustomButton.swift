//
//  MyCustomButton.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/4/7.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class MyCustomButton: UIButton {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var rectImage:CGRect = CGRectZero
    var rectTitle:CGRect = CGRectZero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return rectImage
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return rectTitle
    }

    //myCustomButton使用方法
//    func useMethod()->Void {
//        let myButton = MyCustomButton(frame: CGRectMake(50,120,110,110))
//        myButton.setImage(UIImage(named: "about_logo"), forState: .Normal)
//        myButton.setTitle("哈哈哈哈哈哈", forState: .Normal)
//        myButton.titleLabel?.font = UIFont.systemFontOfSize(10)
//        myButton.backgroundColor = UIColor.blueColor()
//        myButton.rectImage = CGRectMake(0,0,20,20)
//        myButton.rectTitle = CGRectMake(25,20,50,50)
//        view.addSubview(myButton)
//    }
}
