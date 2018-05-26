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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.basevc_navigationBarColor = DEF_MAINCOLOR;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //刷新statebar前景色
    self.basevc_stateBarTintColor = self.basevc_stateBarTintColor;
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
    
    self.basevc_navigationBarColor = DEF_MAINCOLOR;
    
    [self reloadUI];
}

- (void)reloadUI {
    //视图
    CGFloat upspace = _basevc_navigationBarHidden?DEF_STATEBAR_HEIGHT:(DEF_STATEBAR_HEIGHT+44);
    CGFloat bottomspace = _basevc_tabbarPlace?(DEF_BOTTOM_SAFEAREA_HEIGHT+DEF_TABBAR_HEIGHT):DEF_BOTTOM_SAFEAREA_HEIGHT;
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

- (void)setBasevc_stateBarTintColor:(WZZBaseVC_StateBarTintColor)basevc_stateBarTintColor {
    _basevc_stateBarTintColor = basevc_stateBarTintColor;
    //状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 系统方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (_basevc_stateBarTintColor) {
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
            return ([WZZBaseVC isLightColor:_basevc_navigationBarColor])?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        }
            break;
    }
}

#pragma mark - 辅助方法

//判断颜色是不是亮色
+ (BOOL)isLightColor:(UIColor *)color {
    if (!color) {
        return YES;
    }
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    //    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];
    if (num < 382) {
        return NO;
    } else {
        return YES;
    }
}

//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

@end
