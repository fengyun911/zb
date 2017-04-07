//
//  registerView.m
//  演娱现场
//
//  Created by 汪洋 on 2017/4/6.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "registerView.h"
@interface registerView()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *codeBut;

@end
@implementation registerView
//注册按钮点击
- (IBAction)registerButClick:(id)sender {
   
    NSDictionary *dict = @{@"verifyCode":_code.text,@"phoneNum":self.phone.text,@"password":self.passWord.text,};
  
    [[NSNotificationCenter defaultCenter]postNotificationName:@"register" object:nil userInfo:dict];
}
//获取验证码点击
- (IBAction)codeButClick:(id)sender {
    NSDictionary *dict = @{@"phoneNum":self.phone.text};
    WYLog(@"%@",dict);
    [WYHttpTool getHttps:GETVERIFYCODE param:dict Success:^(NSDictionary *dict, BOOL success) {
        if ([[NSString stringWithFormat:@"%@",dict[@"code"]] isEqualToString:@"0"]) {
            WYLog(@"%@",dict);
                  }else{
           
        }
        
    } fail:^(NSError *error) {
 
    }];

    [self openCountdown];
}
//显示明文和密文
- (IBAction)passWordButClick:(id)sender {
    self.passWord.secureTextEntry = !self.passWord.secureTextEntry;
    
    NSString* text =self.passWord.text;
    self.passWord.text = @" ";
    self.passWord.text = text;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.codeBut.layer setBorderColor:[UIColor colorWithHexString:@"c4c4c4"].CGColor];
    [self.codeBut.layer setBorderWidth:1];
    [self.codeBut.layer setMasksToBounds:YES];
}
// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.codeBut setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.codeBut setTitleColor:[UIColor colorWithHexString:@"FB8557"] forState:UIControlStateNormal];
                self.codeBut.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.codeBut setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.codeBut setTitleColor:[UIColor colorWithHexString:@"979797"] forState:UIControlStateNormal];
                self.codeBut.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
@end
