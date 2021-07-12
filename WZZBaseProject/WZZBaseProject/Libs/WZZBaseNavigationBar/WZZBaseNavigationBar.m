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
    [self.barView addSubview:self.titleView];
    self.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    //centerView，上、下、x居中
    [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.titleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    
    [self createItemView:self.titleArr space:self.titleSpace superView:self.titleView];
}

- (void)createLeftView {
    [self.leftView removeFromSuperview];
    self.leftView = [[UIView alloc] init];
    [self.barView addSubview:self.leftView];
    self.leftView.translatesAutoresizingMaskIntoConstraints = NO;
    //centerView，上、下、左
    [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.leftView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.leftView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.leftView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.leftView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:15].active = YES;
    
    [self createItemView:self.leftArr space:self.leftSpace superView:self.leftView];
}

- (void)createRightView {
    [self.rightView removeFromSuperview];
    self.rightView = [[UIView alloc] init];
    [self.barView addSubview:self.rightView];
    self.rightView.translatesAutoresizingMaskIntoConstraints = NO;
    //centerView
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rightView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.rightView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.rightView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-15].active = YES;
//    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
//    [NSLayoutConstraint constraintWithItem:self.rightView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.leftView attribute:NSLayoutAttributeWidth multiplier:1 constant:0].active = YES;
    
    [self createItemView:self.rightArr space:self.rightSpace superView:self.rightView];
}

- (void)createItemView:(NSArray <WZZBaseNavigationBarItem *>*)dataArr
                 space:(NSNumber *)space
             superView:(UIView *)superView {
    UIView * lastView;
    for (WZZBaseNavigationBarItem * item in dataArr) {
        if (superView == self.titleView) {
            for (WZZBaseNavigationBarConfigBlock aBlock in self.titleConfigs) {
                aBlock(item.label, item.imageView);
            }
        }
        if (superView == self.leftView) {
            for (WZZBaseNavigationBarConfigBlock aBlock in self.leftConfigs) {
                aBlock(item.label, item.imageView);
            }
        }
        if (superView == self.rightView) {
            for (WZZBaseNavigationBarConfigBlock aBlock in self.rightConfigs) {
                aBlock(item.label, item.imageView);
            }
        }
        [superView addSubview:item];
        item.translatesAutoresizingMaskIntoConstraints = NO;
        //item，上下左
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
        [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
        if (superView == self.rightView) {
            [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lastView?lastView:superView attribute:lastView?NSLayoutAttributeLeft:NSLayoutAttributeRight multiplier:1 constant:lastView?(space?-space.doubleValue:-5):0].active = YES;
        } else {
            [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lastView?lastView:superView attribute:lastView?NSLayoutAttributeRight:NSLayoutAttributeLeft multiplier:1 constant:lastView?(space?space.doubleValue:5):0].active = YES;
        }
        
        UIButton * topButton = [item valueForKey:@"topButton"];
        //按钮
        [self addSubview:topButton];
        [NSLayoutConstraint constraintWithItem:topButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeTop multiplier:1 constant:-item.buttonEdge.top].active = YES;
        [NSLayoutConstraint constraintWithItem:topButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeBottom multiplier:1 constant:item.buttonEdge.bottom].active = YES;
        [NSLayoutConstraint constraintWithItem:topButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeLeft multiplier:1 constant:-item.buttonEdge.left].active = YES;
        [NSLayoutConstraint constraintWithItem:topButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:item attribute:NSLayoutAttributeRight multiplier:1 constant:item.buttonEdge.right].active = YES;
        
        lastView = item;
    }
    //lastView右
    if (lastView) {
        if (superView == self.titleView) {
            [NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        } else if (superView == self.leftView) {
            [NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
        } else if (superView == self.rightView) {
            [NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
        }
    }
}

- (void)makeBarView:(UIView *)barView {
    barView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:barView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:44].active = YES;
}

- (void)addTitleConfig:(WZZBaseNavigationBarConfigBlock)config {
    if (!self.titleConfigs) {
        self.titleConfigs = [NSMutableArray array];
    }
    [self.titleConfigs addObject:config];
}

- (void)addLeftConfig:(WZZBaseNavigationBarConfigBlock)config {
    if (!self.leftConfigs) {
        self.leftConfigs = [NSMutableArray array];
    }
    [self.leftConfigs addObject:config];
}

- (void)addRightConfig:(WZZBaseNavigationBarConfigBlock)config {
    if (!self.rightConfigs) {
        self.rightConfigs = [NSMutableArray array];
    }
    [self.rightConfigs addObject:config];
}

- (NSMutableArray<WZZBaseNavigationBarItem *> *)leftArr {
    if (!_leftArr) {
        _leftArr = [NSMutableArray array];
    }
    return _leftArr;
}
- (NSMutableArray<WZZBaseNavigationBarItem *> *)rightArr {
    if (!_rightArr) {
        _rightArr = [NSMutableArray array];
    }
    return _rightArr;
}
- (NSMutableArray<WZZBaseNavigationBarItem *> *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

/// 添加按钮
/// @param text 文字
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithText:(NSString *)text
                  place:(WZZBaseNavigationBarPlace)place
                onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick {
    return [self addItemWithText:text image:nil imageWidth:nil sort:0 place:place onClick:onClick];
}

/// 添加按钮
/// @param image 图片
/// @param imageWidth 图片宽度
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithImage:(UIImage *)image
              imageWidth:(NSNumber *)imageWidth
                   place:(WZZBaseNavigationBarPlace)place
                 onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick {
    return [self addItemWithText:nil image:image imageWidth:imageWidth sort:0 place:place onClick:onClick];
}

/// 添加按钮
/// @param text 文字
/// @param image 图片
/// @param imageWidth 图片宽度
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithText:(NSString *)text
                                        image:(UIImage *)image
                                   imageWidth:(NSNumber *)imageWidth
                                         sort:(WZZBaseNavigationBarItemSort)sort
                                        place:(WZZBaseNavigationBarPlace)place
                                      onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick {
    //确定添加位置
    NSMutableArray * marr = self.rightArr;
    if (place == WZZBaseNavigationBarPlace_Left) {
        marr = self.leftArr;
    }
    if (place == WZZBaseNavigationBarPlace_Title) {
        marr = self.titleArr;
    }
    
    WZZBaseNavigationBarItem * item = [[WZZBaseNavigationBarItem alloc] init];
    [marr addObject:item];
    [item createUIWithText:text image:image imageWidth:imageWidth sort:sort];
    item.onClick = onClick;
    
    return item;
}

@end
