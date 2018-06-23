//
//  AppDelegate.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "AppDelegate.h"
#import "WZZTabbarVC.h"
#import "tmpViewController.h"
#import "WZZSingleManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 系统方法

//MARK:APP已经启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setup];
    
    return YES;
}

//MARK:APP将要失去活动
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

//MARK:APP已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

//MARK:APP将要进入后台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

//MARK:APP已经变为活动的
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

//MARK:APP将要销毁
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - 自定义方法

//MARK:初始化
- (void)setup {
    [WZZSingleManager shareInstance].appDelegate = self;
    [[WZZSingleManager shareInstance] setupTabbar];
    [[WZZSingleManager shareInstance] changeWindowRoot:WZZSingleManager_ChangeWindowRoot_Login];
}

#pragma mark - 三方框架

@end
