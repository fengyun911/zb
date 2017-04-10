//
//  personInformationModifyViewController.h
//  演娱现场
//
//  Created by 汪洋 on 2017/4/5.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "BaseViewController.h"

@interface personInformationModifyViewController : BaseViewController
//姓名
@property(nonatomic,strong)UILabel *nameTextLabel;
//身份证号
@property(nonatomic,strong)UILabel *cardTextLabel;
//手机号码
@property(nonatomic,strong)UILabel *phoneTextLabel;
//邮箱
@property(nonatomic,strong)UILabel *emailTextLabel;
//地址
@property(nonatomic,strong)UILabel *addressTextLabel;
//密码
@property(nonatomic,strong)UILabel *passwordTextLabel;
@property(nonatomic,strong)WyBut *rightBut;
@end
