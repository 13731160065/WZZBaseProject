//
//  WZZBaseTabbarVCItem.m
//  HNBaoDai
//
//  Created by wyq_iMac on 2021/5/13.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZBaseTabbarVCItem.h"

@implementation WZZBaseTabbarVCItem

+ (instancetype)createItemWithName:(NSString *)name
                             color:(UIColor *)color
                          colorSel:(UIColor *)colorSel
                             image:(UIImage *)image
                          imageSel:(UIImage *)imageSel
                        controller:(UIViewController *)controller {
    WZZBaseTabbarVCItem * item = [[WZZBaseTabbarVCItem alloc] init];
    item.name = name;
    item.normalColor = color;
    item.highLightColor = colorSel;
    item.image = image;
    item.highLightImage = imageSel;
    item.topPadding = 3;
    item.bottomPadding = 10;
    item.imageSize = CGSizeMake(22, 22);
    item.viewController = controller;
    return item;
}

@end
