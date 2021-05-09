//
//  TestVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2021/5/9.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导航栏透明测试";
    
    self.wzz_navigationBar.leftSpace = @(10);
    self.wzz_navigationBar.rightSpace = @(10);
    self.wzz_navigationBar.titleSpace = @(10);
    [self.wzz_navigationBar addItemWithText:@"测试" image:[UIImage imageNamed:@"tmpImage"] imageWidth:@(20) sort:WZZBaseNavigationBarItemSort_Image_Label place:WZZBaseNavigationBarPlace_Left onClick:^(WZZBaseNavigationBarItem *obj) {
        NSLog(@"测试点击");
    }];
    [self.wzz_navigationBar addItemWithText:@"筛选" place:WZZBaseNavigationBarPlace_Right onClick:^(WZZBaseNavigationBarItem *obj) {
        NSLog(@"筛选点击");
    }];
    [self.wzz_navigationBar addItemWithText:@"排序" place:WZZBaseNavigationBarPlace_Right onClick:^(WZZBaseNavigationBarItem *obj) {
        NSLog(@"排序点击");
    }];
    [self.wzz_navigationBar addTitleConfig:^(UILabel *label, UIImageView *imageView) {
        label.textColor = [UIColor whiteColor];
    }];
    [self.wzz_navigationBar addLeftConfig:^(UILabel *label, UIImageView *imageView) {
        label.textColor = [UIColor whiteColor];
    }];
    [self.wzz_navigationBar addRightConfig:^(UILabel *label, UIImageView *imageView) {
        label.textColor = [UIColor whiteColor];
    }];
    
    [self.wzz_navigationBar createUI];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
