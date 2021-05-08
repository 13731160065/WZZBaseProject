//
//  WZZBaseNavigationBar.m
//  WZZBaseProject
//
//  Created by wyq_iMac on 2021/5/8.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZBaseNavigationBar.h"

@interface WZZBaseNavigationBar ()

@property (strong, nonatomic) UIView * barView;
@property (strong, nonatomic) UIView * titleView;
@property (strong, nonatomic) UIView * leftView;
@property (strong, nonatomic) UIView * rightView;

@end

@implementation WZZBaseNavigationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleItem = [[WZZBaseNavigationBarItem alloc] init];
        self.titleArr = [NSMutableArray array];
        [self.titleArr addObject:self.titleItem];
        [self.titleItem createUIWithText:@""];
        self.titleItem.labelMaxWidth = @([UIScreen mainScreen].bounds.size.width/2.0);
    }
    return self;
}

- (void)createUI {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.barView = [[UIView alloc] init];
    [self addSubview:self.barView];
    [self makeBarView:self.barView];
    
    [self createCenterView];
    [self createLeftView];
    [self createRightView];
}

- (void)createCenterView {
    [self.titleView removeFromSuperview];
    self.titleView = [[UIView alloc] init];
    [self addSubview:self.titleView];
    //centerView，上、下、y居中
    [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    
    [self createItemView:self.titleArr space:self.titleSpace superView:self.titleView];
}

- (void)createLeftView {
    [self.leftView removeFromSuperview];
    self.leftView = [[UIView alloc] init];
    [self addSubview:self.titleView];
    //centerView，上、下、y居中
    [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    
    [self createItemView:self.leftArr space:self.leftSpace superView:self.leftView];
}

- (void)createRightView {
    [self.rightView removeFromSuperview];
    self.rightView = [[UIView alloc] init];
    [self addSubview:self.rightView];
    //centerView，上、下、y居中
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeWidth multiplier:1 constant:0].active = YES;
    
    [self createItemView:self.rightArr space:self.rightSpace superView:self.rightView];
}

- (void)createItemView:(NSArray <WZZBaseNavigationBarItem *>*)dataArr
                 space:(NSNumber *)space
             superView:(UIView *)superView {
    UIView * lastView;
    for (WZZBaseNavigationBarItem * item in dataArr) {
        [superView addSubview:item];
        //item，上下左
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lastView?lastView:superView attribute:lastView?NSLayoutAttributeRight:NSLayoutAttributeLeft multiplier:1 constant:lastView?(space?space.doubleValue:5):0].active = YES;
        
        lastView = item;
    }
    //lastView右
    [NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}

- (void)makeBarView:(UIView *)barView {
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:44].active = YES;
}

@end
