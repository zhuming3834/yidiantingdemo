//
//  Tools.m
//  yidiantingdemo
//
//  Created by hgdq on 16/6/11.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import "Tools.h"
#import "SearchModel.h"
#import "SearchDBManage.h"

@implementation Tools

/**
 *  获取屏幕宽度
 *
 *  @return 屏幕宽度
 */
+ (CGFloat)getScreenWidth {
    CGRect rx = [UIScreen mainScreen].bounds;
    return rx.size.width;
}
/**
 *  获取屏幕高度
 *
 *  @return 屏幕高度
 */
+ (CGFloat)getScreenHeight {
    CGRect rx = [UIScreen mainScreen].bounds;
    return rx.size.height;
}


/**
 *  获取当前时间
 *
 *  @return 当前时间
 */
+ (NSString *)getCurrentTime{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY年MM月dd日HH:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

/**
 *  数组逆序
 *
 *  @param array 需要逆序的数组
 *
 *  @return 逆序后的输出
 */
+ (NSMutableArray *)exchangeArray:(NSMutableArray *)array{
    NSInteger num = array.count;
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSInteger i = num - 1; i >= 0; i --) {
        [temp addObject:[array objectAtIndex:i]];
    }
    return temp;
}




@end
