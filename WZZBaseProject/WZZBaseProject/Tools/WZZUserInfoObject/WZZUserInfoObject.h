//
//  WZZUserInfoObject.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/6/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZUserInfoObject : NSObject

#pragma mark - 用户信息


#pragma mark - 操作方法

/*单例
 
 @return 实例
 */
+ (instancetype)shareInstance;

/**
 重置单例
 */
+ (void)resetInstance;

@end
