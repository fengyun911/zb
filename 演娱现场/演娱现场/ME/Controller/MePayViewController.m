//
//  MePayViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/14.
//  Copyright © 2017年 yyxc. All rights reserved.
//  充值

#import "MePayViewController.h"

@interface MePayViewController ()

@end

@implementation MePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    self.view.backgroundColor = WYRGb(237, 238, 239);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
