//
//  Common.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/5.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import Foundation
import UIKit
/** 屏幕尺寸 */
let SCR_BOUNDS = UIScreen.mainScreen().bounds
/** 屏幕尺寸 */
let SCR_SIZE = UIScreen.mainScreen().bounds.size
/** 屏幕宽度 */
let SCR_W = UIScreen.mainScreen().bounds.size.width
/** 屏幕高度 */
let SCR_H = UIScreen.mainScreen().bounds.size.height

let NAVIGATION_HEIGHT:CGFloat = 64.0

let SEGMENT_HEIGHT:CGFloat = 44.0

let TAPBAR_HEIGHT:CGFloat = 44.0

let Swift_SCR_Bounds    = UIScreen.mainScreen().bounds
let Swift_SCR_Size      = UIScreen.mainScreen().bounds.size
let Swift_SCR_W         = UIScreen.mainScreen().bounds.size.width
let Swift_SCR_H         = UIScreen.mainScreen().bounds.size.height

//自定义颜色
let Swift_BlueColor     = UIColor(red: 0.45, green: 0.68, blue: 0.97, alpha: 1.0)
let Swift_OrangeColor   = UIColor(red: 255.0/255.0, green: 108.0/255.0, blue: 0, alpha: 1.0)
let Swift_BottomLine    = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha:1)

let Swift_NUM_LIMIT              = 20

let Swift_REQUEST_TAG_REFRESH    = 100
let Swift_REQUEST_TAG_MORE       = 200

//UI高度布局
let Swift_NAVIGATION_HEIGHT:CGFloat = 64.0
let Swift_TABBAR_HEIGHT:CGFloat     = 49.0

let Swift_Left_TabelView_CellBorder:CGFloat = 15
let Swift_Height_TabelView_CellBorder:CGFloat = 5
let Swift_Base_TabelView_CellBorder:CGFloat = 5

let Swift_Height_Cell_ListAndHistory:CGFloat = 60.0

//自定义字体大小
let Swift_text_size_huge:CGFloat    = 22.0
let Swift_text_size_large:CGFloat   = 18.0
let Swift_text_size_normal:CGFloat  = 16.0
let Swift_text_size_small:CGFloat   = 14.0
let Swift_text_size_smaller:CGFloat = 12.0
let Swift_text_size_tiny:CGFloat    = 10.0

//列表刷新加载的类型
enum LoadDataByType {
    case loadNew
    case loadMore
}

