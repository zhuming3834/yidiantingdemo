//
//  SearchCarViewController.swift
//  yidiantingdemo
//
//  Created by hgdq on 16/6/11.
//  Copyright © 2016年 hgdq. All rights reserved.
//

import UIKit

class SearchCarViewController: UIViewController ,BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var searchBgView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
        /// 搜索历史表格
    @IBOutlet weak var tableView: UITableView!
        /// 返回百度地图 按钮
    @IBOutlet weak var backSearchButton: UIButton!
        /// 左边定位按钮
    @IBOutlet weak var userLocButton: UIButton!
        /// 右边定位按钮
    @IBOutlet weak var locButton: UIButton!
        /// 普通按钮
    @IBOutlet weak var norButton: UIButton!
        /// 免费按钮
    @IBOutlet weak var freeButton: UIButton!
    
    var isShow = 1; // 1:显示百度地图 2：显示搜索视图
    
    var mapView: BMKMapView!; // 百度地图
    var locService: BMKLocationService!; // 定位服务
    // 全局 防止重复添加
    var region: BMKCoordinateRegion!;   // 定位
    var annotation: BMKPointAnnotation!; // 大头针
    var coor: CLLocationCoordinate2D!; // 经纬度
    var displayParam: BMKLocationViewDisplayParam!; // 定位方向
        /// 表头
    var headView: UIView!;
        /// 表尾
    var footView: UIView!;
        /// 数据集合
    var dataArray: NSMutableArray!
    
    private var myContext = 0
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        mapView.viewWillAppear();
        locService.delegate = self;
        mapView.delegate = self;
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        mapView.viewWillDisappear();
        locService.delegate = nil;
        mapView.delegate = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = NSMutableArray.init(array: SearchDBManage.shareSearchDBManage().selectAllSearchModel());
        
        initView();
        initMapView();
        showMapView();
        
        // Do any additional setup after loading the view.
    }
    
    /**
     显示搜索视图
     */
    func showSearchView() {
        isShow = 1;
        hideMapView();
        print("dataArray.count = \(dataArray.count)");
        if dataArray.count == 0 {
            tableView.hidden = true;
            headView.hidden = true;
            footView.hidden = true;
            backSearchButton.hidden = false;
            self.view.bringSubviewToFront(backSearchButton);
        }else{
            tableView.hidden = false;
            headView.hidden = false;
            footView.hidden = false;
            backSearchButton.hidden = true;
        }
    }
    /**
     显示地图视图
     */
    func showMapView() {
        isShow = 2;
        mapView.hidden = false;
        userLocButton.hidden = false;
        locButton.hidden = false;
        norButton.hidden = false;
        freeButton.hidden = false;
        tableView.hidden = true;
        backSearchButton.hidden = true;
        searchTextField.text = "";
        searchTextField.resignFirstResponder(); //收起键盘
    }
    /**
     隐藏地图视图
     */
    func hideMapView() {
        mapView.hidden = true;
        userLocButton.hidden = true;
        locButton.hidden = true;
        norButton.hidden = true;
        freeButton.hidden = true;
    }
    
    
    func initView() {
        searchBgView.layer.cornerRadius = 5;
        searchBgView.layer.borderWidth = 1;
        searchBgView.layer.borderColor = UIColor.init(red: 243/255, green: 243/255, blue: 243/255, alpha: 1).CGColor;
        
        tableView.hidden = true;
        backSearchButton.hidden = true;
        
        tableView.registerNib(UINib(nibName: "SearchCarTableViewCell", bundle:nil), forCellReuseIdentifier: "SearchCarTableViewCell");
        tableView.separatorStyle = .None;
        tableView.tableHeaderView = makeHeadView();
        tableView.tableFooterView = makeFootView();
    }
    /**
     初始化百度地图
     */
    func initMapView() {
        mapView = BMKMapView.init(frame: CGRectMake(0, 64, Tools.getScreenWidth(), Tools.getScreenHeight() - 64));
        self.view.addSubview(mapView);
        self.view.sendSubviewToBack(mapView);
        
        locService = BMKLocationService.init();
        locService.delegate = self;
        
        region = BMKCoordinateRegion();
        annotation = BMKPointAnnotation();
        coor = CLLocationCoordinate2D();
        
        locService.startUserLocationService();
        mapView.showsUserLocation = false;
        mapView.userTrackingMode = BMKUserTrackingModeNone;
        mapView.showsUserLocation = true;
        
        displayParam = BMKLocationViewDisplayParam.init();
        displayParam.isRotateAngleValid = true;
        displayParam.isAccuracyCircleShow = false;
        displayParam.locationViewImgName = "bnavi_icon_location_fixed";
        mapView.updateLocationViewWithParam(displayParam);
    }
    /**
     表头
     
     - returns: 表头视图
     */
    func makeHeadView() -> UIView {
        headView = UIView.init(frame: CGRectMake(0, 0, Tools.getScreenWidth(), 50));
        // 历史记录
        let button = UIButton.init(frame: CGRectMake(Tools.getScreenWidth() - 200, 3, 100, 44));
        button.setTitle("历史记录", forState: .Normal);
        button.setTitleColor(UIColor.init(red: 169/255, green: 183/255, blue: 183/255, alpha: 1), forState: .Normal);
        button.titleLabel?.font = UIFont.systemFontOfSize(12);
        button.setImage(UIImage.init(named: "icon_hist"), forState: .Normal);
        button.tag = 1;
        headView.addSubview(button);
        button.addTarget(self, action: #selector(SearchCarViewController.tableBtnClick), forControlEvents: .TouchUpInside);
        // 关闭
        let but = UIButton.init(frame: CGRectMake(Tools.getScreenWidth() - 100, 3, 80, 44));
        but.setTitle("关闭", forState: .Normal);
        but.setTitleColor(UIColor.init(red: 169/255, green: 183/255, blue: 183/255, alpha: 1), forState: .Normal);
        but.titleLabel?.font = UIFont.systemFontOfSize(12);
        but.setImage(UIImage.init(named: "icon_close"), forState: .Normal);
        but.tag = 2;
        headView.addSubview(but);
        but.addTarget(self, action: #selector(SearchCarViewController.tableBtnClick), forControlEvents: .TouchUpInside);
        return headView;
    }
    /**
     表尾
     
     - returns: 表尾视图
     */
    func makeFootView() -> UIView {
        footView = UIView.init(frame: CGRectMake(0, 0, Tools.getScreenWidth(), 50));
        let button = UIButton.init(frame: CGRectMake(0, 3, Tools.getScreenWidth(), 44));
        button.setTitle("清空历史记录", forState: .Normal);
        button.setTitleColor(UIColor.blackColor(), forState: .Normal);
        footView.addSubview(button);
        button.addTarget(self, action: #selector(SearchCarViewController.tableBtnClick), forControlEvents: .TouchUpInside);
        button.tag = 3;
        return footView;
    }
    
    
    
//MARK: BMKMapViewDelegate,BMKLocationServiceDelegate
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        print("\(userLocation.heading)");
        // 定位
        mapView.updateLocationData(userLocation);
        region.center.latitude = userLocation.location.coordinate.latitude;
        region.center.longitude = userLocation.location.coordinate.longitude;
        region.span.latitudeDelta = 0.002;
        region.span.longitudeDelta = 0.002;
        mapView.region = region;
        
        // 设置大头针
        coor.latitude = userLocation.location.coordinate.latitude;
        coor.longitude = userLocation.location.coordinate.longitude;
        annotation.coordinate = coor;
        annotation.title = "我在这里";
        mapView.addAnnotation(annotation);
        
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        print("\(userLocation.location.coordinate.longitude)");
        print("\(userLocation.location.coordinate.latitude)");
        mapView.updateLocationData(userLocation);
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKindOfClass(BMKPointAnnotation) {
            let newAnnotationView = BMKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "annotation");
            newAnnotationView.animatesDrop = false;
            newAnnotationView.image = UIImage.init(named: "icon_blank");
            return newAnnotationView;
        }
        
        return nil;
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        print("点击起泡");
    }
    
//MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true;
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        showSearchView();
        tableView.hidden = false;
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)!{
            if textField.returnKeyType == .Search {
                insterKeyWordToDB(textField.text!);
                dataArray = SearchDBManage.shareSearchDBManage().selectAllSearchModel();
                tableView.reloadData();
                if dataArray.count == 0 {
                    tableView.hidden = true;
                    headView.hidden = true;
                    footView.hidden = true;
                    backSearchButton.hidden = false;
                    self.view.bringSubviewToFront(backSearchButton);
                }else{
                    tableView.hidden = false;
                    headView.hidden = false;
                    footView.hidden = false;
                    backSearchButton.hidden = true;
                }

            }
        }
        return true;
    }

