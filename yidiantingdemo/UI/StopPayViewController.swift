//
//  StopPayViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/7.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class StopPayViewController: UIViewController {

    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var carNumLabel: UILabel!
    
    @IBOutlet weak var carBgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView();
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        regionLabel.layer.borderWidth = 2;
        regionLabel.layer.borderColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).CGColor;
        
        carBgView.layer.borderWidth = 2;
        carBgView.layer.borderColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).CGColor;
        
    }
    
    
    
    @IBAction func delteBtnClick(sender: UIButton) {
        print("删除");
    }
    
    @IBAction func searchBtnClick(sender: UIButton) {
        print("搜索");
    }
    
    @IBAction func carRegionTap(sender: UITapGestureRecognizer) {
        print("地区");
    }
    
    @IBAction func carNumTap(sender: UITapGestureRecognizer) {
        print("车牌号");
    }
    
    

    @IBAction func navBackBtnClick(sender: UIButton) {
        let caTrans = CATransition();
        caTrans.duration = 0.35;
        caTrans.type = kCATransitionPush;
        caTrans.subtype = kCATransitionFromLeft;
        self.view.window?.layer.addAnimation(caTrans, forKey: nil);
        
        self.dismissViewControllerAnimated(false) {
            
        }
    }
    
    @IBAction func navRightBtnClick(sender: UIButton) {
        print("刷新");
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
