//
//  tmpViewController.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/14.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "tmpViewController.h"

@interface tmpViewController ()

@end

@implementation tmpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, DEF_STATEBAR_HEIGHT, 50, 50)];
    [self.view addSubview:view1];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-50, DEF_SCREEN_HEIGHT-DEF_TABBAR_HEIGHT-50, 50, 50)];
    [self.view addSubview:view2];
    
    view1.backgroundColor = [UIColor redColor];
    view2.backgroundColor = [UIColor greenColor];
}

- (IBAction)next:(id)sender {
    tmpViewController * vc = [[tmpViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test:(id)sender {
    self.basevc_navigationBarHidden = !self.basevc_navigationBarHidden;
}

@end
