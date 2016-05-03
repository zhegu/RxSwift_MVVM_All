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
    let hotVM = HotVM()
    
    let disposeBag = DisposeBag()
    
    let reuseIdentifier = "\(HotTableViewCell.self)"
    
    let myImage:UIImage? = UIImage(named: "照片")

    var test = Variable<Bool>(false)
    //MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        initRefresh()
        initTableView()
        hotVM.httpGetRequset(LoadDataByType.loadNew)

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
//        myTableView.allowsMultipleSelection = true;
        let reloadDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,HotModel>>()
        myTableView.rx_setDelegate(self)
        .addDisposableTo(disposeBag)
        
        
        myTableView.registerClass(HotTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        reloadDataSource.configureCell = {
            _, tableView, indexPath, hotModel in
            let cell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! HotTableViewCell
            cell.tag = indexPath.row
            cell.settingData(hotModel.ticket, image: nil)
            cell.viewImage?.sd_setImageWithURL(NSURL(string: hotModel.image_address!), placeholderImage: UIImage(named: "照片"), completed: { (imageDownload, httpError, SDImageCacheTypeMemory, httpUrl) -> Void in
                
                if httpError != nil {
                    print("httpError:\(httpError)")
                 
                }
            })
            
            return cell
        }
        
        hotVM.getHotModels().bindTo(myTableView.rx_itemsWithDataSource(reloadDataSource))
        .addDisposableTo(disposeBag)
        
        reloadDataSource.titleForHeaderInSection = {(section,str) in
            print(section)
            print(str)
            return section.sectionAtIndex(str).model
        }
        
        reloadDataSource.titleForFooterInSection = {(section,str) in
            print(section)
            print(str)
            return section.sectionAtIndex(str).model
        }
        
        myTableView
            .rx_modelSelected(HotModel)
            .subscribe { (event) in
                print(event.element)
                if let hot = event.element {
                    let webVC:MyWebViewController = MyWebViewController(str: hot.image_content)
                    self.navigationController?.pushViewController(webVC, animated: true)
                }
               
            }
            .addDisposableTo(disposeBag)

    }
    
    
    func initRefresh() -> Void {
        //设置下拉刷新，上拉加载
        myTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:#selector(HotViewController.loadNewData))
        myTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(HotViewController.loadMoreData))
        
        let leftObservesRight = hotVM.refreshTag.asObservable()
//            .bindTo(test)
            
//            .distinctUntilChanged()
            .bindNext({ (endRefresh) in
                if endRefresh == true {
                    if self.myTableView.mj_header.isRefreshing() {
                        self.myTableView.mj_header.endRefreshing()
                    }
                    if self.myTableView.mj_footer.isRefreshing() {
                        self.myTableView.mj_footer.endRefreshing()
                    }
                }
            })
            .addDisposableTo(disposeBag)
        

        
//        hotVM.refreshTag.subscribeNext { [unowned self](endRefresh) in
//            if endRefresh == true {
//                if self.myTableView.mj_header.isRefreshing() {
//                    self.myTableView.mj_header.endRefreshing()
//                }
//                if self.myTableView.mj_footer.isRefreshing() {
//                    self.myTableView.mj_footer.endRefreshing()
//                }
//            }
//        }.addDisposableTo(disposeBag)
        
        //        myTableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: "loadMoreData")
       
    }
   
    func loadNewData()->Void {
        hotVM.httpGetRequset(.loadNew)
        
    }
    
    func loadMoreData()->Void {
        if (!hotVM.isLastDataFromNet) {
            hotVM.httpGetRequset(.loadMore)
        } else {
            self.myTableView.mj_footer.endRefreshingWithNoMoreData()
        }
        
    }
    
    func addModel() -> Void {
        
        print("press btn")
    }
}

