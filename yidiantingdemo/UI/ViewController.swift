//
//  ViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/4.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var searchButton1: UIButton!
    
    @IBOutlet weak var searchButton2: UIButton!
    
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var liyuButton: UIButton!
    
    var leftViewController: LeftViewController? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        leftViewController = LeftViewController();
        
        leftViewController!.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        self.addChildViewController(leftViewController!);
        
        
        self .initView();
        
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 72/255, green: 180/255, blue: 235/255, alpha: 1);
        
        self.setIndexImage();
        // 设置按钮边框颜色
        liyuButton.layer.borderColor = UIColor.blueColor().CGColor;
        
    }

    
    func setIndexImage() {
        
        pageControl.currentPage = 0; /*设置当前页*/
        scrollView.pagingEnabled = true; // 分页滑动
        scrollView.bounces = false; // 关闭弹簧
        scrollView.showsHorizontalScrollIndicator = false; /*关闭滑条*/
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true);
        
        for index in 0...2  {
            
            let imageView = UIImageView.init(frame: CGRectMake((self.view.frame.size.width)*CGFloat(index), 0, self.view.frame.size.width, 140));
            imageView.image = UIImage.init(named: "LaunchImage-700-568h@2x.png");
            scrollView.addSubview(imageView);
            
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, 140);
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 修改pageControl当前的page
        let index = scrollView.contentOffset.x/self.view.frame.size.width;
        pageControl.currentPage = Int(index);
    }
    
    @IBAction func btnClick(sender: UIButton) {
        let tag = sender.tag;
        switch tag {
        case 1:
            print("按钮按下\(tag)");
        case 2:
            print("按钮按下\(tag)");
            let caTrans = CATransition();
            caTrans.duration = 0.35;
            caTrans.type = kCATransitionPush;
            caTrans.subtype = kCATransitionFromRight;
            self.view.window?.layer.addAnimation(caTrans, forKey: nil);
            self.presentViewController(SearchCarViewController(), animated: false, completion: {
                
            })

            
        case 3:
            let caTrans = CATransition();
            caTrans.duration = 0.35;
            caTrans.type = kCATransitionPush;
            caTrans.subtype = kCATransitionFromRight;
            self.view.window?.layer.addAnimation(caTrans, forKey: nil);
            self.presentViewController(StopPayViewController(), animated: false, completion: { 
                
            })
            
        case 4:
            print("按钮按下\(tag)");
        case 5:
            print("按钮按下\(tag)");
            
            leftViewController?.rightView.hidden = true;
            self.view.addSubview(self.leftViewController!.view);
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.leftViewController!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                }, completion: { (finsih) in
                    self.leftViewController!.rightView.hidden = false;
            })
            
        default:
            print("default");
        }
        
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
