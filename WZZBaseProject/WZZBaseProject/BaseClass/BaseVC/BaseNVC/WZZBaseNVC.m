//
//  WZZBaseNVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseNVC.h"

@interface WZZBaseNVC ()

@end

@implementation WZZBaseNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏原始navigationbar
    [self.navigationBar setHidden:YES];
    
    [self createUI];
}

- (void)createUI {
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 系统方法

- (UIStatusBarStyle)preferredStatusBarStyle {
    WZZBaseVC * vc = (WZZBaseVC *)self.viewControllers.lastObject;
    switch (vc.basevc_stateBarTintColor) {
        case WZZBaseVC_StateBarTintColor_Black:
        {
            return UIStatusBarStyleDefault;
        }
            break;
        case WZZBaseVC_StateBarTintColor_White:
        {
            return UIStatusBarStyleLightContent;
        }
            break;
            
        default:
        {
            return ([WZZBaseVC isLightColor:vc.basevc_navigationBarColor])?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        }
            break;
    }
}



@end
