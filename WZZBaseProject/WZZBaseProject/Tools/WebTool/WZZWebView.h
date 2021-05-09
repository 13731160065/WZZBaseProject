//
//  WZZWebView.h
//  LDAgent
//
//  Created by wyq_iMac on 2021/4/25.
//  Copyright © 2021 王泽众. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//方法返回
typedef void(^WZZWebView_Func)(NSString * funcName, NSDictionary * respDic);

@interface WZZWebView : UIView

@property (nonatomic, strong) WKWebView * webView;
@property (strong, nonatomic) NSURL * url;
@property (strong, nonatomic) NSString * html;
@property (strong, nonatomic) NSURL * baseURL;
@property (strong, nonatomic) UIViewController * superVC;
@property (assign, nonatomic) BOOL logOpen;//是否开启原声端日志

/// 包含模式，将根据内容撑开视图，不可滑动。模式为填满视图模式
@property (assign, nonatomic) BOOL containMode;

/// 加载url
/// @param url url
- (void)loadWebWithUrl:(NSURL *)url;

/// 加载html
/// @param html html
- (void)loadWebWithHtml:(NSString *)html;

/// 加载url
/// @param url url
/// @param script 预置脚本
/// @param config 配置
- (void)loadWebWithUrl:(NSURL *)url
                script:(NSString *)script
                config:(void(^)(WKUserContentController * wkUserContentController))config;

/// 加载html
/// @param html html
/// @param script 预置脚本
/// @param config 配置
- (void)loadWebWithHtml:(NSString *)html
                 script:(NSString *)script
                 config:(void(^)(WKUserContentController * wkUserContentController))config;

/// 调用js
///
/// @param name 姓名
/// @param jsRequest 请求参数
/// @param response 响应回调
- (void)callJSFunc:(NSString *)name
             async:(BOOL)async
            params:(NSDictionary *)jsRequest
          response:(WZZWebView_Func)response;

/// 注册js
///
/// @param name 名称
/// @param response 响应回调
- (void)registerJSFunc:(NSString *)name
              response:(WZZWebView_Func)response;

@end
