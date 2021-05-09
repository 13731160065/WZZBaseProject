//
//  WZZWebViewController.m
//  LDAgent
//
//  Created by wyq_iMac on 2021/5/7.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZWebViewController.h"
#import "WZZWebView.h"
#import <objc/runtime.h>

@interface WZZWebViewController ()

@property (strong, nonatomic) WZZWebView * webView;

@end

@implementation WZZWebViewController

- (void)paramDicFromObj:(id)obj {
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionaryWithDictionary:self.paramDic];
    self.paramDic = paramDic;
    
    NSMutableDictionary * objParamDic = [NSMutableDictionary dictionary];
    paramDic[@"wzz_params"] = objParamDic;
    objParamDic[@"wzz_className"] = NSStringFromClass([obj class]);
    unsigned int outCount;//变量数
    Ivar * ivars = class_copyIvarList([obj class], &outCount);//获取变量列表ivars是一个Ivar数组
    for (int i = 0; i < outCount; i ++) {
        @try {
            Ivar ivar = ivars[i];//取出第i个Ivar
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];//根据Ivar得到变量名字的字符串
            id objj = [obj valueForKey:key];
            NSString * string = [NSString stringWithFormat:@"%@", objj?objj:@""];
            objParamDic[key] = string;
        } @catch (NSException *exception) {
            continue;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WZZWebView alloc] init];
    [self.view addSubview:self.webView];
    NSString * url = self.paramDic[@"wzz_url"];
    if (url) {
        NSURL * loadUrl = [NSURL URLWithString:@""];
        if ([url hasPrefix:@"http"]) {
            loadUrl = [NSURL URLWithString:url];
        } else {
            loadUrl = [NSURL fileURLWithPath:url];
        }
        [self.webView loadWebWithUrl:loadUrl];
    }
    if (self.paramDic[@"wzz_html"]) {
        [self.webView loadWebWithHtml:self.paramDic[@"wzz_html"]];
    }
    
    //约束布局
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.webView registerJSFunc:@"wzzvc_pushWeb" response:^(NSString *funcName, NSDictionary *respDic) {
        [weakSelf.navigationController pushViewController:[weakSelf makeWebVCWithRespDic:respDic] animated:YES];
    }];
    [self.webView registerJSFunc:@"wzzvc_getParams" response:^(NSString *funcName, NSDictionary *respDic) {
        NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:respDic];
        [mdic addEntriesFromDictionary:self.paramDic];
        [weakSelf callWeb:mdic];
    }];
    [self.webView registerJSFunc:@"wzzvc_presentWeb" response:^(NSString *funcName, NSDictionary *respDic) {
        [weakSelf presentViewController:[weakSelf makeWebVCWithRespDic:respDic] animated:YES completion:nil];
    }];
    [self.webView registerJSFunc:@"wzzvc_callBack" response:^(NSString *funcName, NSDictionary *respDic) {
        if (self.callBack) {
            self.callBack(weakSelf.lastVC, respDic);
        }
    }];
}

- (void)callWeb:(NSDictionary *)paramDic {
    [self.webView callJSFunc:@"wzzvc_callBackFunc" async:NO params:paramDic response:nil];
}

- (WZZWebViewController *)makeWebVCWithRespDic:(NSDictionary *)dic {
    WZZWebViewController * vc = [[WZZWebViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.paramDic = dic;
    vc.callBack = ^(WZZWebViewController * lastVC, NSDictionary *paramDic) {
        [lastVC.webView callJSFunc:@"wzzvc_callBackFunc" async:NO params:paramDic response:nil];
    };
    
    return vc;
}

@end
