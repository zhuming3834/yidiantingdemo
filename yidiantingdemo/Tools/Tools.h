//
//  Tools.h
//  yidiantingdemo
//
//  Created by hgdq on 16/6/11.
//  Copyright © 2016年 hgdq. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

@interface Tools : NSObject

/**
 *  获取屏幕宽度
 *
 *  @return 屏幕宽度
 */
+ (CGFloat)getScreenWidth;
/**
 *  获取屏幕高度
 *
 *  @return 屏幕高度
 */
+ (CGFloat)getScreenHeight;

/**
 *  获取当前时间
 *
 *  @return 当前时间
 */
+ (NSString *)getCurrentTime;

/**
 *  数组逆序
 *
 *  @param array 需要逆序的数组
 *
 *  @return 逆序后的输出
 */
+ (NSMutableArray *)exchangeArray:(NSMutableArray *)array;


@end
