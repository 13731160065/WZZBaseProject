//
//  WZZBaseTabbarVC.h
//  MoneyManager
//
//  Created by 王泽众 on 2021/5/11.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZZBaseTabbarVCItem.h"

@interface WZZBaseTabbarVC : UIViewController

/// item数组
@property (nonatomic, strong) NSMutableArray <WZZBaseTabbarVCItem *>* items;

/// 主视图
@property (strong, nonatomic) UIView * mainView;

/// tabbar视图
@property (strong, nonatomic) UIView * tabbarView;

/// 选中位置
@property (nonatomic, assign) NSUInteger selectIndex;

/// 刷新UI
- (void)reloadUI;

@end
