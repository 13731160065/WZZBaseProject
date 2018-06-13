//
//  WZZSingleManager.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZSingleManager : NSObject

/**
 单例

 @return 单例
 */
+ (instancetype)shareInstance;

@end
