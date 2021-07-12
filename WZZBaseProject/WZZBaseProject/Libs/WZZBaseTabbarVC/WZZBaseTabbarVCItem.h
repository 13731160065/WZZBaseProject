//
//  WZZBaseTabbarVCItem.h
//  HNBaoDai
//
//  Created by wyq_iMac on 2021/5/13.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZZBaseTabbarVCItem :NSObject

/// 名称
@property (nonatomic, strong) NSString * name;

/// 名称配置
@property (strong, nonatomic) void(^nameConfig)(UILabel * label);

/// 普通颜色
@property (nonatomic, strong) UIColor * normalColor;

/// 高亮颜色
@property (nonatomic, strong) UIColor * highLightColor;

/// 普通图片
@property (nonatomic, strong) UIImage * image;

/// 高亮图片
@property (nonatomic, strong) UIImage * highLightImage;

/// 名称配置
@property (strong, nonatomic) void(^imageConfig)(UIImageView * imageView);

/// 图片宽高
@property (nonatomic, assign) CGSize imageSize;

/// 顶部高度
@property (assign, nonatomic) CGFloat topPadding;

/// 中间高度
//@property (assign, nonatomic) CGFloat centerPadding;

/// 底部高度
@property (assign, nonatomic) CGFloat bottomPadding;

/// 居中位置
@property (assign, nonatomic) CGFloat centerX;

/// 控制器
@property (nonatomic, strong) UIViewController * viewController;

/// 点击事件，返回YES可以点击，返回NO不可以点击
@property (strong, nonatomic) BOOL(^onClick)(WZZBaseTabbarVCItem * item);

/// 不需要用户处理
@property (strong, nonatomic) UIImageView * _imageView;
@property (strong, nonatomic) UILabel * _label;

/// 创建item
/// @param name 名称
/// @param color 颜色
/// @param colorSel 选中颜色
/// @param image 图片
/// @param imageSel 选中图片
+ (instancetype)createItemWithName:(NSString *)name
                             color:(UIColor *)color
                          colorSel:(UIColor *)colorSel
                             image:(UIImage *)image
                          imageSel:(UIImage *)imageSel
                        controller:(UIViewController *)controller;

@end

