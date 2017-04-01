//
//  WYNavIgationController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "WYNavIgationController.h"

@interface WYNavIgationController ()

@end

@implementation WYNavIgationController
//初始化导航条穿透效果
- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.translucent = NO;
    }
    return self;
}
//第一次加载类的时候调用
+ (void)initialize{
    //设置导航栏背景颜色
//    [UINavigationBar appearance].barTintColor = WYRGb(255,255, 255);
    [UINavigationBar appearance].barTintColor = NAVBG;
    //设置导航栏标题文字颜色
    
    //1.创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    
    color[NSFontAttributeName] = Font20;
    
    color[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"ffffff"];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:color];
    
    
    //拿到整个导航控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    //设置字典的字体大小
    NSMutableDictionary * font = [NSMutableDictionary dictionary];
    
    font[NSFontAttributeName] = Font16;
    //    //设置字典的颜色
    //
    font[NSForegroundColorAttributeName] = mainBg;
    
    //将字典给item
    
    [item setTitleTextAttributes:font forState:UIControlStateNormal];
    
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *bar = [UIBarButtonItem itemWithTarget:self action:@selector(backBtnClick) image:@"返回-(1)"  highImage:@"返回-(1)"];
        viewController.navigationItem.leftBarButtonItem = bar;
        
    }
    
    [super pushViewController:viewController animated:YES];
    
    
    
}

- (void)backBtnClick
{
    [self popViewControllerAnimated:YES];
}

@end
