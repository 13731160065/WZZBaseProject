//
//  WZZSingleManager.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZSingleManager.h"

static WZZSingleManager * singleManager;

@implementation WZZSingleManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleManager = [[WZZSingleManager alloc] init];
    });
    return singleManager;
}

@end
