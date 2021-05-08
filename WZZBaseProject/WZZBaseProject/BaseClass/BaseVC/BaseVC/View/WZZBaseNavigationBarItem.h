//
//  WZZBaseNavigationBarItem.h
//  WZZBaseProject
//
//  Created by wyq_iMac on 2021/5/8.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WZZBaseNavigationBarItemSort_Image_Label = 0,
    WZZBaseNavigationBarItemSort_Label_Image,
} WZZBaseNavigationBarItemSort;

@interface WZZBaseNavigationBarItem : UIView

/// 图片视图，只读
@property (strong, nonatomic, readonly) UIImageView * imageView;

/// 文字视图，只读
@property (strong, nonatomic, readonly) UILabel * label;

/// 排序
@property (assign, nonatomic) WZZBaseNavigationBarItemSort sort;

/// 点击事件
@property (strong, nonatomic) void(^onClick)(WZZBaseNavigationBarItem * obj);

/// 图片
@property (strong, nonatomic) UIImage * image;

/// 文字
@property (strong, nonatomic) NSString * text;

/// 图片宽度，默认20
@property (strong, nonatomic) NSNumber * imageWidth;

/// 文字最大宽度，默认无限宽度
@property (strong, nonatomic) NSNumber * labelMaxWidth;

/// 中间宽度，默认5
@property (strong, nonatomic) NSNumber * space;

/// 创建UI
- (void)createUI;

/// 创建UI
/// @param text 文字
- (void)createUIWithText:(NSString *)text;

/// 创建UI
/// @param image 图片
/// @param imageWidth 图片宽度
- (void)createUIWithImage:(UIImage *)image
               imageWidth:(NSNumber *)imageWidth;

/// 创建UI
/// @param text 文字
/// @param image 图片
/// @param imageWidth 图片宽度
- (void)createUIWithText:(NSString *)text
                   image:(UIImage *)image
              imageWidth:(NSNumber *)imageWidth
                    sort:(WZZBaseNavigationBarItemSort)sort;

@end

