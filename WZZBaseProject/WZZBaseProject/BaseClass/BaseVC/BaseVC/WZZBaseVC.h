//
//  WZZBaseVC.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@property (nonatomic, assign) WZZBaseVC_StateBarTintColor stateBarTintColor;

@end
