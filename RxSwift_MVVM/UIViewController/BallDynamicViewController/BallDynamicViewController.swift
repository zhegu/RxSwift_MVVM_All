//
//  BallDynamicViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/5.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import HMSegmentedControl
class BallDynamicViewController: BaseViewController {
    var HMSegmentedCtrl:HMSegmentedControl? = nil
    var containView:UIView? = nil
    let hotViewController:HotViewController? = HotViewController();
    let newsViewController:NewsViewController? = NewsViewController();
    var currentViewController:UIViewController? = nil
    var myIndexBlock :IndexChangeBlock? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        self.title = "动态"
        self.view.backgroundColor = UIColor(white: 1, alpha: 1)
        self.automaticallyAdjustsScrollViewInsets = false
        self.setMyBlock()
        self.initHMSegmentedCtrl()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - init
    func initHMSegmentedCtrl() {
        
        let items = ["热门","新闻"]
        HMSegmentedCtrl = HMSegmentedControl(sectionTitles: items)
        HMSegmentedCtrl!.frame = CGRectMake(0, Swift_NAVIGATION_HEIGHT, Swift_SCR_W, 44)
        HMSegmentedCtrl!.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
//        HMSegmentedCtrl!.backgroundColor = UIColor.whiteColor()
        //设置导航标题的颜色及字体大小
        let dic:Dictionary = Dictionary(dictionaryLiteral: (NSForegroundColorAttributeName, UIColor.blackColor()))
        HMSegmentedCtrl!.titleTextAttributes = dic;
        let dicChoose:Dictionary = Dictionary(dictionaryLiteral: (NSForegroundColorAttributeName, Swift_BlueColor))
        HMSegmentedCtrl!.selectedTitleTextAttributes = dicChoose
        HMSegmentedCtrl!.selectionIndicatorColor = Swift_BlueColor //选中横线的颜色
        HMSegmentedCtrl!.selectionIndicatorHeight = 3; //选择的下面那一条横线
        HMSegmentedCtrl!.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        HMSegmentedCtrl!.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        HMSegmentedCtrl!.verticalDividerEnabled = true;
        HMSegmentedCtrl!.verticalDividerColor = UIColor(white: 1, alpha: 1);
        
        containView = UIView(frame: CGRectMake(0, 44+Swift_NAVIGATION_HEIGHT, Swift_SCR_W, Swift_SCR_H-44-Swift_NAVIGATION_HEIGHT));
        
        self.view.addSubview(containView!)
        self.view.addSubview(HMSegmentedCtrl!)
        
        self.addChildViewController(hotViewController!)
        self.addChildViewController(newsViewController!)
        containView?.addSubview(hotViewController!.view)
        currentViewController = hotViewController!

        HMSegmentedCtrl!.indexChangeBlock = myIndexBlock
        
    }

    func setMyBlock()->Void {
        weak var controller:BallDynamicViewController? = self
        myIndexBlock = {
            (index:Int) in
            var to : UIViewController?;
            if (0 == index) {
                to = controller!.hotViewController!;
            }else if (1 == index){
                to = controller!.newsViewController!;
            }
            controller!.transitionFromViewController (
                controller!.currentViewController!,
                toViewController: to!,
                duration: 0,
                options: UIViewAnimationOptions.TransitionNone,
                animations: { () -> Void in
                    
                },
                completion: { ( finished ) -> Void in
                    if finished {
                        controller?.currentViewController = to
                    }
                }
            )
        }
    }
    

}
