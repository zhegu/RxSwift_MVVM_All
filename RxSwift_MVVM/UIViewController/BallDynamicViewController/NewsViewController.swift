//
//  NewsViewController.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/6.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MJRefresh
import SDWebImage
import RxCocoa
import RxSwift

class NewsViewController: BaseViewController,UITableViewDelegate {
    let tableView:UITableView = UITableView(frame: CGRectMake(0, 0, Swift_SCR_W, Swift_SCR_H-NAVIGATION_HEIGHT - SEGMENT_HEIGHT * 2))

//    let dataSource = RxTableViewSectionedReloadDataSource<HotModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dataSource = self.dataSource
//        
//        let items = Observable.just([
//            SectionModel(model: "First section", items: [
//                1.0,
//                2.0,
//                3.0
//                ]),
//            SectionModel(model: "Second section", items: [
//                1.0,
//                2.0,
//                3.0
//                ]),
//            SectionModel(model: "Second section", items: [
//                1.0,
//                2.0,
//                3.0
//                ])
//            ])
        
//        dataSource.configureCell = { (_, tv, indexPath, element) in
//            let cell = tv.dequeueReusableCellWithIdentifier("Cell")!
//            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
//            return cell
//        }
        
//        items
//            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
//            .addDisposableTo(disposeBag)
//        
//        tableView
//            .rx_itemSelected
//            .map { indexPath in
//                return (indexPath, dataSource.itemAtIndexPath(indexPath))
//            }
//            .subscribeNext { indexPath, model in
//                DefaultWireframe.presentAlert("Tapped `\(model)` @ \(indexPath)")
//            }
//            .addDisposableTo(disposeBag)
//        
//        tableView
//            .rx_setDelegate(self)
//            .addDisposableTo(disposeBag)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
//        label.text = dataSource.sectionAtIndex(section).model ?? ""
        return label
    }



}
