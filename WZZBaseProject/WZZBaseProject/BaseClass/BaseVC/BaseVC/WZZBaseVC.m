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
    NSString * _title;
}

@property (strong, nonatomic) NSString * context;
@property (strong, nonatomic) UIView * noXibNavigationBackView;

@end

@implementation WZZBaseVC

- (void)setTitle:(NSString *)title {
    self.titleItem.label.text = title;
}

- (NSString *)title {
    if (!_title) {
        _title = @"";
    }
    return _title;
}

- (UIView *)wzz_navigationBarBackView {
    if (!_wzz_navigationBarBackView) {
        return self.noXibNavigationBackView;
    }
    return _wzz_navigationBarBackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    self.wzz_navigationBar = [[WZZBaseNavigationBar alloc] init];
    
    //设置默认导航栏和xib拖拽导航栏
    if (_wzz_navigationBarBackView) {
        [self.wzz_navigationBarBackView addSubview:self.wzz_navigationBar];
        [self makeNavigation];
    } else {
        self.noXibNavigationBackView = [[UIView alloc] init];
        [self.view addSubview:self.noXibNavigationBackView];
        [self.noXibNavigationBackView addSubview:self.wzz_navigationBar];
        self.noXibNavigationBackView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:self.noXibNavigationBackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:DEF_STATEBAR_HEIGHT].active = YES;
        [NSLayoutConstraint constraintWithItem:self.noXibNavigationBackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44].active = YES;
        [NSLayoutConstraint constraintWithItem:self.noXibNavigationBackView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.noXibNavigationBackView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        [self makeNavigation];
    }
    
    [self.wzz_navigationBar addTitleConfig:^(UILabel *label, UIImageView *imageView) {
        label.font = [UIFont systemFontOfSize:18];
    }];
    [self.wzz_navigationBar addLeftConfig:^(UILabel *label, UIImageView *imageView) {
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
    }];
    [self.wzz_navigationBar addRightConfig:^(UILabel *label, UIImageView *imageView) {
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
    }];
    
    //标题
    self.titleItem = [self.wzz_navigationBar addItemWithText:self.title place:WZZBaseNavigationBarPlace_Title onClick:nil];
    
    //返回按钮
    DEF_WeakSelf;
    self.backItem = [self.wzz_navigationBar addItemWithImage:[UIImage imageNamed:@"通用_返回"] imageWidth:@(10) place:WZZBaseNavigationBarPlace_Left onClick:^(WZZBaseNavigationBarItem *obj) {
        [weakSelf basevc_backClick];
    }];
    
    //导航栏刷新UI
    [self.wzz_navigationBar createUI];
}

/// 创建导航栏约束
- (void)makeNavigation {
    self.wzz_navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.wzz_navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wzz_navigationBar.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.wzz_navigationBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.wzz_navigationBar.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.wzz_navigationBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.wzz_navigationBar.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.wzz_navigationBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.wzz_navigationBar.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}

//MARK:返回点击
- (void)basevc_backClick {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
            return UIStatusBarStyleLightContent;
        }
            break;
    }
}

#pragma mark - 辅助方法

- (UIDeviceOrientation)getOrientation {
    return (UIDeviceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
}

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
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
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
