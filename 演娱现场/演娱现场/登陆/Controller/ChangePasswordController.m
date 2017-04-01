//
//  ChangePasswordController.m
//  创美
//
//  Created by 汪洋 on 16/4/21.
//  Copyright © 2016年 chuangmei. All rights reserved.
//

#import "ChangePasswordController.h"
@interface ChangePasswordController ()<UITextFieldDelegate>
{
    int _secondsCountDown;              //倒计时秒数
    NSTimer *_countDownTimer;               //倒计时时间器
     NSString *_yzm;                    //验证码
}
@property (weak, nonatomic) IBOutlet UITextField *shouJiHaoMa;
@property (weak, nonatomic) IBOutlet UITextField *yanZhengMa;
@property (weak, nonatomic) IBOutlet UITextField *xinMima;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *code;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    //设置控制器
    [self setupView];
    
}
- (void)setupView{
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    self.title = @"找回密码";
  
    //添加手势监听
//    [self addAGesutreRecognizerForYourView];

}
- (void)leftClick{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.view endEditing:YES];
    return NO;
}
#pragma mark --------自定义私有方法
-(void)timeFireMethod{
    _secondsCountDown--;
    
    [_code setTitle:[NSString stringWithFormat:@"%ds",_secondsCountDown] forState:UIControlStateDisabled];
    [_code setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if(_secondsCountDown == 0)
    {
        if([_countDownTimer isValid]){
            [_countDownTimer invalidate];
            _countDownTimer = nil;
        }
        
        [_code setTitle:@"重新发送" forState:UIControlStateNormal];
        
        [_code setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
        
        _code.enabled = YES;
    }
    
}
//更改密码
- (IBAction)changeButClick:(UIButton *)sender {
    //判断输入的是否为空
    if (_shouJiHaoMa.text.length < 1) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号码"];
        return;
    }else if (_yanZhengMa.text.length<1){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入验证码"];
        return;
    }else if (_xinMima.text.length<1){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输新密码"];
        return;
    }else if (_password.text.length<1){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输确认密码"];
    }
    
    //发送网络请求，进行加密
    NSDictionary *dict = @{@"loginAccount":_shouJiHaoMa.text,
                           @"verifycode":_yanZhengMa.text,
                           @"newpassword":[NSString getmd5WithString:_xinMima.text],
                           @"anewpassword":[NSString getmd5WithString:_password.text]};
    [self ShowMBProgressHUD:@"更改中..."];
//    [WYHttpTool post:MODIFYPASSWORD params:dict success:^(id json) {
//        WYLog(@"%@=%@",json,_yanZhengMa.text);
//        [self HideTheHUD];
//        if ([json[@"state"]intValue] == 0) {//没有成功
//            [[TKAlertCenter defaultCenter]postAlertWithMessage:json[@"msg"]];
//        }else{
//        
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//    } failure:^(NSError *error) {
//        [self HideTheHUD];
//        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"网络加载失败..."];
//        WYLog(@"%@",error);
//    }];
}
//获取验证码
- (IBAction)codeButClick:(UIButton *)sender {
    //获取验证码按钮点击
    if (self.shouJiHaoMa.text.length < 1) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号码"];
        return;
    }
    NSDictionary *dict = @{@"phoneNum":self.shouJiHaoMa.text};
    [self ShowMBProgressHUD:nil];
    [WYHttpTool postHttps:GETVERIFYCODE param:dict Success:^(NSDictionary *dict, BOOL success) {
        [self HideTheHUD];
        WYLog(@"%@",dict);
        if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"0"]) {
            _secondsCountDown = 60;//60秒倒计时
            
            sender.enabled = NO;
            _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                               target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
            [_countDownTimer fire];
        }else{
            [[TKAlertCenter defaultCenter]postAlertWithMessage:dict[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        [self HideTheHUD];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"网络加载失败..."];
    }];


}
@end
