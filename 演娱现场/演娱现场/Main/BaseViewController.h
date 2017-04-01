//
//  BaseViewController.h
//  TaiLongBank
//
//  Created by 😀😬😁😂😃😄😅😆 on 16/2/25.
//  Copyright © 2016年 😀😬😁😂😃😄😅😆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface BaseViewController : UIViewController
-(void)ShowMBProgressHUD;
-(void)ShowComplitedHUDWith:(NSString *)message;
-(void)HideTheHUD;
-(void)hideTheTabbar;
-(void)showTheTabbar;
///**自定义加载查询*/
- (void)ShowMBProgressHUD:(NSString*)message;
#pragma mark - Handle URL Scheme

- (NSString *)getApplicationName;

- (NSString *)getApplicationScheme;


- (NSString *)errorMsgWithErrorCode:(NSInteger)code;
/**
 * 错误码的意思
**/
- (void)addAGesutreRecognizerForYourView;
@end
