//
//  TabBarViewControlelr.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/5.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class TabBarViewControlelr: UITabBarController,UITabBarControllerDelegate {
    
    var VC_ballDynamic:BallDynamicViewController?
    var VC_personInfo:PersonInfoViewController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        VC_ballDynamic = BallDynamicViewController()
        VC_personInfo = PersonInfoViewController()

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
   
        let nav_ballDynamic = UINavigationController(rootViewController: VC_ballDynamic!)
        nav_ballDynamic.tabBarItem = UITabBarItem(title: "动态", image: UIImage(named: "信息采集-已拍录像"), tag: 0)
        nav_ballDynamic.tabBarItem.badgeValue = "1";

        let nav_personInfo = UINavigationController(rootViewController: VC_personInfo!)
        nav_personInfo.tabBarItem = UITabBarItem(title: "个人信息", image: UIImage(named: "公告"), tag: 3)
        nav_personInfo.tabBarItem.badgeValue = "4";
        
        self.viewControllers = [nav_ballDynamic, nav_personInfo]

        self.view.backgroundColor = UIColor.whiteColor();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
