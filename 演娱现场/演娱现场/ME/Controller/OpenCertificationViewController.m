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
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *numId;
@property (weak, nonatomic) IBOutlet UITextField *bankCard;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *serviceBut;

@end

@implementation OpenCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开通认证支付";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self addAGesutreRecognizerForYourView];
}
#pragma mark --------自定义方法
- (IBAction)nextButClick:(id)sender {
    if (!self.realName.text.length) {
        [self ShowComplitedHUDWith:@"请输入真实姓名"];
        return;
    }else if (self.numId.text.length < 15){
        [self ShowComplitedHUDWith:@"请输入正确的身份证号"];
        return;
    }else if (!self.bankCard.text.length){
        [self ShowComplitedHUDWith:@"请输入银行卡号"];
        return;
    }else if (!self.phone.text.length){
        [self ShowComplitedHUDWith:@"请输手机号"];
        return;
    }else if (self.serviceBut.selected != YES){
        [self ShowComplitedHUDWith:@"请选择服务协议"];
        return;
    }
    //下一步按钮点击的方法
    IDInformationViewController *idInformation= [[IDInformationViewController alloc]init];
    idInformation.realName = self.realName.text;
    idInformation.numId = self.numId.text;
    idInformation.bankCard = self.bankCard.text;
    idInformation.phone = self.phone.text;
    [self.navigationController pushViewController:idInformation animated:YES];
}
- (IBAction)serviceButClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

@end
