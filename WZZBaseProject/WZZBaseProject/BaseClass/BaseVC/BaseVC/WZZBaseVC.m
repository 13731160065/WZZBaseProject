//
//  WZZBaseVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseVC.h"

@interface WZZBaseVC ()

@property (strong, nonatomic) NSString * context;

@end

@implementation WZZBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
