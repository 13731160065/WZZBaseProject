//
//  tmpViewController.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/14.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "tmpViewController.h"

@interface tmpViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation tmpViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"标题";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH-50, DEF_SCREEN_HEIGHT-DEF_TABBAR_HEIGHT-50, 50, 50)];
    [self.view addSubview:view2];
    
    view2.backgroundColor = [UIColor greenColor];
    
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    [self.view addSubview:view2];
    [_rightLabel addSubview:view3];
    [view3 setBackgroundColor:[UIColor yellowColor]];
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
