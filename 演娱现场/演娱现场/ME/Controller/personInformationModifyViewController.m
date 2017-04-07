//
//  personInformationModifyViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/4/5.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "personInformationModifyViewController.h"

@interface personInformationModifyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation personInformationModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;  
    
}

@end
