//
//  PersonInfoViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/5.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import AnimatedSegmentSwitch
class PersonInfoViewController: BaseViewController {
    var segment:UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let segmentedSwitch = AnimatedSegmentSwitch()
        segmentedSwitch.frame = CGRect(x: 0, y: NAVIGATION_HEIGHT, width: SCR_W, height: SEGMENT_HEIGHT)
        segmentedSwitch.autoresizingMask = [.FlexibleWidth]
        segmentedSwitch.backgroundColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1)
        segmentedSwitch.selectedTitleColor = UIColor(red: 85.0/255.0, green: 172.0/255.0, blue: 238.0/255.0, alpha: 1)
        segmentedSwitch.titleColor = .whiteColor()
        segmentedSwitch.font = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
        segmentedSwitch.thumbColor = .whiteColor()
        segmentedSwitch.items = ["Week", "Month", "Year"]
        segmentedSwitch.addTarget(self, action: "segmentValueDidChange:", forControlEvents: .ValueChanged)
        
        view.addSubview(segmentedSwitch)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segmentValueDidChange(ind:AnyObject)->Void {
        print("num is \(ind)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
