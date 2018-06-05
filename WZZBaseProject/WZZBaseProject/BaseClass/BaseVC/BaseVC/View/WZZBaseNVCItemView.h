//
//  WZZBaseNVCItemView.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/29.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZZBaseNVCItemView : UIView

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * rightImageView;
@property (nonatomic, strong) void(^clickBlock)(void);

/**
 初始化

 @param frame frame
 @param text 文字
 @param leftImage 左图片
 @param rightImage 右图片
 @param clickBlock 点击事件
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                    leftImage:(id)leftImage
                   rightImage:(id)rightImage
                   clickBlock:(void (^)(void))clickBlock;

@end