//
//  WZZBaseNavigationBar.h
//  WZZBaseProject
//
//  Created by wyq_iMac on 2021/5/8.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZZBaseNavigationBarItem.h"

typedef void(^WZZBaseNavigationBarConfigBlock)(UILabel * label, UIImageView * imageView);

typedef enum : NSUInteger {
    WZZBaseNavigationBarPlace_Right,
    WZZBaseNavigationBarPlace_Left,
    WZZBaseNavigationBarPlace_Title,
} WZZBaseNavigationBarPlace;

@interface WZZBaseNavigationBar : UIView

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

/// 标题item样式配置
@property (strong, nonatomic) NSMutableArray <WZZBaseNavigationBarConfigBlock>* titleConfigs;
/// 左边item样式配置
@property (strong, nonatomic) NSMutableArray <WZZBaseNavigationBarConfigBlock>* leftConfigs;
/// 右边item样式配置
@property (strong, nonatomic) NSMutableArray <WZZBaseNavigationBarConfigBlock>* rightConfigs;

/// 标题item样式配置
- (void)addTitleConfig:(WZZBaseNavigationBarConfigBlock)config;
/// 左边item样式配置
- (void)addLeftConfig:(WZZBaseNavigationBarConfigBlock)config;
/// 右边item样式配置
- (void)addRightConfig:(WZZBaseNavigationBarConfigBlock)config;

/// 创建UI
- (void)createUI;

/// 添加按钮
/// @param text 文字
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithText:(NSString *)text
                  place:(WZZBaseNavigationBarPlace)place
                onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

/// 添加按钮
/// @param image 图片
/// @param imageWidth 图片宽度
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithImage:(UIImage *)image
              imageWidth:(NSNumber *)imageWidth
                   place:(WZZBaseNavigationBarPlace)place
                 onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

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
                onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

@end

