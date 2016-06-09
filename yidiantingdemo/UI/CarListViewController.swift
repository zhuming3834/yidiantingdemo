//
//  CarListViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/9.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

protocol CarListViewControllerDelegate {
    func otherBtnClick();
}

class CarListViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CarListViewControllerDelegate?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "CarListTableViewCell", bundle:nil), forCellReuseIdentifier: "CarListTableViewCell");
        self.tableView.separatorStyle = .None;
        self.tableView.showsVerticalScrollIndicator = false;
        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identify:String = "CarListTableViewCell"
        let cell:CarListTableViewCell = tableView.dequeueReusableCellWithIdentifier(identify) as! CarListTableViewCell
        cell.selectionStyle = .None;
        cell.bgView.layer.shadowOffset = CGSizeMake(0, 0);
        cell.bgView.layer.shadowColor = UIColor.init(red: 216/255, green: 230/255, blue: 232/255, alpha: 1).CGColor;
        cell.bgView.layer.shadowOpacity = 1;
        cell.bgView.layer.cornerRadius = 5;
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row)");
    }

    
    

    @IBAction func switchVauleChange(sender: AnyObject) {
        print("switchVauleChange");
    }
    @IBAction func otherSearchTap(sender: AnyObject) {
        print("otherSearchTap");
        self.delegate!.otherBtnClick();
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
