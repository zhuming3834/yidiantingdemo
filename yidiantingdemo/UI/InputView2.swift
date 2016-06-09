//
//  InputView2.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/7.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

protocol InputView2Delegate {
    func getInputView2String(inputString:String);
}

class InputView2: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    var delegate: InputView2Delegate?;
    
    
    let regionArray = ["京","沪","粤","津","浙","苏",
                       "湘","渝","云","豫","皖","陕",
                       "桂","新","青","琼","闽","蒙",
                       "辽","宁","鲁","晋","吉","翼",
                       "黑","甘","鄂","赣","贵","川",
                       "藏"];
    //                      40*6 + 20
    
    let charArray =    ["A","B","C","D","E","F",
                        "G","H","I","J","K","L",
                        "M","N","O","P","Q","R",
                        "S","T","U","V","W","X",
                        "Y","Z","港","澳"];
    //                      40*5 + 20
    
    let numArray =     ["1","2","3","4","5","6",
                        "7","8","9","0","","",
                        "A","B","C","D","E","F",
                        "G","H","I","J","K","L",
                        "M","N","O","P","Q","R",
                        "S","T","U","V","W","X",
                        "Y","Z","港","澳"];
    //                      40*7 + 20
    
    
    internal func addInputView(superView:UIView) -> InputView2 {
        let inputView = InputView2();
        inputView.frame = CGRectMake(0, 64, superView.frame.size.width, superView.frame.size.height - 64);
        superView.addSubview(inputView);
        inputView.initView();
        return inputView;
    }
    
    
    func initView() {
        
        let height = 220
        /// 上面的蒙蔽层
        let bgView = UIView.init(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - CGFloat(height)));
        bgView.backgroundColor = UIColor.init(red: 243/255, green: 243/255, blue: 243/255, alpha: 0.2);
        self.addSubview(bgView);
        /// 蒙蔽层点击手势  收起视图
        let tap = UITapGestureRecognizer();
        tap.addTarget(self, action: #selector(InputView2.tapClick));
        bgView.addGestureRecognizer(tap);
        
        
        
        let bottomView = UIView.init(frame: CGRectMake(0, CGRectGetMaxY(bgView.frame), self.frame.size.width, CGFloat(height)));
        bottomView.backgroundColor = UIColor.whiteColor();
        self.addSubview(bottomView);
        
        
        
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.minimumLineSpacing = 10; // 行间距
        flowLayout.minimumInteritemSpacing = (self.frame.size.width - 20 - 180)/5; // 列间距
        flowLayout.itemSize = CGSizeMake(30, 30); // 每个cell的大小
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical;
        
        let collectionView = UICollectionView.init(frame: CGRectMake(10, 10, self.frame.size.width - 20, bottomView.frame.size.height - 20), collectionViewLayout: flowLayout)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.whiteColor();
        collectionView.registerNib(UINib.init(nibName: "InputViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InputViewCollectionViewCell");
        bottomView.addSubview(collectionView);
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("InputViewCollectionViewCell", forIndexPath: indexPath) as! InputViewCollectionViewCell;
        
        cell.showLabel.layer.borderWidth = 1;
        cell.showLabel.layer.borderColor = UIColor.init(red: 152/255, green: 245/255, blue: 255/255, alpha: 1).CGColor;
        cell.showLabel.text = charArray[indexPath.row];
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.getInputView2String(charArray[indexPath.row]);
    }
    
    func tapClick() {
        self.removeFromSuperview();
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
