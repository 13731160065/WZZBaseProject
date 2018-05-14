//
//  WZZBaseVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseVC.h"

@interface WZZBaseVC ()
{
    UIView * realSelfView;
}

@end

@implementation WZZBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

//MARK:创建UI
- (void)createUI {
    //view颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //处理view适配
    realSelfView = self.view;
    UIView * selfView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.view = selfView;
    [self.view addSubview:realSelfView];
    
    //创建stateBar
    _basevc_stateBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_STATEBAR_HEIGHT)];
    [self.view addSubview:_basevc_stateBar];
    
    //创建navigationBar
    _basevc_navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_basevc_stateBar.frame), _basevc_stateBar.bounds.size.width, 44)];
    [self.view addSubview:_basevc_navigationBar];
    
//    [self setBasevc_navigationBarColor:DEF_MAINCOLOR];
    [self setBasevc_navigationBarColor:[UIColor colorWithWhite:(CGFloat)(arc4random()%100/100.0f) alpha:1.0f]];
    
    [self reloadUI];
}

- (void)reloadUI {
    //视图
    CGFloat upspace = _basevc_navigationBarHidden?DEF_STATEBAR_HEIGHT:(DEF_STATEBAR_HEIGHT+44);
    CGFloat bottomspace = _basevc_tabbarPlace?(DEF_BOTTOM_SAFEAREA_HEIGHT+50):DEF_BOTTOM_SAFEAREA_HEIGHT;
    [realSelfView setFrame:CGRectMake(0, upspace, self.view.bounds.size.width, self.view.bounds.size.height-upspace-bottomspace)];
    
    //导航栏
    _basevc_navigationBar.hidden = _basevc_navigationBarHidden;
}

#pragma mark - 属性

- (void)setBasevc_navigationBarHidden:(BOOL)basevc_navigationBarHidden {
    _basevc_navigationBarHidden = basevc_navigationBarHidden;
    [self reloadUI];
}

- (void)setBasevc_navigationBarColor:(UIColor *)basevc_navigationBarColor {
    _basevc_navigationBarColor = basevc_navigationBarColor;
    [_basevc_stateBar setBackgroundColor:basevc_navigationBarColor];
    [_basevc_navigationBar setBackgroundColor:basevc_navigationBarColor];
}

- (void)setBasevc_tabbarPlace:(BOOL)basevc_tabbarPlace {
    _basevc_tabbarPlace = basevc_tabbarPlace;
    [self reloadUI];
}

#pragma mark - 系统方法

- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (_stateBarTintColor) {
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
#warning wzz自动颜色还有问题
            const CGFloat * colorComponents = CGColorGetComponents(_basevc_navigationBarColor.CGColor);
            CGFloat color = ((colorComponents[0] * 299) + (colorComponents[1] * 587) + (colorComponents[2] * 114)) / 1000;
            return (color > 0.5f)?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        }
            break;
    }
}

@end
