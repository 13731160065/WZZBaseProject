//
//  NormalNavigationBar.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2021/5/9.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "NormalNavigationBar.h"

@implementation NormalNavigationBar

/// 添加按钮
/// @param text 文字
/// @param onClick 点击事件
/// @return 创建的item，用来修改属性 
- (WZZBaseNavigationBarItem *)addItemWithText:(NSString *)text
                  place:(NormalNavigationBarPlace)place
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
                   place:(NormalNavigationBarPlace)place
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
                                        place:(NormalNavigationBarPlace)place
                                      onClick:(void(^)(WZZBaseNavigationBarItem * obj))onClick {
    //确定添加位置
    NSMutableArray * marr = self.rightArr;
    if (place == NormalNavigationBarPlace_Left) {
        marr = self.leftArr;
    }
    if (place == NormalNavigationBarPlace_Title) {
        marr = self.titleArr;
    }
    
    WZZBaseNavigationBarItem * item = [[WZZBaseNavigationBarItem alloc] init];
    [marr addObject:item];
    [item createUIWithText:text image:image imageWidth:imageWidth sort:sort];
    item.onClick = onClick;
    
    return item;
}

@end
