//
//  HotTableViewCell.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/3/13.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class HotTableViewCell: UITableViewCell {
    
    var viewImage:UIImageView?
    var labelName:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //        imageView_noRead = UIImageView.init()
//        label_name = UILabel.init()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func settingDataWithTitle(title:String?, image:UIImage?)->Void {
//        settingData(title, image: image)
//    }
    
    func settingData(title:String?,image:UIImage?)->Void {
        //显示title
        if labelName == nil {
            labelName = UILabel()
            labelName!.font = UIFont.boldSystemFontOfSize(Swift_text_size_small)
            labelName!.highlighted = true
            labelName!.backgroundColor = UIColor(white: 1, alpha: 1)
            self.contentView.addSubview(labelName!)
        }
        labelName!.text = title;
        //显示图片
        if viewImage == nil {
            viewImage = UIImageView(frame: CGRectMake(10, 0, 50, 50))
            self.contentView.addSubview(viewImage!)
        }
//        let myImage = image ?? UIImage(named: "照片")
//        if viewImage == nil {
//            viewImage = UIImageView(image: myImage)
//            self.contentView.addSubview(viewImage!)
//        } else {
//            resetImage(myImage!)
//        }
//        
//        let imageX = Swift_Left_TabelView_CellBorder
//        let imageY = Swift_Height_TabelView_CellBorder
//        viewImage?.frame = CGRect(x: imageX, y: imageY, width: 50, height: 50)
        
        let titleX:CGFloat = 70//CGRectGetMaxX((viewImage?.frame)!)
        let titleY:CGFloat = 10//imageY
        labelName?.frame = CGRect(x: titleX, y: titleY, width: Swift_SCR_W - titleX - Swift_Left_TabelView_CellBorder, height: 50)
        labelName?.sizeToFit()
        
    }
    
    func drawBottomLine() {
        let drawLabel:UILabel = UILabel(frame: CGRect(x: Swift_Left_TabelView_CellBorder, y: Swift_Height_Cell_ListAndHistory - 1, width: Swift_SCR_W - 2 * Swift_Left_TabelView_CellBorder, height: 0.5))
        drawLabel.backgroundColor = Swift_BottomLine
        self.contentView.addSubview(drawLabel)
    }
    
    func resetImage(image:UIImage)->Void {
        viewImage?.image = image
    }
}