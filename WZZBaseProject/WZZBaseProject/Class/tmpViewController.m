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
    
}

- (IBAction)next:(id)sender {
    tmpViewController * vc = [[tmpViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
