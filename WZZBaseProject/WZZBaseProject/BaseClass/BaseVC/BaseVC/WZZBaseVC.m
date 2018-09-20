//
//  WZZBaseVC.m
//  WZZBaseProject
//
//  Created by 王泽众 on 2018/5/13.
//  Copyright © 2018年 王泽众. All rights reserved.
//

#import "WZZBaseVC.h"
#import "WZZBaseNVCAutoItemView.h"

#define WZZBaseVC_UseConstant 1

@interface WZZBaseVC ()

#if WZZBaseVC_UseConstant
/**
 顶部约束
 */
@property (strong, nonatomic) NSLayoutConstraint * realSelfView_topCon;

/**
 realSelfView下部约束
 */
@property (strong, nonatomic) NSLayoutConstraint * realSelfView_BottomCon;

/**
 nav高度约束
 */
@property (strong, nonatomic) NSLayoutConstraint * navgation_HeightCon;
#endif

@end

@implementation WZZBaseVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.basevc_navigationBarColor = DEF_MAINCOLOR;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _superCreateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //刷新statebar前景色
    self.basevc_stateBarTintColor = self.basevc_stateBarTintColor;
}

//MARK:创建UI
- (void)_superCreateUI {
    //view颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /**
     处理view适配
     将self.view交给___realSelfView
     xib加在___realSelfView上，而代码视图加在self.view上
     **/
    ___realSelfView = self.view;
    UIView * selfView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = selfView;
    [selfView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:___realSelfView];
    [___realSelfView setBackgroundColor:[UIColor clearColor]];
    
    //创建stateBar
    _basevc_stateBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_STATEBAR_HEIGHT)];
    [self.view addSubview:_basevc_stateBar];
    
    //创建navigationBar
    _basevc_navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_basevc_stateBar.frame), _basevc_stateBar.bounds.size.width, 44)];
    [self.view addSubview:_basevc_navigationBar];
    
    //-横线
    _barLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _basevc_navigationBar.frame.size.height-1, _basevc_navigationBar.frame.size.width, 1)];
    [_basevc_navigationBar addSubview:_barLineView];
    [_barLineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
#if WZZBaseVC_UseConstant
    //左按钮
    WZZBaseNVCAutoItemSpace * b_space = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemImage * b_img = [WZZBaseNVCAutoItemImage imageWithWidth:30.0f];
    b_img.image = [UIImage imageNamed:@"base_back"];
    __weak WZZBaseVC * weakSelf = self;
    _basevc_leftButton = [WZZBaseNVCAutoItemView itemWithItemArr:@[b_space, b_img] clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    _basevc_leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_basevc_navigationBar addSubview:_basevc_leftButton];
    [NSLayoutConstraint constraintWithItem:_basevc_leftButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_leftButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_leftButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    
    //标题按钮
    WZZBaseNVCAutoItemSpace * t_space = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemLabel * t_label = [WZZBaseNVCAutoItemLabel labelWithMaxWidth:DEF_SCREEN_WIDTH-100 minWidth:0 line:0];
    t_label.text = @"标题";
    t_label.textAlignment = NSTextAlignmentCenter;
    t_label.textColor = [UIColor whiteColor];
    WZZBaseNVCAutoItemSpace * t_space2 = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    _basevc_titleLabel = [WZZBaseNVCAutoItemView itemWithItemArr:@[t_space, t_label, t_space2] clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    _basevc_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_basevc_navigationBar addSubview:_basevc_titleLabel];
    [NSLayoutConstraint constraintWithItem:_basevc_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeCenterX multiplier:1 constant:0].active = YES;
    
    //标题按钮
    WZZBaseNVCAutoItemSpace * r_space = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    WZZBaseNVCAutoItemLabel * r_label = [WZZBaseNVCAutoItemLabel labelWithMaxWidth:DEF_SCREEN_WIDTH-100 minWidth:0 line:0];
    WZZBaseNVCAutoItemSpace * r_space2 = [WZZBaseNVCAutoItemSpace spaceWithWidth:8];
    _basevc_rightButton = [WZZBaseNVCAutoItemView itemWithItemArr:@[r_space, r_label, r_space2] clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    _basevc_rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_basevc_navigationBar addSubview:_basevc_rightButton];
    [NSLayoutConstraint constraintWithItem:_basevc_rightButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_rightButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_rightButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    
#else
    const CGFloat barItemWidth = (DEF_SCREEN_WIDTH-8*4)/4.0f;
    const CGFloat barItemHeight = 44.0f;
    //-左按钮
    __weak WZZBaseVC * weakSelf = self;
    _basevc_leftButton = [[WZZBaseNVCItemView alloc] initWithFrame:CGRectMake(8, _basevc_navigationBar.frame.size.height/2.0f-barItemHeight/2.0f, barItemWidth, barItemHeight) text:@"返回" textColor:nil font:nil leftImage:[UIImage imageNamed:@"base_back"] leftImageWidth:30.0f rightImage:nil rightImageWidth:0 space:0.0f clickBlock:^{
        [weakSelf basevc_backClick];
    }];
    [_basevc_navigationBar addSubview:_basevc_leftButton];
    //-标题
    _basevc_titleLabel = [[WZZBaseNVCItemView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_basevc_leftButton.frame)+8, _basevc_navigationBar.frame.size.height/2.0f-barItemHeight/2.0f, barItemWidth*2, barItemHeight) text:self.title?self.title:@"" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17.0f] leftImage:nil rightImage:nil clickBlock:nil];
    [_basevc_navigationBar addSubview:_basevc_titleLabel];
    //-右按钮
    _basevc_rightButton = [[WZZBaseNVCItemView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_basevc_titleLabel.frame)+8, _basevc_navigationBar.frame.size.height/2.0f-barItemHeight/2.0f, barItemWidth, barItemHeight) text:nil textColor:nil font:nil leftImage:nil leftImageWidth:30.0f rightImage:nil rightImageWidth:0.0f space:0.0f clickBlock:nil];
    [_basevc_navigationBar addSubview:_basevc_rightButton];
