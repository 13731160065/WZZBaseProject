//
//  WZZBaseNavigationBarItem.m
//  WZZBaseProject
//
//  Created by wyq_iMac on 2021/5/8.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZBaseNavigationBarItem.h"

@interface WZZBaseNavigationBarItem ()
{
    UIImageView * _imageView;
    UILabel * _label;
}

@property (strong, nonatomic) UIButton * topButton;

@end

@implementation WZZBaseNavigationBarItem

- (UIButton *)topButton {
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topButton addTarget:self action:@selector(topButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}

- (void)topButtonClick {
    if (self.onClick) {
        self.onClick(self);
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

/// 创建UI
- (void)createUI {
    //清空约束，移除视图
    [self.label removeConstraints:self.label.constraints];
    [self.imageView removeConstraints:self.imageView.constraints];
    [self.label removeFromSuperview];
    [self.imageView removeFromSuperview];
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.label.text = self.text;
    
    //设置使用约束
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.text && !self.image) {
        //仅文字
        [self addSubview:self.label];
        [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        if (self.labelMaxWidth) {
            [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.labelMaxWidth.doubleValue].active = YES;
        }
    } else if (!self.text && self.image) {
        //仅图片
        [self addSubview:self.imageView];
        [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.imageWidth?self.imageWidth.doubleValue:20].active = YES;
        [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    } else if (self.text && self.image) {
        //图文
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        //文字上下
        [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        if (self.labelMaxWidth) {
            [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.labelMaxWidth.doubleValue].active = YES;
        }
        //图片居中，宽
        [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.imageWidth?self.imageWidth.doubleValue:20].active = YES;
        UIView * leftView = self.imageView;
        UIView * rightView = self.label;
        if (self.sort == WZZBaseNavigationBarItemSort_Label_Image) {
            leftView = self.label;
            rightView = self.imageView;
        }
        [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:self.space?self.space.doubleValue:5].active = YES;
    } else {
        //啥没有
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    }
}

/// 创建UI
/// @param text 文字
- (void)createUIWithText:(NSString *)text {
    [self createUIWithText:text image:nil imageWidth:nil sort:0];
}

/// 创建UI
/// @param image 图片
/// @param imageWidth 图片宽度
- (void)createUIWithImage:(UIImage *)image
               imageWidth:(NSNumber *)imageWidth {
    [self createUIWithText:nil image:image imageWidth:imageWidth sort:0];
}

/// 创建UI
/// @param text 文字
/// @param image 图片
/// @param imageWidth 图片宽度
- (void)createUIWithText:(NSString *)text
                   image:(UIImage *)image
              imageWidth:(NSNumber *)imageWidth
                    sort:(WZZBaseNavigationBarItemSort)sort {
    self.image = image;
    self.text = text;
    self.imageWidth = imageWidth;
    self.sort = sort;
    [self createUI];
}

@end
