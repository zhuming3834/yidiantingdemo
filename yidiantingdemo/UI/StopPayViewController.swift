//
//  StopPayViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/7.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class StopPayViewController: UIViewController ,InputViewDelegate,InputView2Delegate,InputView3Delegate,CarListViewControllerDelegate{

    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var carNumLabel: UILabel!
    
    @IBOutlet weak var carBgView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var topBgView: UIView!
    
    var regionStr1 = "";
    var regionStr2 = "";
    var numStr = "";
    
    var carNumView: UIView!; // 车牌显示区域
    var bgView: UIView!; // 影藏上不的隐
    
    var carListViewController: CarListViewController? = nil; // 车牌信息列表
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        initView();
        
        setMyCarNum();
        
        setCarListView();
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        regionLabel.layer.borderWidth = 2;
        regionLabel.layer.borderColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).CGColor;
        
        carBgView.layer.borderWidth = 2;
        carBgView.layer.borderColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1).CGColor;
        
    }
    
    /**
     设置我的车辆的 车牌显示部分
     */
    func setMyCarNum() {
        var height = 0;
        
        carNumView = UIView();
        carNumView.backgroundColor = UIColor.whiteColor();
        carNumView.layer.shadowOffset = CGSizeMake(0, 2);
        carNumView.layer.shadowColor = UIColor.grayColor().CGColor;
        carNumView.layer.shadowOpacity = 1.0;
        carNumView.layer.cornerRadius = 3;
        
        bottomView.addSubview(carNumView);
        
        // 盖住carNumView的上阴影
        bgView = UIView.init(frame: CGRectMake(0, 55 + 64, self.view.frame.size.width, 10))
        bgView.backgroundColor = UIColor.whiteColor();
        self.view.addSubview(bgView);
        
        
        let myLabel = UILabel.init(frame: CGRectMake(10, 0, self.view.frame.size.width - 10, 30));
        myLabel.text = "我的车辆";
        myLabel.textColor = UIColor.grayColor();
        myLabel.font = UIFont.systemFontOfSize(14);
        carNumView.addSubview(myLabel);
    
        let width = (self.view.frame.size.width - 50)/4;
        
        // 总的车牌个数
        let count = 11;
        
        let lie = 4; // 4列
        let hang = (count + lie - 1)/lie; // 行数的计算
        print("hang = \(hang)");
        
        height = 30 + 30*hang; // 计算总的高度
        
        for i in 0...(hang - 1) {
            for j in 0...3 {
                
                let index = (lie*i) + j;
                if index < count {
                    let label = UILabel.init(frame: CGRectMake(10 + CGFloat(CGFloat(j)*(width + 10)), CGFloat(30 * (i + 1)), width, 20));
                    label.text = "粤B07X23";
                    label.font = UIFont.systemFontOfSize(11);
                    label.textAlignment = .Center;
                    label.userInteractionEnabled = true;
                    label.backgroundColor = UIColor.init(red: 42/255, green: 222/255, blue: 199/255, alpha: 1);
                    label.layer.shadowOffset = CGSizeMake(2, 2);
                    label.layer.shadowColor = UIColor.grayColor().CGColor;
                    label.layer.shadowOpacity = 1.0;
                    carNumView.addSubview(label);
                    
                    let tap = UITapGestureRecognizer();
                    tap.addTarget(self, action: #selector(StopPayViewController.carNumTap as (StopPayViewController) -> () -> ()));
                    label.addGestureRecognizer(tap);
                    
                }
            }
        }
        
        carNumView.frame = CGRectMake(0, 0, self.view.frame.size.width, CGFloat(height));
    }
    
    func setCarListView() {
        
        carListViewController = CarListViewController();
        self.addChildViewController(carListViewController!);
        carListViewController!.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
        self.view.addSubview(carListViewController!.view);
        carListViewController?.delegate = self;
        carListViewController!.view.hidden = true;
    }
    
    
    // 车牌点击事件
    func carNumTap() {
        print("ss");
        carListViewController!.view.hidden = false;
    }
    
    func otherBtnClick() {
        carListViewController!.view.hidden = true;
    }
    
    
    
    @IBAction func delteBtnClick(sender: UIButton) {
        print("删除");
    }
    
    @IBAction func searchBtnClick(sender: UIButton) {
        print("搜索");
    }
    
    @IBAction func carRegionTap(sender: UITapGestureRecognizer) {
        print("地区");
        let inputView = InputView().addInputView(self.view);
        inputView.tag = 1;
        inputView.delegate = self;
    }
    
    @IBAction func carNumTap(sender: UITapGestureRecognizer) {
        print("车牌号");
        let inputView = InputView3().addInputView(self.view);
        inputView.tag = 3;
        inputView.delegate = self;
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
    
    
    func getInputViewString(inputString: String) {
        
        regionStr1 = inputString;
        regionLabel.text = regionStr1 + " " + regionStr2;
        
        if regionStr1.characters.count == 1{
            var oldView = self.view.viewWithTag(1);
            oldView?.removeFromSuperview();
            oldView = nil;
            
            let inputView = InputView2().addInputView(self.view);
            inputView.tag = 2;
            inputView.delegate = self;
            
        }
    }
    
    func getInputView2String(inputString: String) {
    
        regionStr2 = inputString;
    
        regionLabel.text = regionStr1 + " " + regionStr2;
        if regionLabel.text?.characters.count == 3 {
            
            var oldView = self.view.viewWithTag(2);
            oldView?.removeFromSuperview();
            oldView = nil;

            let inputView = InputView3().addInputView(self.view);
            inputView.tag = 3;
            inputView.delegate = self;
        }
    }

    func getInputView3String(inputString: String) {
        
        if carNumLabel.text?.characters.count < 9 {
            carNumLabel.text = carNumLabel.text! + " " + inputString;
        }
        print("carNumLabel.text = \(carNumLabel.text)");
        print("carNumLabel.text = \(carNumLabel.text?.characters.count)");
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
