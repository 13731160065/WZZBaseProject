//
//  WZZWebViewController.h
//  LDAgent
//
//  Created by wyq_iMac on 2021/5/7.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZZWebViewController : UIViewController

@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * html;
@property (strong, nonatomic) NSDictionary * paramDic;
@property (strong, nonatomic) void(^callBack)(WZZWebViewController * lastVC, NSDictionary * paramDic);
@property (weak, nonatomic) WZZWebViewController * lastVC;

/// 从传入对象获取所有参数
/// @param obj 对象
- (void)paramDicFromObj:(id)obj;

@end

