//
//  LeagueTableViewCell.swift
//  MyBasketBallProject
//
//  Created by lizhe on 16/4/8.
//  Copyright © 2016年 lizhe. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    var labelTitle:UILabel?
    var leagueTeamNumMax:Int?
    var leagueTeamNumNow:Int?
    var labelTeamNum:UILabel?
    var leagueType:Int?     //1:全场 3v3  2：全场 5v5 3：半场3v3
    var labelType:UILabel?
    var leagueStartTime:NSDate?
    var leagueEndTime:NSDate?
    var labelTime:UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingData(title:String,teamNum:Int,teamNumMax:Int=10,leagueType:Int,startTime:NSDate,endTime:NSDate)->Void {
        
        if labelTitle == nil {
            labelTitle = UILabel()
            labelTitle!.font = UIFont.boldSystemFontOfSize(Swift_text_size_small)
            labelTitle!.backgroundColor = UIColor(white: 1, alpha: 1)
            self.contentView.addSubview(labelTitle!)
        }
        
    }
    
}
