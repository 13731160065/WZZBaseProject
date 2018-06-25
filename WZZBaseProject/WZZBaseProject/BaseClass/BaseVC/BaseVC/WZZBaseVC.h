//
//  WZZBaseVC.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZZBaseNVCItemView.h"

typedef enum : NSUInteger {
    WZZBaseVC_StateBarTintColor_Auto = 0,//自动
    WZZBaseVC_StateBarTintColor_Black,//黑色
    WZZBaseVC_StateBarTintColor_White//白色
} WZZBaseVC_StateBarTintColor;

@interface WZZBaseVC : UIViewController

/**
 状态栏
 */
@property (nonatomic, strong) UIView * basevc_stateBar;

/**
 导航栏
 */
@property (nonatomic, strong) UIView * basevc_navigationBar;

/**
 导航栏隐藏
 */
@property (nonatomic, assign) BOOL basevc_navigationBarHidden;

/**
 导航栏颜色
 */
@property (nonatomic, strong) UIColor * basevc_navigationBarColor;

/**
 空出tabbar部分
 */
@property (nonatomic, assign) BOOL basevc_tabbarPlace;

/**
 statebar前景色(文字颜色)
 */
@property (nonatomic, assign) WZZBaseVC_StateBarTintColor basevc_stateBarTintColor;

/**
 真实selfview
 ，xib加在这个view上，一般用不到
 */
@property (nonatomic, strong) UIView * __realSelfView;

/**
 左按钮
 */
@property (nonatomic, strong) WZZBaseNVCItemView * basevc_leftButton;

/**
 右按钮
 */
@property (nonatomic, strong) WZZBaseNVCItemView * basevc_rightButton;

/**
 标题
 */
@property (nonatomic, strong) WZZBaseNVCItemView * basevc_titleLabel;

/**
 底部线
 */
@property (nonatomic, strong) UIView * barLineView;

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
