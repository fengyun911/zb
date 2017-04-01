//
//  OpenCertificationViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/20.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "OpenCertificationViewController.h"
#import "IDInformationViewController.h"
@interface OpenCertificationViewController ()

@end

@implementation OpenCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开通认证支付";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
}
#pragma mark --------自定义方法
- (IBAction)nextButClick:(id)sender {
    //下一步按钮点击的方法
    [self.navigationController pushViewController:[[IDInformationViewController alloc]init] animated:YES];
}

@end
