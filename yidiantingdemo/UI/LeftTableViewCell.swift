//
//  LeftTableViewCell.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/5.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCellWithIconArray(iconArray:NSArray,titleArray:NSArray,indexPath: NSIndexPath){
        leftImageView.image = UIImage.init(named: iconArray[indexPath.row] as! String);
        titleLabel.text = titleArray[indexPath.row] as? String;
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
