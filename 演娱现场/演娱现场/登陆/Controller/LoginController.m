//
//  LoginController.m
//  创美
//
//  Created by 汪洋 on 16/4/12.
//  Copyright © 2016年 chuangmei. All rights reserved.
//
#import "RegisterController.h"
#import "LoginController.h"
#import "ChangePasswordController.h"
#import "userModel.h"
@interface LoginController ()<UITextFieldDelegate>
{
    UIButton * doneInKeyboardButton;
    BOOL wancheng;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButClick;
@property (weak, nonatomic) IBOutlet UIButton *retrievePassWord;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation LoginController
//注册按钮点击
- (IBAction)registerButClick:(id)sender {
    RegisterController * registerController = [[RegisterController alloc]init];
    [doneInKeyboardButton removeFromSuperview];
    [self.view endEditing: YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.navigationController pushViewController:registerController animated:YES];
        wancheng = NO;
    });

    
    
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //注册键盘显示通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    //注销键盘显示通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}

// 键盘出现处理事件
- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    //记录第一次弹出
    wancheng = YES;
    // NSNotification中的 userInfo字典中包含键盘的位置和大小等信息
    NSDictionary *userInfo = [notification userInfo];
    // UIKeyboardAnimationDurationUserInfoKey 对应键盘弹出的动画时间
    CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // UIKeyboardAnimationCurveUserInfoKey 对应键盘弹出的动画类型
    NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    //数字彩,数字键盘添加“完成”按钮
    if (doneInKeyboardButton){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];//设置添加按钮的动画时间
        [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];//设置添加按钮的动画类型
        
        //设置自定制按钮的添加位置(这里为数字键盘添加“完成”按钮)
        doneInKeyboardButton.transform=CGAffineTransformTranslate(doneInKeyboardButton.transform, 0, -53);
        
        [UIView commitAnimations];
    }
    
}

// 键盘消失处理事件
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    // NSNotification中的 userInfo字典中包含键盘的位置和大小等信息
    NSDictionary *userInfo = [notification userInfo];
    // UIKeyboardAnimationDurationUserInfoKey 对应键盘收起的动画时间
    CGFloat animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if (doneInKeyboardButton.superview)
    {
        [UIView animateWithDuration:animationDuration animations:^{
            //动画内容，将自定制按钮移回初始位置
            doneInKeyboardButton.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //动画结束后移除自定制的按钮
            [doneInKeyboardButton removeFromSuperview];
        }];
        
    }
}

//初始化，数字键盘“完成”按钮
- (void)configDoneInKeyBoardButton{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    //初始化
    if (doneInKeyboardButton == nil)
    {
        
        doneInKeyboardButton = [[UIButton alloc]init];
        [doneInKeyboardButton setTitle:@"" forState:UIControlStateNormal];
        [doneInKeyboardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        doneInKeyboardButton.frame = CGRectMake(0, screenHeight, 106, 53);
       
        doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        [doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    //每次必须从新设定“完成”按钮的初始化坐标位置
    doneInKeyboardButton.frame = CGRectMake(0, screenHeight, 106, 53);
    


    
    //由于ios8下，键盘所在的window视图还没有初始化完成，调用在下一次 runloop 下获得键盘所在的window视图
    [self performSelector:@selector(addDoneButton) withObject:nil afterDelay:0.0f];
    
}

- (void) addDoneButton{
    //获得键盘所在的window视图
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    [tempWindow addSubview:doneInKeyboardButton];    // 注意这里直接加到window上
    
}


//点击“完成”按钮事件，收起键盘
-(void)finishAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
    wancheng = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.login.cjr_acceptEventInterval = 2.0f;
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftClick) image:@"close_unselected" highImage:@"close_selected"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    wancheng = NO;
}
//textFiexe的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [self loginButClick:_login];
    return  NO;
}

- (IBAction)loginButClick:(UIButton *)sender {
      wancheng = NO;
    [self.view endEditing:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.phoneNumber.text.length < 1) {//判断手机号码
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入手机号码"];
            return;
        }
        
        if (self.loginPassword.text.length <1) {//判断登陆密码
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入登录密码"];
            return;
        }
        
        
        [self ShowMBProgressHUD:@"登陆中..."];
        NSDictionary *dict = @{@"phoneNum":self.phoneNumber.text,@"password":self.loginPassword.text};
        [WYHttpTool getHttps:LOGIN param:dict Success:^(NSDictionary *dict, BOOL success) {
            [self HideTheHUD];
            if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"0"]) {
               //发送通知，更新数据信息
//                      [[NSNotificationCenter defaultCenter]postNotificationName:@"updataGuanzhu" object:nil];
                
        [[NSUserDefaults standardUserDefaults]
                                setObject:dict[@"data"] forKey:@"user"];
            //强制写入
        [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[TKAlertCenter defaultCenter]postAlertWithMessage:dict[@"msg"]];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        } fail:^(NSError *error) {
            [self HideTheHUD];
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"网络加载失败..."];
        }];
//        [WYHttpTool post:LOGIN params:dict success:^(id json) {
//            WYLog(@"%@",json);
//            if ([json[@"state"] intValue] == 0) {
//                //隐藏
//                [self HideTheHUD];
//                [[TKAlertCenter defaultCenter]postAlertWithMessage:json[@"msg"]];
//            }else{
//                [self HideTheHUD];
//                [self dismissViewControllerAnimated:YES completion:nil];
//                userModel *user = [userModel objectWithKeyValues:json[@"data"]];
////                [[NSUserDefaults standardUserDefaults]
////                 setObject:user forKey:@"user"];
////                //强制写入
////                 [[NSUserDefaults standardUserDefaults] synchronize];
//                //保存用户信息到本地
//                [AccountTool saveAccount:user];
//                //注册极光推送
//                [JPUSHService setAlias:user.loginAccount callbackSelector:nil object:nil];
//            
////                //发送通知，更新数据信息
////                [[NSNotificationCenter defaultCenter]postNotificationName:@"updataGuanzhu" object:nil];
//                
//            }
//        } failure:^(NSError *error) {
//            WYLog(@"%@",error);
//            [self HideTheHUD];
//            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"网络加载失败..."];
//        }];
//
//        
    });
    
    
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag == 100) {
        [self configDoneInKeyBoardButton];
        if (wancheng == YES) {
        doneInKeyboardButton.frame = CGRectMake(0, MainScreenHeight-53, 106, 53);
            
        }

    }else if (textField.tag == 101){
        [doneInKeyboardButton removeFromSuperview];
    }
    
}
//点击找回密码
- (IBAction)changePassword:(id)sender {
    ChangePasswordController *changePasswor = [[ChangePasswordController alloc]init];
    [self.navigationController pushViewController:changePasswor animated:YES];
}
- (void)leftClick{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
