//
//  RegisterController.m
//  创美
//
//  Created by 汪洋 on 16/4/14.
//  Copyright © 2016年 chuangmei. All rights reserved.
//

#import "RegisterController.h"
@interface RegisterController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
   

    int _secondsCountDown;              //倒计时秒数
    NSTimer *_countDownTimer;               //倒计时时间器
    NSString *_yzm;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *captchaBut;
@property (weak, nonatomic) IBOutlet UITextField *captchaText;
@property (weak, nonatomic) IBOutlet UITextField *referralCode;
//选择
@property (weak, nonatomic) IBOutlet UIButton *agree;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *wart;
@property (weak, nonatomic) IBOutlet UIButton *zhuche;




@end

@implementation RegisterController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.captchaBut.cjr_acceptEventInterval = 2.0f;
    self.zhuche.cjr_acceptEventInterval = 2.0f;
    self.phoneNumber.width = ScreenWidth - 113 - 13;
    self.password.width = ScreenWidth - 113 - 13;
    self.captchaBut.x = ScreenWidth - 128;
    self.captchaText.width = ScreenWidth -113 - 129;
    self.wart.x = ScreenWidth - 128 -1;
    self.referralCode.width = ScreenWidth - 113 - 13;
    self.zhuche.width = ScreenWidth - 13*2;
    [self.scrollView layoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(0, 736);
    [self addAGesutreRecognizerForYourView];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
}
- (IBAction)agreeButClick:(UIButton *)sender {//注册按钮点击
   
    //判断输入的是否为空
    if (self.phoneNumber.text.length < 1) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号码"];
        return;
    }else if (self.password.text.length<1){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入密码"];
        return;
    }else if (self.captchaText.text.length<1){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输验证码"];
        return;
    }else if (self.agree.selected == NO){
        
    [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请确认注册协议"];
       return;
    }
    NSDictionary *dict = @{@"verifyCode":_captchaText.text,@"phoneNum":self.phoneNumber.text,@"password":self.password.text,};
    WYLog(@"%@",dict);
    [self ShowMBProgressHUD:@"注册中..."];
    //加载网络请求
    [WYHttpTool getHttps:REGIST_URL param:dict Success:^(NSDictionary *dict, BOOL success) {
        [self HideTheHUD];
        WYLog(@"%@",dict);
        if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"0"]) {
                        [self.view endEditing:YES];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"UserInfo"];
                        //强制写入
                         [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
            [[TKAlertCenter defaultCenter]postAlertWithMessage:dict[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        [self HideTheHUD];
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"网络加载失败..."];
    }];

    
    
    
//    [WYHttpTool post:REGISTER params:dict success:^(id json) {
//        [self HideTheHUD];
//        if ([json[@"state"]intValue] == 0) {
//            [[TKAlertCenter defaultCenter]postAlertWithMessage:json[@"msg"]];
//        }else{
//            [self.view endEditing:YES];
//            WYTabBarViewController *main = [[WYTabBarViewController alloc]init];
//          UIWindow * window = [[UIApplication sharedApplication]keyWindow];
//            window.rootViewController = main;
//            [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"UserInfo"];
//            //强制写入
//             [[NSUserDefaults standardUserDefaults] synchronize];
//
//        }
//        
//    } failure:^(NSError *error) {
//        WYLog(@"%@",error);
//        [self HideTheHUD];
//        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"网络加载失败..."];
//    }];
}

//代理代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return NO;
}
- (void)leftClick{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)butClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)captchaButClick:(UIButton *)sender {
    //获取验证码按钮点击
    if (self.phoneNumber.text.length < 1) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号码"];
        return;
    }
    
    NSDictionary *dict = @{@"phoneNum":self.phoneNumber.text};
    [self ShowMBProgressHUD:nil];
     WYLog(@"%@",dict);
    [WYHttpTool getHttps:GETVERIFYCODE param:dict Success:^(NSDictionary *dict, BOOL success) {
        [self HideTheHUD];
        WYLog(@"%@=%@",GETVERIFYCODE,dict);
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
-(void)timeFireMethod{
    _secondsCountDown--;
    
    [_captchaBut setTitle:[NSString stringWithFormat:@"%ds",_secondsCountDown] forState:UIControlStateDisabled];
    [_captchaBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    if(_secondsCountDown == 0)
    {
        if([_countDownTimer isValid]){
            [_countDownTimer invalidate];
            _countDownTimer = nil;
        }
        
        [_captchaBut setTitle:@"重新发送" forState:UIControlStateNormal];
        
        [_captchaBut setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
       
        _captchaBut.enabled = YES;

       
        
 
        
    }

}
- (void)addAGesutreRecognizerForYourView

{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
       [self.view addGestureRecognizer:tapGesture];
    
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
    [self.view endEditing:YES];
    
    
}


@end
