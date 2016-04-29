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
import RxCocoa
import RxSwift
import RxDataSources
//typealias NumberSection = SectionModelType<String, Int>

class HotViewController: BaseViewController,UITableViewDelegate {
    let myTableView:UITableView = UITableView(frame: CGRectMake(0, 0, Swift_SCR_W, Swift_SCR_H-NAVIGATION_HEIGHT - SEGMENT_HEIGHT * 2))
    var myImage:UIImage? = UIImage(named: "照片")
//    let url = "http://115.159.101.179:10086/dongtai/recommend&cells&1234567"
    let url = "http://120.76.130.252:10086/dongtai/recommend&cells&1234567"
    
    let urlAddress = "http://120.76.130.252:10086/dongtai/cells/recommend"
    
    var modelArray:[HotModel] = Array()
    var requestCount:Int = 0
    var isLastDataFromNet:Bool = false
    let limit:Int = 20
    
    let hotVM = HotVM()
    
    let disposeBag                                  = DisposeBag()
    var rxHotModelSource: Variable<HotModel?>   = Variable(nil)
    
    var rxModelArray:Observable<RxViewModelHot>?
    //MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()

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
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        view.addSubview(myTableView)
        view.backgroundColor = UIColor(white: 1, alpha: 1)
        myTableView.rowHeight = Swift_Height_Cell_ListAndHistory
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
   let testBtn = UIButton(frame: CGRectMake(300,20,40,40))
    testBtn.setTitle("add", forState: .Normal)
        testBtn.backgroundColor = UIColor.redColor()
        testBtn.addTarget(self, action: #selector(HotViewController.addModel), forControlEvents: .TouchUpInside)
        view.addSubview(testBtn)
        let reloadDataSource = RxTableViewSectionedReloadDataSource<HotModel>()
        myTableView.rx_setDelegate(self)
        .addDisposableTo(disposeBag)
        
        
        
        
        
        
        
        hotVM.rxModelArray!.subscribeNext { (hot) in
            print(hot)
        }
        
        hotVM.rxModelArray!
            .bindTo(myTableView.rx_itemsWithCellIdentifier("pasteCell", cellType: UITableViewCell.self)) { (row, element, cell) in
                
                print("row \(row)")
                print("element \(element)")
                print("cell \(cell)")
//                switch element {
//                case .Text(let string):
//                    cell.textLabel?.text = String(string)
//                case .Image(let image):
//                    cell.imageView?.image = image
//                }
            }
                .addDisposableTo(disposeBag)
        
        return

    }
   
    
    func addModel() -> Void {
        print("press btn")
    }
}

