//
//  SearchCarTableViewCell.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/11.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class SearchCarTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillCellWithDataArray(dataArray:NSArray,indexPath: NSIndexPath) {
        let model = dataArray[indexPath.row] as! SearchModel;
        self.title.text = model.keyWord;
        self.subTitle.text = model.currentTime;
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
