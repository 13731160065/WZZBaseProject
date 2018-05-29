//
//  WZZBaseNVCItemView.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/29.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseNVCItemView.h"

@interface WZZBaseNVCItemView () {
    UIButton * button;//覆盖按钮
}

@end

@implementation WZZBaseNVCItemView

- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                    leftImage:(id)leftImage
                   rightImage:(id)rightImage
                   clickBlock:(void (^)(void))clickBlock {
    self = [super initWithFrame:frame];
    if (self) {
        //左图
        if (leftImage) {
            _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
            [self addSubview:_leftImageView];
            [_leftImageView setImage:leftImage];
            [_leftImageView setContentMode:UIViewContentModeScaleAspectFit];
        }
        //右图
        if (rightImage) {
            _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-frame.size.height, 0.0f, frame.size.height, frame.size.height)];
            [self addSubview:_rightImageView];
            [_rightImageView setImage:leftImage];
            [_rightImageView setContentMode:UIViewContentModeScaleAspectFit];
        }
        //标题
        if (text) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+(leftImage?8.0f:0.0f), 0.0f, frame.size.width-(_rightImageView.frame.size.width+_leftImageView.frame.size.width)-(rightImage?8.0f:0.0f)-(leftImage?8.0f:0.0f), frame.size.height)];
            [self addSubview:_titleLabel];
            [_titleLabel setText:text];
            [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_titleLabel setTextColor:textColor];
            [_titleLabel setFont:font];
        }
        
        self.clickBlock = clickBlock;
    }
    return self;
}

//点击事件
- (void)setClickBlock:(void (^)(void))clickBlock {
    _clickBlock = clickBlock;
    if (button) {
        [button removeFromSuperview];
        button = nil;
    }
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:self.bounds];;
    [self addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick {
    if (_clickBlock) {
        _clickBlock();
    }
}

@end
