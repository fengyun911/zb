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
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.nameTextLabel.tag == 100) {
        self.nameTextLabel.text = textField.text;
    }else if (self.cardTextLabel.tag == 100){
         self.cardTextLabel.text = textField.text;
    }else if (self.phoneTextLabel.tag == 100){
        self.phoneTextLabel.text = textField.text;
    }else if (self.emailTextLabel.tag == 100){
        self.emailTextLabel.text = textField.text;
    }else if (self.addressTextLabel.tag == 100){
        self.addressTextLabel.text = textField.text;
    }else if (self.passwordTextLabel.tag == 100){
        self.passwordTextLabel.text = textField.text;
    }
    self.rightBut.hidden = NO;
}


@end
