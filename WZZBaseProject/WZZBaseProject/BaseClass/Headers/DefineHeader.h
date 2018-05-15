//
//  DefineHeader.h
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//  全局宏定义头部文件

#ifndef DefineHeader_h
#define DefineHeader_h

#pragma mark - iPhoneX适配宏

//是不是IPhoneX
#define DEF_ISIPHONEX [WZZPCHExtern isIphoneX]

//底部安全区高度
#define DEF_BOTTOM_SAFEAREA_HEIGHT (DEF_ISIPHONEX ? 33.0f : 0.0f)

//StateBar高度
#define DEF_STATEBAR_HEIGHT (DEF_ISIPHONEX ? 44.0f : 20.0f)

//tabbar高度
#define DEF_TABBAR_HEIGHT 48.0f

#pragma mark - 颜色

//哈希色值
#define DEF_HEXCOLOR(rgbValue) [UIColor \
colorWithRed:((double)((rgbValue & 0xFF0000) >> 16))/255.0f \
green:((double)((rgbValue & 0xFF00) >> 8))/255.0f \
blue:((double)(rgbValue & 0xFF))/255.0f alpha:1.0f]

//RGBA色值
#define DEF_RGBACOLOR(cr, cg, cb, ca) [UIColor \
colorWithRed:((double)cr)/255.0f \
green:((double)cg)/255.0f \
blue:((double)cb)/255.0f alpha:((double)ca)]

//主色调
#define DEF_MAINCOLOR DEF_HEXCOLOR(0x2f222b)

#pragma mark - 尺寸

//屏幕宽
#define DEF_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高
#define DEF_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height-DEF_BOTTOM_SAFEAREA_HEIGHT)

#define DEF_


#endif /* DefineHeader_h */
