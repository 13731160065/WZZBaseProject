//
//  WZZTabbarVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZTabbarVC.h"
#import "tmpViewController.h"

@interface WZZTabbarVC ()

@end

@implementation WZZTabbarVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        tmpViewController * ba = [[tmpViewController alloc] init];
        ba.basevc_tabbarPlace = YES;
        ba.basevc_navigationBarHidden = YES;
        self.viewControllers = @[ba];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