#endif
    
    self.basevc_navigationBarColor = DEF_MAINCOLOR;
    
#if WZZBaseVC_UseConstant
    //使用constant布局，frame布局将无效
    //以下方法关闭frame到autolayout的转换过渡
    //_basevc_stateBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    _basevc_stateBar.translatesAutoresizingMaskIntoConstraints = NO;
    //给statebar布局，上左右高
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_stateBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:DEF_STATEBAR_HEIGHT].active = YES;
    
    _basevc_navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    //给navigation布局，上左右高
    [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_stateBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    _navgation_HeightCon = [NSLayoutConstraint constraintWithItem:_basevc_navigationBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44];
    _navgation_HeightCon.active = YES;
    
    _barLineView.translatesAutoresizingMaskIntoConstraints = NO;
    //给navigation的线布局，下左右高
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:_barLineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1].active = YES;
    
    ___realSelfView.translatesAutoresizingMaskIntoConstraints = NO;
    //给xib所在的___realSelfView初始布局
    _realSelfView_topCon = [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_basevc_navigationBar attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    _realSelfView_topCon.active = YES;
    [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    _realSelfView_BottomCon = [NSLayoutConstraint constraintWithItem:___realSelfView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-DEF_BOTTOM_SAFEAREA_HEIGHT];
    _realSelfView_BottomCon.active = YES;
#endif
    
    [self _superReloadUI];
}

- (void)_superReloadUI {
    //视图
#if WZZBaseVC_UseConstant
    _navgation_HeightCon.constant = _basevc_navigationBarHidden?0:44;
    _realSelfView_BottomCon.constant = _basevc_tabbarPlace?-(DEF_BOTTOM_SAFEAREA_HEIGHT+DEF_TABBAR_HEIGHT):-DEF_BOTTOM_SAFEAREA_HEIGHT;
#else
    CGFloat upspace = _basevc_navigationBarHidden?DEF_STATEBAR_HEIGHT:(DEF_STATEBAR_HEIGHT+44);
    CGFloat bottomspace = _basevc_tabbarPlace?(DEF_BOTTOM_SAFEAREA_HEIGHT+DEF_TABBAR_HEIGHT):DEF_BOTTOM_SAFEAREA_HEIGHT;
    [___realSelfView setFrame:CGRectMake(0, upspace, self.view.bounds.size.width, self.view.bounds.size.height-upspace-bottomspace)];
#endif
    
    //导航栏
    _basevc_navigationBar.hidden = _basevc_navigationBarHidden;
}

- (void)basevc_backClick {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 属性

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [_basevc_titleLabel.titleLabel setText:title];
}

- (void)setBasevc_navigationBarHidden:(BOOL)basevc_navigationBarHidden {
    _basevc_navigationBarHidden = basevc_navigationBarHidden;
    [self _superReloadUI];
}

- (void)setBasevc_navigationBarColor:(UIColor *)basevc_navigationBarColor {
    _basevc_navigationBarColor = basevc_navigationBarColor;
    [_basevc_stateBar setBackgroundColor:basevc_navigationBarColor];
    [_basevc_navigationBar setBackgroundColor:basevc_navigationBarColor];
}

- (void)setBasevc_tabbarPlace:(BOOL)basevc_tabbarPlace {
    _basevc_tabbarPlace = basevc_tabbarPlace;
    [self _superReloadUI];
}

- (void)setBasevc_stateBarTintColor:(WZZBaseVC_StateBarTintColor)basevc_stateBarTintColor {
    _basevc_stateBarTintColor = basevc_stateBarTintColor;
    //状态栏
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - 系统方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    switch (_basevc_stateBarTintColor) {
        case WZZBaseVC_StateBarTintColor_Black:
        {
            return UIStatusBarStyleDefault;
        }
            break;
        case WZZBaseVC_StateBarTintColor_White:
        {
            return UIStatusBarStyleLightContent;
        }
            break;
            
        default:
        {
            return ([WZZBaseVC isLightColor:_basevc_navigationBarColor])?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        }
            break;
    }
}

#pragma mark - 辅助方法

//判断颜色是不是亮色
+ (BOOL)isLightColor:(UIColor *)color {
    if (!color) {
        return YES;
    }
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    //    NSLog(@"%f %f %f", components[0], components[1], components[2]);
    
    CGFloat num = components[0] + components[1] + components[2];
    if (num < 382) {
        return NO;
    } else {
        return YES;
    }
}

//获取RGB值
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 bitmapInfo);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

@end
