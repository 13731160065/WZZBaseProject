//
//  WZZBaseNavigationBar.h
//  WZZBaseProject
//
//  Created by wyq_iMac on 2021/5/8.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZZBaseNavigationBarItem.h"

@interface WZZBaseNavigationBar : UIView

@property (strong, nonatomic) WZZBaseNavigationBarItem * titleItem;
@property (strong, nonatomic) UIView * lineView;

/// 标题控件间隔
@property (strong, nonatomic) NSNumber * titleSpace;

/// 左边控件间隔
@property (strong, nonatomic) NSNumber * leftSpace;

/// 右边控件间隔
@property (strong, nonatomic) NSNumber * rightSpace;

/// 标题数据源
@property (strong, nonatomic) NSMutableArray <WZZBaseNavigationBarItem *>* titleArr;

/// 左边数据源
@property (strong, nonatomic) NSMutableArray <WZZBaseNavigationBarItem *>* leftArr;

/// 右边数据源
@property (strong, nonatomic) NSMutableArray <WZZBaseNavigationBarItem *>* rightArr;

/// 创建左边按钮
/// @param text 文字
/// @param onClick 点击事件
- (void)addItemWithText:(NSString *)text
                onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

/// 创建左边按钮
/// @param image 图片
/// @param imageWidth 图片宽度
/// @param onClick 点击事件
- (void)createUIWithImage:(UIImage *)image
               imageWidth:(NSNumber *)imageWidth
                  onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

/// 创建左边按钮
/// @param text 文字
/// @param image 图片
/// @param imageWidth 图片宽度
/// @param onClick 点击事件
- (void)createUIWithText:(NSString *)text
                   image:(UIImage *)image
              imageWidth:(NSNumber *)imageWidth
                    sort:(WZZBaseNavigationBarItemSort)sort
                 onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

/// 创建UI
- (void)createUI;

@end

