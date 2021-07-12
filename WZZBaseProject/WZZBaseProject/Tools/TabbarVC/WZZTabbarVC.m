//
//  WZZTabbarVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZTabbarVC.h"
#import "WZZBaseVC.h"
#import "WZZBaseNVC.h"
#import "tmpViewController.h"

@interface WZZTabbarVC ()

@end

@implementation WZZTabbarVC

- (void)setupTabbar {
    UIColor * normalColor = DEF_HEXCOLOR(0x7783A0);
    UIColor * highColor = DEF_HEXCOLOR(0x5082F7);
    
    void(^labelConfig)(UILabel *) = ^(UILabel *label) {
        label.font = [UIFont systemFontOfSize:11 weight:500];
    };
    
    //添加vc
    tmpViewController * homeVC = [[tmpViewController alloc] init];
    WZZBaseTabbarVCItem * home = [WZZBaseTabbarVCItem createItemWithName:@"首页" color:normalColor colorSel:highColor image:[UIImage imageNamed:@"tabbar_首页"] imageSel:[UIImage imageNamed:@"tabbar_首页sel"] controller:homeVC];
    [self.items addObject:home];
    home.nameConfig = labelConfig;
    
    //添加vc
    tmpViewController * homeVC1 = [[tmpViewController alloc] init];
    WZZBaseTabbarVCItem * home1 = [WZZBaseTabbarVCItem createItemWithName:@"产品" color:normalColor colorSel:highColor image:[UIImage imageNamed:@"tabbar_产品"] imageSel:[UIImage imageNamed:@"tabbar_产品sel"] controller:homeVC1];
    [self.items addObject:home1];
    home1.nameConfig = labelConfig;
    
    //添加vc
    tmpViewController * homeVC2 = [[tmpViewController alloc] init];
    WZZBaseTabbarVCItem * home2 = [WZZBaseTabbarVCItem createItemWithName:@"业绩" color:normalColor colorSel:highColor image:[UIImage imageNamed:@"tabbar_业绩"] imageSel:[UIImage imageNamed:@"tabbar_业绩sel"] controller:homeVC2];
    [self.items addObject:home2];
    home2.nameConfig = labelConfig;
    
    //添加vc
    tmpViewController * homeVC3 = [[tmpViewController alloc] init];
    WZZBaseTabbarVCItem * home3 = [WZZBaseTabbarVCItem createItemWithName:@"发现" color:normalColor colorSel:highColor image:[UIImage imageNamed:@"tabbar_发现"] imageSel:[UIImage imageNamed:@"tabbar_发现sel"] controller:homeVC3];
    [self.items addObject:home3];
    home3.nameConfig = labelConfig;
    
    tmpViewController * homeVC4 = [[tmpViewController alloc] init];
    WZZBaseTabbarVCItem * home4 = [WZZBaseTabbarVCItem createItemWithName:@"我的" color:normalColor colorSel:highColor image:[UIImage imageNamed:@"tabbar_我的"] imageSel:[UIImage imageNamed:@"tabbar_我的sel"] controller:homeVC4];
    [self.items addObject:home4];
    home4.nameConfig = labelConfig;
    
    [self reloadUI];
}

@end
