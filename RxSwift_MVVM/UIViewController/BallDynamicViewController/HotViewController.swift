//
//  HotViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/10.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh
import SDWebImage
class HotViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    let myTableView:UITableView = UITableView(frame: CGRectMake(0, 0, Swift_SCR_W, Swift_SCR_H-NAVIGATION_HEIGHT - SEGMENT_HEIGHT * 2))
    var myImage:UIImage? = UIImage(named: "照片")
//    let url = "http://115.159.101.179:10086/dongtai/recommend&cells&1234567"
    let url = "http://120.76.130.252:10086/dongtai/recommend&cells&1234567"
    
    let urlAddress = "http://120.76.130.252:10086/dongtai/cells/recommend"
    
    var modelArray:[HotModel] = Array()
    var requestCount:Int = 0
    var isLastDataFromNet:Bool = false
    let limit:Int = 20
    
    //MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        httpGetRequset(.loadNew)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - initMethod
    func initTableView()->Void {
        myTableView.delegate = self
        myTableView.dataSource = self
        //        myTableView.rowHeight = Swift_Height_Cell_ListAndHistory
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        view.addSubview(myTableView)
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        
        //设置下拉刷新，上拉加载
        myTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:"loadNewData")
        
//        myTableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: "loadMoreData")
        myTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "loadMoreData")
    }
   //http:// 120.76.130.252:10086/dongtai/cells/module&flag&num&ticket
    //MARK: - HttpRequest
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
        Alamofire.request(.GET, urlLast, parameters: nil).validate().responseString{ (response) -> Void in
            
            if response.result.isSuccess == true {
                if let result = response.result.value {
                    let par = JSON.parse(result)
                    print("res: \(par)")
//                    let datas = result.dataUsingEncoding(NSUTF8StringEncoding)!
//                    JSON(data: datas)
                    if let m = par.arrayObject{
                        if m.count < self.limit {
                            self.isLastDataFromNet = true
                        }
                        for data in m  {
                            if let hot:HotModel  = HotModel(dic: data as? NSDictionary) {
                                self.modelArray.append(hot)
                            }
                        }
                        self.myTableView.reloadData()
                    }
                }
            } else {
                print(response.result.error)
            }
            self.myTableView.mj_header.endRefreshing()
        }
    }
    
    //MARK:-
    //MARK:UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  modelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var myCell:HotTableViewCell? = tableView.dequeueReusableCellWithIdentifier("HotTableViewCell") as? HotTableViewCell
    
        if myCell == nil {
            myCell = HotTableViewCell(style: .Default, reuseIdentifier: "HotTableViewCell")
            myCell?.selectionStyle = .None
            myCell?.drawBottomLine()
        }
        let hot = modelArray[indexPath.row]
        myCell?.settingData(hot.ticket, image: nil)
        myCell?.viewImage?.sd_setImageWithURL(NSURL(string: hot.image_address!), placeholderImage: UIImage(named: "照片"), completed: { (imageDownload, httpError, SDImageCacheTypeMemory, httpUrl) -> Void in
            if httpError != nil {
                print("\(indexPath.row): \(imageDownload)")
                if (imageDownload == nil) {
                    myCell?.viewImage?.image = self.myImage
                } else {
                    myCell?.viewImage?.image = imageDownload
                }
            }
        })
        return  myCell!
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    //MARK:UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hot:HotModel = modelArray[indexPath.row]
//        let webVC:MyWebViewController = MyWebViewController(str: hot.image_content!)
//        let string = "http://www.jianshu.com/p/6e5c0f78200a"
        
        let webVC:MyWebViewController = MyWebViewController(str: hot.image_content)
        self.navigationController?.pushViewController(webVC, animated: true)

    }
    
    //MARK: MJRefresh
    func loadNewData()->Void {
        httpGetRequset(.loadNew)
        
    }
    
    func loadMoreData()->Void {
        if (!isLastDataFromNet) {
           httpGetRequset(.loadMore)
        } else {
            self.myTableView.mj_footer.endRefreshingWithNoMoreData()
        }
        
    }
}

