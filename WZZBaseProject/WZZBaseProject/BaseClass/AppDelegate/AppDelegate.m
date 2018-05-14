//
//  AppDelegate.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "AppDelegate.h"
#import "WZZTabbarVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 系统方法

//MAKR:APP已经启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setup];
    
    return YES;
}

//MAKR:APP将要失去活动
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

//MARK:APP已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

//MAKR:APP将要进入后台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

//MAKR:APP已经变为活动的
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

//MAKR:APP将要销毁
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - 自定义方法

//MARK:初始化
- (void)setup {
    //tabbar
    WZZTabbarVC * tabbarVC = [[WZZTabbarVC alloc] init];
    
    //window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - 三方框架

@end
