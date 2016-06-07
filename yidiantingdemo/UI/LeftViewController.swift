//
//  LeftViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/5.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var headImage: UIImageView!
    
    @IBOutlet weak var carLabel: UILabel!
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var rightView: UIView!
    
    let viewController = ViewController();
    
    let iconArray = ["icon_tingche","icon_jiaoyi","icon_star","icon_message","icon_tuijian","icon_youhuijuan","icon_setting"];
    
    let titleArray = ["停车记录","交易流水","有奖活动","消息中心","好友推荐","优惠劵","设置"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rightView.backgroundColor = UIColor.init(red: 236/255, green: 236/255, blue: 236/255, alpha: 0.2);
        
        self.tableView.registerNib(UINib(nibName: "LeftTableViewCell", bundle:nil), forCellReuseIdentifier: "LeftTableViewCell");
        self.tableView.separatorStyle = .None;
        
        // Do any additional setup after loading the view.
    }
    
    
    // 充值按钮点击事件
    @IBAction func btnClick(sender: UIButton) {
    }
    
    // 收起侧边栏
    @IBAction func tapClick(sender: UITapGestureRecognizer) {
        print("tap");
        
        self.rightView.hidden = true;
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            }, completion: { (finsih) in
               self.rightView.hidden = false;
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconArray.count;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // 底部 背景视图
        let bgView = UIView.init(frame: CGRectMake(0, 0, self.tableView.frame.size.width, 44));
        bgView.backgroundColor = UIColor.clearColor();
        //联系客服
        let kfLabel = UILabel.init(frame: CGRectMake(20, 0, 70, 44));
        kfLabel.text = "联系客服";
        bgView.addSubview(kfLabel);
        // 4006781146电话
        let telLabel = UILabel.init(frame: CGRectMake(90, 0, 75, 44));
        telLabel.text = "4006781146";
        telLabel.textAlignment = .Right;
        telLabel.font = UIFont.systemFontOfSize(12);
        bgView.addSubview(telLabel);
        // 拨打电话按钮
        let telButton = UIButton.init(frame: CGRectMake(self.tableView.frame.size.width - 35, 12, 20, 20));
        telButton.setImage(UIImage.init(named: "icon_cellphone"), forState: UIControlState.Normal);
        telButton.addTarget(self, action: #selector(LeftViewController.btnClick as (LeftViewController) -> () -> ()), forControlEvents: UIControlEvents.TouchUpInside)
        bgView.addSubview(telButton);
        
        return bgView;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identify:String = "LeftTableViewCell"
        let cell:LeftTableViewCell = tableView.dequeueReusableCellWithIdentifier(identify) as! LeftTableViewCell
        cell.fillCellWithIconArray(iconArray, titleArray: titleArray, indexPath: indexPath);
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)");
    }
    
    func btnClick() {
        print("4006781146");
        UIApplication.sharedApplication().openURL(NSURL.init(string: "tel:4006781146")!);
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
