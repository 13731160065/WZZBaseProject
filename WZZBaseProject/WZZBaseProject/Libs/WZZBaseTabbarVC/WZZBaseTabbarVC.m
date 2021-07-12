//
//  WZZBaseTabbarVC.m
//  MoneyManager
//
//  Created by 王泽众 on 2021/5/11.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZBaseTabbarVC.h"

@interface WZZBaseTabbarVC ()
{
    NSUInteger _selectIndex;
}

@property (strong, nonatomic) WZZBaseTabbarVCItem * currentItem;

@end

@implementation WZZBaseTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[UIView alloc] init];
    [self.view addSubview:self.mainView];
    self.tabbarView = [[UIView alloc] init];
    [self.view addSubview:self.tabbarView];
    
//    self.tabbarView.backgroundColor = [UIColor redColor];
//    self.mainView.backgroundColor = [UIColor blueColor];
//    self.view.backgroundColor = [UIColor grayColor];
    
    [self makeMainView];
    [self makeTabbarView];
}

- (NSMutableArray<WZZBaseTabbarVCItem *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self.view addSubview:_mainView];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}

- (UIView *)tabbarView {
    if (!_tabbarView) {
        _tabbarView = [[UIView alloc] init];
        [self.view addSubview:_tabbarView];
        _tabbarView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tabbarView;
}

- (BOOL)isIphoneX {
    BOOL WZZPCHExternIsIphoneX;
    if (@available(iOS 11.0, *)) {
        WZZPCHExternIsIphoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
    } else {
        WZZPCHExternIsIphoneX = NO;
    }
    return WZZPCHExternIsIphoneX;
}

- (void)makeMainView {
    self.mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.mainView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mainView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.mainView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.mainView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.mainView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.mainView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}

- (void)makeTabbarView {
    self.tabbarView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.mainView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tabbarView attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tabbarView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tabbarView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:[self isIphoneX]?-33:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tabbarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tabbarView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tabbarView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.tabbarView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.tabbarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50].active = YES;
}

- (NSUInteger)selectIndex {
    if (![self.items containsObject:self.currentItem]) {
        return 0;
    }
    return [self.items indexOfObject:self.currentItem];
}

- (void)setSelectIndex:(NSUInteger)selectIndex {
    _selectIndex = selectIndex;
    if (selectIndex < self.items.count) {
        WZZBaseTabbarVCItem * item = self.items[selectIndex];
        self.currentItem = item;
        [self reloadSelect];
    }
}

/// 刷新UI
- (void)reloadUI {
    [[self.tabbarView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    UIView * lastView;
    for (int i = 0; i < self.items.count; i++) {
        WZZBaseTabbarVCItem * item = self.items[i];
        
        [self addChildViewController:item.viewController];
        
        UIView * view = [[UIView alloc] init];
        [self.tabbarView addSubview:view];
        [self makeItemView:view lastView:lastView isEnd:(self.items.count == i+1)];
        
        UIImageView * imgv = [[UIImageView alloc] init];
        [view addSubview:imgv];
        item._imageView = imgv;
        imgv.contentMode = UIViewContentModeScaleAspectFit;
        if (item.imageConfig) {
            item.imageConfig(imgv);
        }
        
        UILabel * label = [[UILabel alloc] init];
        [view addSubview:label];
        item._label = label;
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        if (item.nameConfig) {
            item.nameConfig(label);
        }
        label.text = item.name;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:button];
        button.tag = 10093+i;
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self makeItemViewSubView:item imageView:imgv label:label button:button];
        
        lastView = view;
    }
    if (!self.currentItem) {
        self.currentItem = [self.items firstObject];
    }
    [self reloadSelect];
}

- (void)itemClick:(UIButton *)button {
    NSInteger index = button.tag-10093;
    if (index < self.items.count) {
        self.currentItem = self.items[index];
    } else {
        self.currentItem = self.items.firstObject;
    }
    if (self.currentItem.onClick) {
        BOOL canGo = NO;
        canGo = self.currentItem.onClick(self.currentItem);
        if (!canGo) {
            return;
        }
    }
    [self reloadSelect];
}

- (void)reloadSelect {
    for (WZZBaseTabbarVCItem * item in self.items) {
        item._imageView.image = item.image;
        item._label.textColor = item.normalColor;
    }
    self.currentItem._imageView.image = self.currentItem.highLightImage;
    self.currentItem._label.textColor = self.currentItem.highLightColor;
    [[self.mainView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.mainView addSubview:self.currentItem.viewController.view];
    [self makeVCV:self.currentItem.viewController.view];
}

- (void)makeVCV:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}

- (void)makeItemView:(UIView *)view
            lastView:(UIView *)lastView
               isEnd:(BOOL)isEnd {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    if (lastView) {
        [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeRight multiplier:1 constant:8].active = YES;
        [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeWidth multiplier:1 constant:0].active = YES;
    } else {
        [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    }
    if (isEnd) {
        [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    }
}

- (void)makeItemViewSubView:(WZZBaseTabbarVCItem *)item
                  imageView:(UIImageView *)imageView
                      label:(UILabel *)label
                     button:(UIButton *)button {
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    //图片
    [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:item.topPadding].active = YES;
//    [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeTop multiplier:1 constant:item.centerPadding].active = YES;
    [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:item.centerX].active = YES;
    [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:item.imageSize.width].active = YES;
    [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:item.imageSize.height].active = YES;
    
    //文字
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:label.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:label.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:label.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-item.bottomPadding].active = YES;
    
    //按钮
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:button.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}

@end
