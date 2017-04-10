//
//  LoginController.m
//  创美
//
//  Created by 汪洋 on 16/4/12.
//  Copyright © 2016年 chuangmei. All rights reserved.
//
#import "LoginController.h"
#import "registerView.h"
@interface LoginController ()<UITextFieldDelegate>
{
  
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
@property (weak, nonatomic) IBOutlet UIButton *topLogin;
@property (weak, nonatomic) IBOutlet UIButton *retrievePassWord;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *registerBut;
@property (weak, nonatomic) IBOutlet UIImageView *triangle;
@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;
@property(nonatomic,weak)registerView *registerView;
@end
@implementation LoginController
- (registerView *)registerView{
    if (!_registerView) {
        registerView *registerView = [[[NSBundle mainBundle]loadNibNamed:@"registerView" owner:self options:nil]lastObject];
        _registerView = registerView;
        
        registerView.frame = CGRectMake(0, 128,self.view.width,self.view.height - 128);
        registerView.hidden = YES;
        [self.view addSubview:registerView];
    }
    return  _registerView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  

    
}
#pragma mark --------退出输入框
- (void)addAGesutreRecognizerForYourView

{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
    [self.view endEditing:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerAdd:) name:@"register" object:nil];
    //设置页面
    self.triangle.x = ScreenWidth/4 -WYmargin;
    [self addAGesutreRecognizerForYourView];
    self.login.cjr_acceptEventInterval = 2.0f;
    
}
#pragma mark ---------注册的通知
- (void)registerAdd:(NSNotification *)not{
  
    NSDictionary *dict = not.userInfo;
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
            //请求登陆登陆接口
            NSDictionary *loginDict = @{@"phoneNum":dict[@"phoneNum"],@"password":dict[@"password"]};
            [WYHttpTool getHttps:LOGIN param:loginDict Success:^(NSDictionary *dict, BOOL success) {
                [self HideTheHUD];
                WYLog(@"%@",dict);
                if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"0"]) {
                    
                    [[NSUserDefaults standardUserDefaults]
                     setObject:dict[@"data"] forKey:@"user"];
                    //强制写入
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self ShowComplitedHUDWith:dict[@"msg"]];
                }
                
            } fail:^(NSError *error) {
                [self HideTheHUD];
                [self ShowComplitedHUDWith:@"网络加载失败..."];
            }];

            
            
        }else{
            [self ShowComplitedHUDWith:dict[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        [self HideTheHUD];
        [self ShowComplitedHUDWith:@"网络加载失败..."];
       
    }];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
#pragma mark --------自定义私有方法
- (IBAction)leftClick:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//顶部登陆按钮点击方法
- (IBAction)topLoginButClick:(id)sender {
    self.loginScrollView.hidden = NO;
    self.registerView.hidden = YES;
    self.triangle.x = ScreenWidth/4 -WYmargin;
}
//顶部注册按钮点击方法
- (IBAction)registerButClick:(id)sender {
    self.loginScrollView.hidden = YES;
    self.registerView.hidden = NO;
    self.triangle.x = ScreenWidth -(ScreenWidth/4 +WYmargin);
}
//点击显示明文和暗文
- (IBAction)hideButClick:(id)sender {
    self.loginPassword.secureTextEntry = !self.loginPassword.secureTextEntry;
    
    NSString* text =self.loginPassword.text;
    self.loginPassword.text = @" ";
    self.loginPassword.text = text;
}
//登陆按钮点击
- (IBAction)loginButClick:(id)sender {
        NSDictionary *dict = @{@"phoneNum":self.phoneNumber.text,@"password":self.loginPassword.text};
        [WYHttpTool getHttps:LOGIN param:dict Success:^(NSDictionary *dict, BOOL success) {
            [self HideTheHUD];
            WYLog(@"%@",dict);
            if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"0"]) {
    
                [[NSUserDefaults standardUserDefaults]
                 setObject:dict[@"data"] forKey:@"user"];
                //强制写入
                [[NSUserDefaults standardUserDefaults] synchronize];
                 [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self ShowComplitedHUDWith:dict[@"msg"]];
            }
           
        } fail:^(NSError *error) {
            [self HideTheHUD];
            [self ShowComplitedHUDWith:@"网络加载失败..."];
        }];

}

@end
