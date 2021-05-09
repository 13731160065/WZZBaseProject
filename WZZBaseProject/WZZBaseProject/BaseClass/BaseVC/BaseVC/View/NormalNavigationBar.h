//
//  NormalNavigationBar.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2021/5/9.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZBaseNavigationBar.h"

typedef enum : NSUInteger {
    NormalNavigationBarPlace_Right,
    NormalNavigationBarPlace_Left,
    NormalNavigationBarPlace_Title,
} NormalNavigationBarPlace;

@interface NormalNavigationBar : WZZBaseNavigationBar

/// 添加按钮
/// @param text 文字
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithText:(NSString *)text
                  place:(NormalNavigationBarPlace)place
                onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

/// 添加按钮
/// @param image 图片
/// @param imageWidth 图片宽度
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性
- (WZZBaseNavigationBarItem *)addItemWithImage:(UIImage *)image
              imageWidth:(NSNumber *)imageWidth
                   place:(NormalNavigationBarPlace)place
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
                  place:(NormalNavigationBarPlace)place
                onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick;

@end
