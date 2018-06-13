//
//  WZZUserInfoObject.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZUserInfoObject.h"

static WZZUserInfoObject * wzzUserInfoObject;

@implementation WZZUserInfoObject

/**
 单例
 
 @return 实例
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wzzUserInfoObject = [[WZZUserInfoObject alloc] init];
    });
    return wzzUserInfoObject;
}

/**
 重置单例
 */
+ (void)resetInstance {
    wzzUserInfoObject = [[WZZUserInfoObject alloc] init];
}

@end
