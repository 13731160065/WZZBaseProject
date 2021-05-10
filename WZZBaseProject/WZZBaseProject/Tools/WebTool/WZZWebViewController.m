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
    if (self.file) {
        NSString * filePath = [[NSBundle mainBundle] pathForResource:self.file ofType:@""];
        self.url = filePath;
    }
    if (self.url) {
        NSURL * loadUrl = [NSURL URLWithString:@""];
        if ([self.url hasPrefix:@"http"]) {
            loadUrl = [NSURL URLWithString:self.url];
        } else {
            loadUrl = [NSURL fileURLWithPath:self.url];
        }
        [self.webView loadWebWithUrl:loadUrl];
    }
    if (self.html) {
        [self.webView loadWebWithHtml:self.html];
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
    [self.webView registerJSFunc:@"wzzvc_presentWeb" response:^(NSString *funcName, NSDictionary *respDic) {
        [weakSelf presentViewController:[weakSelf makeWebVCWithRespDic:respDic] animated:YES completion:nil];
    }];
    [self.webView registerJSFunc:@"wzzvc_pushVC" response:^(NSString *funcName, NSDictionary *respDic) {
        NSString * className = respDic[@"wzz_className"];
        NSArray * funcs = respDic[@"wzz_funcs"];
        NSDictionary * params = respDic[@"wzz_params"];
        if (className) {
            id obj = [[NSClassFromString(className) alloc] init];
            if ([obj isKindOfClass:[UIViewController class]]) {
                UIViewController * vc = obj;
                for (NSDictionary * func in funcs) {
                    NSString * funcName = func[@"wzz_funcName"];
                    [self callFuncWithObj:vc funcName:funcName params:func[@"wzz_funcParams"]];
                }
                NSArray * keys = params.allKeys;
                for (int i = 0; i < keys.count; i++) {
                    NSString * key = keys[i];
                    if (key) {
                        id value = params[key];
                        [vc setValue:value forKeyPath:key];
                    }
                }
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
    [self.webView registerJSFunc:@"wzzvc_getParams" response:^(NSString *funcName, NSDictionary *respDic) {
        NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:self.paramDic];
        [mdic addEntriesFromDictionary:respDic];
        mdic[@"wzzvc_safeAreaTop"] = @(DEF_STATEBAR_HEIGHT).stringValue;
        [weakSelf callWeb:mdic];
    }];
    [self.webView registerJSFunc:@"wzzvc_callBack" response:^(NSString *funcName, NSDictionary *respDic) {
        if (self.callBack) {
            self.callBack(weakSelf.lastVC, respDic);
        }
    }];
}

- (id)callFuncWithObj:(id)obj
               funcName:(NSString *)funcName
                 params:(NSArray <NSDictionary <NSString *, id>*>*)params {
    //处理入参
    if (!obj) {
        return nil;
    }
    if (!funcName) {
        return nil;
    }
    if (!params) {
        params = [NSMutableArray array];
    }
    
    //创建方法
    SEL func = NSSelectorFromString(funcName);
    NSMethodSignature * methodSign = [[obj class] instanceMethodSignatureForSelector:func];
    NSInvocation * method = [NSInvocation invocationWithMethodSignature:methodSign];
    method.target = obj;
    method.selector = func;
    
    //参数
    for (int i = 0; i < params.count; i++) {
        NSDictionary * dic = params[i];
        id aParam = dic[@"obj"];
        [method setArgument:&aParam atIndex:i+2];
    }
    
    //调用
    [method invoke];
    
    //返回
    id returnObj;
    if (methodSign.methodReturnLength != 0) {
        [method getReturnValue:&returnObj];
    }
    return returnObj;
}

- (void)callWeb:(NSDictionary *)paramDic {
    [self.webView callJSFunc:@"wzzvc_callBackFunc" async:NO params:paramDic response:nil];
}

- (WZZWebViewController *)makeWebVCWithRespDic:(NSDictionary *)dic {
    WZZWebViewController * vc = [[WZZWebViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.url = dic[@"wzz_url"];
    vc.html = dic[@"wzz_html"];
    vc.file = dic[@"wzz_file"];
    vc.paramDic = dic;
    vc.callBack = ^(WZZWebViewController * lastVC, NSDictionary *paramDic) {
        [lastVC.webView callJSFunc:@"wzzvc_callBackFunc" async:NO params:paramDic response:nil];
    };
    
    return vc;
}

@end
