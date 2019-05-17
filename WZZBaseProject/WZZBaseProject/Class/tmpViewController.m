//
//  tmpViewController.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/14.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "tmpViewController.h"
#import "SafeAreaDemoVC.h"

@interface tmpViewController ()
{
    NSInteger number;
}
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@end

@implementation tmpViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"标题";
        number = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)next:(id)sender {
    tmpViewController * vc = [[tmpViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)test:(id)sender {
}

@end
