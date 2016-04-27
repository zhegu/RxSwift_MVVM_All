//
//  LeagueViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/5.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import HMSegmentedControl
class LeagueViewController: BaseViewController {
    var HMSegmentedCtrl:HMSegmentedControl? = nil
    var containView:UIView? = nil
    var myIndexBlock :IndexChangeBlock? = nil
    let inSchoolVC:LeagueInSchoolViewController? = LeagueInSchoolViewController()
    let outSchoolVC:LeagueOutSchoolViewController? = LeagueOutSchoolViewController()
    let mySelfVC:LeagueMyselfViewController? = LeagueMyselfViewController()
    var currentViewController:UIViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initHMSegmentedCtrl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initHMSegmentedCtrl() {
        //        let myNewTask:String = "待办任务";
        //        let myFinishedTask:String  = "已办任务";
        let items = ["热门","新闻","NBA","CBA","民间","装备","拉拉队"]
        HMSegmentedCtrl = HMSegmentedControl(sectionTitles: items)
        HMSegmentedCtrl!.frame = CGRectMake(0, Swift_NAVIGATION_HEIGHT, Swift_SCR_W, 44)
        HMSegmentedCtrl!.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
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
        
        self.addChildViewController(inSchoolVC!)
        self.addChildViewController(outSchoolVC!)
        self.addChildViewController(mySelfVC!)
        
        
        containView?.addSubview(inSchoolVC!.view)
        currentViewController = inSchoolVC!
        HMSegmentedCtrl!.indexChangeBlock = myIndexBlock
        
    }
    
    func setMyBlock()->Void {
        weak var controller:LeagueViewController? = self
        myIndexBlock = {
            (index:Int) in
            var to : UIViewController?;
            if (0 == index) {
                to = controller!.inSchoolVC!;
            }else if (1 == index){
                to = controller!.outSchoolVC!;
            }else if (2 == index) {
                to = controller!.mySelfVC!
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
