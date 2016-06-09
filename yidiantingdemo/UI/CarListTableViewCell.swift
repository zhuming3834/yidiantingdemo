//
//  CarListTableViewCell.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/9.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class CarListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func cameBtnClick(sender: UIButton) {
        print("摄像机");
    }
    
    @IBAction func warnBtnClick(sender: UIButton) {
        print("警告");
    }
    
    
    
    @IBAction func callAKEBtnClick(sender: UIButton) {
         UIApplication.sharedApplication().openURL(NSURL.init(string: "tel:4006781146")!);
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
