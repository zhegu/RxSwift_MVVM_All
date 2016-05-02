//
//  RxTableViewController.swift
//  RxTableViewDemo
//
//  Created by Marco Sun on 16/4/28.
//  Copyright © 2016年 com.MarcoSun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RxTableViewController: UIViewController {
    let tableView: UITableView = UITableView(frame: CGRectMake(0, 100, SCR_W, SCR_H - 100))
    let reuseIdentifier = "\(TableViewCell.self)"
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        dataSource.configureCell = {
            _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! TableViewCell
            cell.tag = indexPath.row
            cell.user = user
            return cell
        }
        
        viewModel.getUsers()
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
    
        let testBtn = UIButton(frame: CGRectMake(100,40,40,40))
        testBtn.setTitle("add", forState: .Normal)
        testBtn.backgroundColor = UIColor.redColor()
        testBtn.addTarget(self, action: #selector(RxTableViewController.addModel), forControlEvents: .TouchUpInside)
        view.addSubview(testBtn)
    
    }
    
    func addModel() -> Void {
        
        
        viewModel.users.append(User(followersCount: 1111111, followingCount: 1990, screenName: "Marco Sunlsz"))
        viewModel.section = [SectionModel(model: "", items: viewModel.users)]
        viewModel.btn()
//        tableView.reloadData()
//        tableView.reloadData()
    }
}
