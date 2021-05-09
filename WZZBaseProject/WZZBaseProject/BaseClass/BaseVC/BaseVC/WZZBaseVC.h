//
//  WZZBaseVC.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZZBaseNavigationBar.h"
#import "WZZBaseNavigationBarItem.h"

typedef enum : NSUInteger {
    WZZBaseVC_StateBarTintColor_Auto = 0,//自动
    WZZBaseVC_StateBarTintColor_Black,//黑色
    WZZBaseVC_StateBarTintColor_White//白色
} WZZBaseVC_StateBarTintColor;

@interface WZZBaseVC : UIViewController

#pragma mark - 操作属性

/// 导航栏背景
@property (nonatomic, weak) IBOutlet UIView * wzz_navigationBarBackView;

/// 导航栏
@property (nonatomic, strong) WZZBaseNavigationBar * wzz_navigationBar;

/// 标题item
@property (nonatomic, strong) WZZBaseNavigationBarItem * titleItem;

/// 返回item
@property (nonatomic, strong) WZZBaseNavigationBarItem * backItem;

/**
 statebar前景色(文字颜色)
 */
@property (nonatomic, assign) WZZBaseVC_StateBarTintColor basevc_stateBarTintColor;

#pragma mark - 辅助方法

/**
 判断颜色是不是亮色

 @param color 颜色
 @return bool
 */
+ (BOOL)isLightColor:(UIColor *)color;

/**
 返回按钮点击，可重写
 */
- (void)basevc_backClick;

@end
