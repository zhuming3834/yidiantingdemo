//
//  IndexViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/4.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var enterButton: UIButton!
    
        /// 第一次启动app
    var firstLaunch = "firstLaunch";
    
    
    // LaunchImage-700-568h@2x.png
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterButton.hidden = true;
        pageControl.hidden = false;
        pageControl.currentPage = 0;
        scrollView.pagingEnabled = true; // 分页滑动
        scrollView.bounces = false; // 关闭弹簧
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true);
        
        self.setIndexImage();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setIndexImage() {
        
        for index in 0...3  {
            
            let imageView = UIImageView.init(frame: CGRectMake((self.view.frame.size.width)*CGFloat(index), 0, self.view.frame.size.width, self.view.frame.size.height));
            imageView.image = UIImage.init(named: "LaunchImage-700-568h@2x.png");
            scrollView.addSubview(imageView);
            
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height);
        pageControl.numberOfPages = 4;
    }
    
// MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 修改pageControl当前的page
        let index = scrollView.contentOffset.x/self.view.frame.size.width;
        pageControl.currentPage = Int(index);
        
        if index == 3 {
            pageControl.hidden = true;
            enterButton.hidden = false;
        } else {
            pageControl.hidden = false;
            enterButton.hidden = true;
        }
    }
    
    // 点击 立即体验 按钮 修改跟控制器
    @IBAction func btnClick(sender: UIButton) {
        
        NSUserDefaults.standardUserDefaults().setValue(firstLaunch, forKey: firstLaunch);
        
        let window = UIApplication.sharedApplication().keyWindow;
        if ((window?.rootViewController) != nil) {
            window?.rootViewController?.removeFromParentViewController();
            window?.rootViewController = nil;
        }
        
        window!.rootViewController = ViewController();
        
        let cATransition = CATransition();
        cATransition.duration = 0.3;
        cATransition.type = kCATransitionFade;
        window?.layer.addAnimation(cATransition, forKey: nil);
        
        window!.makeKeyWindow();
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
