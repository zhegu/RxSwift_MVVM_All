//
//  FolkViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/10.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class FolkViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 40, y: 100, width: 50, height: 40));
        btn.setTitle("Folk", forState: UIControlState.Normal);
        btn.backgroundColor = UIColor.redColor()
        //        btn.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside);
        //        btn.addTarget(target: AnyObject?, action: Selector, forControlEvents: <#T##UIControlEvents#>)
        self.view.addSubview(btn);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
