//
//  SearchModel.m
//  SearchList
//
//  Created by zhuming on 16/4/7.
//  Copyright © 2016年 zhuming. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

/**
 *  新建 一个搜索数据模型
 *
 *  @param keyWord 搜索关键字
 *  @param subTitle 子标题
 *  @param currentTime 时间
 *
 *  @return 搜索模型
 */
+ (SearchModel *)creatSearchModel:(NSString *)keyWord subTitle:(NSString *)subTitle currentTime:(NSString *)currentTime {
    SearchModel *model = [[SearchModel alloc] init];
    model.keyWord = keyWord;
    model.subTitle = subTitle;
    model.currentTime = currentTime;
    return model;
}

@end
