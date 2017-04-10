//
//  meWantInvestmentViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/4/6.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "meWantInvestmentViewController.h"

@interface meWantInvestmentViewController ()
@property (weak, nonatomic) IBOutlet UIButton *minusBut;
@property (weak, nonatomic) IBOutlet UIButton *plusBut;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@end

@implementation meWantInvestmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认投资";
    //设置页面布局
    [self.amount.layer setBorderColor:[UIColor colorWithHexString:@"c4c4c4"].CGColor];
    [self.amount.layer setBorderWidth:1];
    [self.amount.layer setMasksToBounds:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark --------自定义私有方法
//减少的按钮点击
- (IBAction)minusButClick:(id)sender {
    NSInteger amount = [self.amount.text integerValue];
    if (amount > 5000) {
        amount = amount -5000;
    }else{
        amount = 0;
    }
    self.amount.text = [NSString stringWithFormat:@"%zd",amount];
}
//增加的按钮点击
- (IBAction)plusButClcik:(id)sender {
    
    NSInteger amount = [self.amount.text integerValue];

    amount = amount +5000;
  
    self.amount.text = [NSString stringWithFormat:@"%zd",amount];
}
//立即投资的按钮点击
- (IBAction)InvestmentButClick:(id)sender {
}

@end
