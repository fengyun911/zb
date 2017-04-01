//
//  BaseViewController.m
//  TaiLongBank
//
//  Created by 😀😬😁😂😃😄😅😆 on 16/2/25.
//  Copyright © 2016年 😀😬😁😂😃😄😅😆. All rights reserved.
//

#import "BaseViewController.h" 
#import "MBProgressHUD+Add.h"
@interface BaseViewController()
{
   
  
    
    
}
@end
@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
}


- (void)ShowMBProgressHUD:(NSString*)message{
    if (message) {
     [MBProgressHUD showLoadingMessageWith:nil WithView:self.view];
    }else{
    [MBProgressHUD showLoadingMessageWith:nil WithView:self.view];
    }
}

-(void)ShowMBProgressHUD
{
    [MBProgressHUD showLoadingMessageWith:@"加载中...." WithView:self.view];
    
    
        [self performSelector:@selector(HideTheHUD) withObject:nil afterDelay:10];
        
    
}
-(void)ShowComplitedHUDWith:(NSString *)message
{

    [MBProgressHUD showProgressHUDCompleteMessage:message view:self.view];

}
-(void)HideTheHUD
{
 
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
   

}
-(void)hideTheTabbar
{
    
    // self.view.frame=CGRectMake(0, 0, 320,480+(iPhone5?88:0));
    
    
        
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(){
            
            
            self.tabBarController.tabBar.frame=CGRectMake(0, SCREEN.height, 320, 49);
            
            
            
        }completion:NULL];
        
}
    
-(void)showTheTabbar
{
    
    
    
    
    
        
        [UIView animateWithDuration:0.3 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(){
            
            self.tabBarController.tabBar.frame=CGRectMake(0, SCREEN.height-49, SCREEN.width, 49);
            
            
        }completion:NULL];
        
        
        
    
    
}
#pragma mark - Handle URL Scheme

- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"] ?: [bundleInfo valueForKey:@"CFBundleName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
}

#pragma mark===error code 
- (NSString *)errorMsgWithErrorCode:(NSInteger)code
{
    NSString * tempErrorMsg = nil;
    
    switch (code) {
        case 1:
            tempErrorMsg = @"网络发生错误";
            break;
        case 2:
            tempErrorMsg = @"请求超时";
            break;
        default:
            tempErrorMsg = @"请求失败";
            break;
    }
    
    return tempErrorMsg;
}
- (void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
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
@end
