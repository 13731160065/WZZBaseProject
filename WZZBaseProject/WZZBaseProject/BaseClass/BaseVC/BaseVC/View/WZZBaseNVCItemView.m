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

//快速初始化
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                    leftImage:(id)leftImage
                   rightImage:(id)rightImage
                   clickBlock:(void (^)(void))clickBlock {
    return [self initWithFrame:frame text:text textColor:textColor font:font leftImage:leftImage leftImageWidth:0 rightImage:rightImage rightImageWidth:0 space:8.0f clickBlock:clickBlock];
}

//快速初始化，带图片控制
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                    leftImage:(id)leftImage
               leftImageWidth:(CGFloat)leftImageWidth
                   rightImage:(id)rightImage
              rightImageWidth:(CGFloat)rightImageWidth
                        space:(CGFloat)space
                   clickBlock:(void (^)(void))clickBlock {
    self = [super initWithFrame:frame];
    if (self) {
        //左图
        if (leftImage) {
            if ([leftImage isKindOfClass:[UIImage class]]) {
                UIImage * lImage = leftImage;
                CGFloat lImageHeight = leftImageWidth/lImage.size.width*lImage.size.height;
                if (!leftImageWidth) {
                    leftImageWidth = frame.size.height;
                    lImageHeight = leftImageWidth;
                }
                _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, frame.size.height/2.0f-lImageHeight/2.0f, leftImageWidth, lImageHeight)];
                [self addSubview:_leftImageView];
                [_leftImageView setImage:leftImage];
                [_leftImageView setContentMode:UIViewContentModeScaleAspectFit];
            }
        }
        
        //右图
        if (rightImage) {
            UIImage * rImage = rightImage;
            CGFloat rImageHeight = rightImageWidth/rImage.size.width*rImage.size.height;
            if (!rightImageWidth) {
                rightImageWidth = frame.size.height;
                rImageHeight = rightImageWidth;
            }
            _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-rightImageWidth, frame.size.height/2.0f-rImageHeight/2.0f, rightImageWidth, rImageHeight)];
            [self addSubview:_rightImageView];
            [_rightImageView setImage:leftImage];
            [_rightImageView setContentMode:UIViewContentModeScaleAspectFit];
        }
        
        //标题
        if (text) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+(leftImage?space:0.0f), 0.0f, frame.size.width-(_rightImageView.frame.size.width+_leftImageView.frame.size.width)-(rightImage?space:0.0f)-(leftImage?space:0.0f), frame.size.height)];
            [self addSubview:_titleLabel];
            [_titleLabel setText:text];
            [_titleLabel setTextColor:[UIColor blackColor]];
            [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
            if (leftImage && rightImage) {
                [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            } else if (leftImage) {
                [_titleLabel setTextAlignment:NSTextAlignmentLeft];
            } else if (rightImage) {
                [_titleLabel setTextAlignment:NSTextAlignmentRight];
            } else {
                [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            }
            if (textColor) {
                [_titleLabel setTextColor:textColor];
            }
            if (font) {
                [_titleLabel setFont:font];
            }
        }
        
        //点击事件
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
