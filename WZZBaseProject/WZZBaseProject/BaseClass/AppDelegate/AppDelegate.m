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
    //tabbar
    WZZTabbarVC * tabbarVC = [[WZZTabbarVC alloc] init];
    
    //添加vc
    tmpViewController * ba = [[tmpViewController alloc] init];
    ba.basevc_tabbarPlace = YES;
    ba.basevc_navigationBarHidden = YES;
    [tabbarVC addVC:ba selectImage:[UIImage imageNamed:@"tmpimage2"] normalImage:[UIImage imageNamed:@"tmpImage"]];
    
    //添加vc
    tmpViewController * ba2 = [[tmpViewController alloc] init];
    ba2.basevc_tabbarPlace = YES;
    ba2.basevc_navigationBarHidden = YES;
    [tabbarVC addVC:ba2 selectImage:[UIImage imageNamed:@"tmpimage2"] normalImage:[UIImage imageNamed:@"tmpImage"]];
    
    //添加vc
    tmpViewController * ba3 = [[tmpViewController alloc] init];
    ba3.basevc_tabbarPlace = YES;
    ba3.basevc_navigationBarHidden = YES;
    [tabbarVC addVC:ba3 selectImage:[UIImage imageNamed:@"tmpimage2"] normalImage:[UIImage imageNamed:@"tmpImage"]];
    
    //添加vc
    tmpViewController * ba4 = [[tmpViewController alloc] init];
    ba4.basevc_tabbarPlace = YES;
    ba4.basevc_navigationBarHidden = YES;
    [tabbarVC addVC:ba4 selectImage:[UIImage imageNamed:@"tmpimage2"] normalImage:[UIImage imageNamed:@"tmpImage"]];
    
    //window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - 三方框架

@end