//MARK:UITableViewDelegate,UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identify:String = "SearchCarTableViewCell";
        let cell:SearchCarTableViewCell = tableView.dequeueReusableCellWithIdentifier(identify)! as! SearchCarTableViewCell;
        cell.fillCellWithDataArray(Tools.exchangeArray(dataArray), indexPath: indexPath);
        cell.selectionStyle = .Gray; //cell的点击效果
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchTextField.resignFirstResponder();
    }
    
    func clearHistData() {
        // 清空数据库
        SearchDBManage.shareSearchDBManage().deleteAllSearchModel();
        dataArray.removeAllObjects();
        tableView.reloadData();
        tableView.hidden = true;
        mapView.hidden = true;
        userLocButton.hidden = true;
        locButton.hidden = true;
        norButton.hidden = true;
        freeButton.hidden = true;
        backSearchButton.hidden = false;
    }
    
    func insterKeyWordToDB(keyword:String) {
        SearchDBManage.shareSearchDBManage().removeSameData(keyword);
        let model = SearchModel.creatSearchModel(keyword, subTitle: Tools.getCurrentTime(), currentTime: Tools.getCurrentTime())
        SearchDBManage.shareSearchDBManage().insterSearchModel(model);
    }
    
    
    func tableBtnClick(button:UIButton) {
        searchTextField.resignFirstResponder(); //收起键盘
        switch button.tag {
        case 1:
            print("刷新历史记录");
        case 2:
            print("切换到地图");
            showMapView();
        case 3:
            print("清空搜索历史");
            clearHistData();
        default:
            print("default");
        }
    }
    
    @IBAction func backSearchBtnClick(sender: UIButton) {
        showMapView();
    }
    @IBAction func userLocBtnClick(sender: UIButton) {
    }
    
    @IBAction func norBtnClick(sender: UIButton) {
    }
    
    @IBAction func freeBtnClick(sender: UIButton) {
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
        if isShow == 2 {
            showSearchView();
        }else{
            showMapView();
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
