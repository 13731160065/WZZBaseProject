//
//  WZZWebView.m
//  LDAgent
//
//  Created by wyq_iMac on 2021/4/25.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import "WZZWebView.h"
#import <WebKit/WebKit.h>

static NSUInteger WZZWebView_AutoId = 0;

@interface WZZWebView ()<UIScrollViewDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) NSMutableDictionary <NSString *, WZZWebView_Func>* funcDic;
@property (strong, nonatomic) WKUserContentController * contentController;

@end

@implementation WZZWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.logOpen = YES;
}

- (void)loadWebWithUrl:(NSURL *)url {
    self.url = url;
    [self loadDataWithScript:nil config:nil];
}

- (void)loadWebWithHtml:(NSString *)html {
    self.html = html;
    [self loadDataWithScript:nil config:nil];
}

- (void)loadWebWithUrl:(NSURL *)url
                script:(NSString *)script
                config:(void(^)(WKUserContentController * wkUserContentController))config {
    
    self.url = url;
    [self loadDataWithScript:script config:config];
}

- (void)loadWebWithHtml:(NSString *)html
                 script:(NSString *)script
                 config:(void(^)(WKUserContentController * wkUserContentController))config {
    self.html = html;
    [self loadDataWithScript:script config:config];
}

- (void)loadDataWithScript:(NSString *)script
                    config:(void(^)(WKUserContentController * wkUserContentController))config {
    [self.webView removeFromSuperview];
    
    //提前注入脚本
    self.contentController = [[WKUserContentController alloc] init];
    if (config) {
        config(self.contentController);
    }
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:script?script:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [self.contentController addUserScript:wkUScript];
    
    //注册交互方法
    [self.contentController addScriptMessageHandler:self name:@"wzz_webToNative"];
    [self.contentController addScriptMessageHandler:self name:@"wzz_backClick"];
    [self.contentController addScriptMessageHandler:self name:@"wzz_openUrl"];
    [self.contentController addScriptMessageHandler:self name:@"wzz_log"];
    
    //配置
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = self.contentController;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
    [self addSubview:self.webView];
    
    //约束布局
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    
    //导航代理滚动代理
    self.webView.navigationDelegate = self;
    self.webView.scrollView.delegate = self;

    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    } else {
        if (![self.html hasPrefix:@"<!DOCTYPE html>"] && ![self.html hasPrefix:@"<html>"]) {
            NSString * ff = [NSString stringWithFormat:@""
                         "<html>"
                         "    <head>"
                         "        <meta charset=\"UTF-8\">"
                         "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\">"
                         "        <style>"
                         "          img {"
                         "              width: 100%%;"
                         "              object-fit: contain;"
                         "          }"
                         "        </style>"
                         "    </head>"
                         "    <body>"
                         "       %@"
                         "    </body>"
                         "</html>", self.html
                         ];
            self.html = ff;
        }
        [self.webView loadHTMLString:self.html?self.html:@"" baseURL:self.baseURL];
    }
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (UIViewController *)getCurrentVC:(UIView *)view {
    UIResponder *nextResponder =  view;
    do {
        nextResponder = [nextResponder nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
    } while (nextResponder);
     
    UIViewController * topNVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * topVC;
    if ([topNVC isKindOfClass:[UINavigationController class]]) {
        topVC = [(UINavigationController *)topNVC topViewController];
    }
    
    return nil;
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //用Safari打开
    if ([message.name isEqualToString:@"wzz_openUrl"]) {
        NSString * openUrlStr = message.body;
        if (openUrlStr) {
            NSURL * openUrl = [NSURL URLWithString:openUrlStr];
            if ([[UIApplication sharedApplication] canOpenURL:openUrl]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:openUrl options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:openUrl];
                }
            } else {
                
            }
        }
    }
    
    //原生返回
    if ([message.name isEqualToString:@"wzz_backClick"]) {
        UIViewController * vc = [self getCurrentVC:self];
        if (vc) {
            vc = self.superVC;
        }
        if (vc.navigationController) {
            [vc.navigationController popViewControllerAnimated:YES];
        } else {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    //原生打印日志
    if ([message.name isEqualToString:@"wzz_log"]) {
        NSString * log = message.body;
        NSLog(@"%@", log);
    }
    
    //网页调用原生
    if ([message.name isEqualToString:@"wzz_webToNative"]) {
        NSDictionary * resp = message.body;
        NSString * name = resp[@"wzz_funcName"];
        
        //根据方法名获取方法回调
        WZZWebView_Func func = self.funcDic[name];
        if (func) {
            NSDictionary * resp = message.body;
            func(name, resp);
            if ([name containsString:@"@"]) {
                self.funcDic[name] = nil;
            }
        }
    }
}

/// 调用js
///
/// @param name 姓名
/// @param jsRequest 请求参数
/// @param response 响应回调
- (void)callJSFunc:(NSString *)name
             async:(BOOL)async
            params:(NSDictionary *)jsRequest
          response:(WZZWebView_Func)response {
    if (!name) {
        return;
    }
    if (!jsRequest) {
        jsRequest = @{};
    }
    
    NSMutableDictionary * mjsRequest = [NSMutableDictionary dictionaryWithDictionary:jsRequest];
    WZZWebView_AutoId++;
    NSString * autoId = @(WZZWebView_AutoId).stringValue;
    mjsRequest[@"wzz_autoId"] = autoId;
    
    //拼接自动id添加字典
    if (!self.funcDic) {
        self.funcDic = [NSMutableDictionary dictionary];
    }
    NSString * nameid = [name stringByAppendingFormat:@"@%@", autoId];
    
    NSString * json = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:mjsRequest options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSString * js = [NSString stringWithFormat:@"%@(%@);", name, json];
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (error && response) {
            //如果有错误，直接返回
            response(name, @{@"wzz_error":[NSString stringWithFormat:@"%@", error]});
            self.funcDic[nameid] = nil;
        } else if (response && !async) {
            //没错误，返回回调不为空，且不是异步方法，返回obj
            response(name, obj);
            self.funcDic[nameid] = nil;
        }
    }];
    
    self.funcDic[nameid] = response;
}

/// 注册js
///
/// @param name 名称
/// @param response 响应回调
- (void)registerJSFunc:(NSString *)name
              response:(WZZWebView_Func)response {
    if (!name) {
        return;
    }
    
    //拼接自动id添加字典
    if (!self.funcDic) {
        self.funcDic = [NSMutableDictionary dictionary];
    }
    self.funcDic[name] = response;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    
    if (![scheme isEqualToString:@"http"] && ![scheme isEqualToString:@"https"]) {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
        } else {
            
        }
    }

    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
//    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //判断是不是正常页面
    if ([navigationResponse.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse * resp = (NSHTTPURLResponse *)navigationResponse.response;
        if (resp.statusCode == 200) {
            //没问题
            
        } else {
            decisionHandler(WKNavigationResponsePolicyAllow);
            return;
        }
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

@end
