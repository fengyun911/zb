//
//  MeInformationViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/8.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "MeInformationViewController.h"
#import "UIImageView+WebCache.h"
@interface MeInformationViewController ()

@end

@implementation MeInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = LIVETTOPLABEL;
    //设置页面
    [self setupUi];
}
#pragma mark --------设置页面
- (void)setupUi{
    //顶部的分割View
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexString:@"ececec"];
    [self.view addSubview:topView];
    topView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(13.5);
    //设置头像
    UILabel *imageLabel = [self addLabel:@"    头像"];
    imageLabel.sd_layout.topSpaceToView(topView,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(66);

    
    //设置头像图片
    UIImageView *imageLabelView = [[UIImageView alloc]init];
    [self.view addSubview:imageLabelView];
    [imageLabelView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"] placeholderImage:nil];
    imageLabelView.sd_layout.rightSpaceToView(self.view,WYmargin*4).topSpaceToView(topView,WYmargin).widthIs(46).heightIs(46);
    // 设置圆角的大小
    imageLabelView.layer.cornerRadius = imageLabelView.width/2;
    [imageLabelView.layer setMasksToBounds:YES];
    
    //设置右边的按钮
    WyBut *imageLabelBut = [self addWybut:0];
    imageLabelBut.sd_layout.topSpaceToView(topView,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(66);
    //头像的分割线
    UIView *imageLabelWire = [self addView];
    imageLabelWire.sd_layout.leftSpaceToView(self.view,WYmargin).rightSpaceToView(self.view,WYmargin).topSpaceToView(imageLabel,0).heightIs(1);
/*****************设置姓名******************/
    //设置姓名
    UILabel *nameLabel = [self addLabel:@"    姓名"];
    nameLabel.sd_layout.topSpaceToView(imageLabelWire,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    
     //设置内容
    UILabel *nameTextLabel = [self addRightLabel:@"小叶儿"];
    nameTextLabel.sd_layout.topEqualToView(nameLabel).rightSpaceToView(self.view,WYmargin*4).heightIs(48.5).widthIs(ScreenWidth/2);
    //设置右边的按钮
    WyBut *nameLabelBut = [self addWybut:1];
    nameLabelBut.sd_layout.topEqualToView(nameLabel).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    
    
    //分割线
    UIView *nameLabelWire = [self addView];
    nameLabelWire.sd_layout.leftSpaceToView(self.view,WYmargin).rightSpaceToView(self.view,WYmargin).topSpaceToView(nameLabel,0).heightIs(1);
/*****************设置身份证号******************/
    //设置姓名
    UILabel *cardLabel = [self addLabel:@"    身份证号"];
    cardLabel.sd_layout.topSpaceToView(nameLabelWire,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //设置内容
    UILabel * cardTextLabel = [self addRightLabel:@"340404199008160816"];
    cardTextLabel.sd_layout.topEqualToView(cardLabel).rightSpaceToView(self.view,WYmargin*4).heightIs(48.5).widthIs(ScreenWidth/2);
    //设置右边的按钮
    WyBut *cardLabelBut = [self addWybut:2];
    cardLabelBut.sd_layout.topEqualToView(cardLabel).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //分割线
    UIView *cardLabelWire = [self addView];
    cardLabelWire.sd_layout.leftSpaceToView(self.view,WYmargin).rightSpaceToView(self.view,WYmargin).topSpaceToView(cardLabel,0).heightIs(1);
/*****************手机号码******************/
    //设置姓名
    UILabel *phoneLabel = [self addLabel:@"    手机号码"];
    phoneLabel.sd_layout.topSpaceToView(cardLabelWire,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //设置内容
    UILabel * phoneTextLabel = [self addRightLabel:@"18612821523"];
    phoneTextLabel.sd_layout.topEqualToView(phoneLabel).rightSpaceToView(self.view,WYmargin*4).heightIs(48.5).widthIs(ScreenWidth/2);
    //设置右边的按钮
    WyBut *phoneLabelBut = [self addWybut:3];
    phoneLabelBut.sd_layout.topEqualToView(phoneLabel).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);

    
/********************邮箱*********************/
    //底部的分割View
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"ececec"];
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(phoneLabelBut,0).heightIs(13.5);
    //设置姓名
    UILabel *emailLabel = [self addLabel:@"    邮箱"];
    emailLabel.sd_layout.topSpaceToView(bottomView,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //设置内容
    UILabel * emailTextLabel = [self addRightLabel:@"554788482@qq.com"];
    emailTextLabel.sd_layout.topEqualToView(emailLabel).rightSpaceToView(self.view,WYmargin*4).heightIs(48.5).widthIs(ScreenWidth/2);
    //设置右边的按钮
    WyBut *emailLabelBut = [self addWybut:4];
    emailLabelBut.sd_layout.topEqualToView(emailLabel).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //分割线
    UIView *emailLabelWire = [self addView];
    emailLabelWire.sd_layout.leftSpaceToView(self.view,WYmargin).rightSpaceToView(self.view,WYmargin).topSpaceToView(emailLabel,0).heightIs(1);
/************************地址*********************/
    //设置姓名
    UILabel *addressLabel = [self addLabel:@"    地址"];
    addressLabel.sd_layout.topSpaceToView(emailLabelWire,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //设置内容
    UILabel *addressTextLabel = [self addRightLabel:@"北京市 朝阳区"];
    addressTextLabel.sd_layout.topEqualToView(addressLabel).rightSpaceToView(self.view,WYmargin*4).heightIs(48.5).widthIs(ScreenWidth/2);
    //设置右边的按钮
    WyBut *addressLabelBut = [self addWybut:5];
    addressLabelBut.sd_layout.topEqualToView(addressLabel).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //分割线
    UIView * addressLabelWire = [self addView];
    addressLabelWire.sd_layout.leftSpaceToView(self.view,WYmargin).rightSpaceToView(self.view,WYmargin).topSpaceToView(addressLabel,0).heightIs(1);
/************************密码*********************/
    //设置姓名
    UILabel *passwordLabel = [self addLabel:@"    密码"];
    passwordLabel.sd_layout.topSpaceToView(addressLabelWire,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //设置内容
    UILabel *passwordTextLabel = [self addRightLabel:@"********"];
    passwordTextLabel.sd_layout.topEqualToView(passwordLabel).rightSpaceToView(self.view,WYmargin*4).heightIs(48.5).widthIs(ScreenWidth/2);
    //设置右边的按钮
    WyBut *passwordLabelBut = [self addWybut:5];
    passwordLabelBut.sd_layout.topEqualToView(passwordLabel).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(48.5);
    //分割线
    UIView *passwordLabelWire = [self addView];
   passwordLabelWire.sd_layout.leftSpaceToView(self.view,WYmargin).rightSpaceToView(self.view,WYmargin).topSpaceToView(passwordLabel,0).heightIs(1);

}
#pragma mark --------创建label
- (UILabel *)addLabel:(NSString *)title{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    [self.view addSubview:label];
    label.font = Font18;
    label.textColor = [UIColor colorWithHexString:@"292929"];
    return label;
}
#pragma mark --------创建分割线
- (UIView *)addView{
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"d0d0d0"];
    return view;
}
#pragma mark --------创建分割线
- (UILabel *)addRightLabel:(NSString *)title{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentRight;
    label.text = title;
    [self.view addSubview:label];
    label.font = Font18;
    label.textColor = [UIColor colorWithHexString:@"989898"];
    return label;
}
#pragma mark --------创建按钮
- (WyBut *)addWybut:(NSInteger)tag{
    WyBut * but =[[WyBut alloc]init];
    but.tag = tag;
    [but addTarget:self action:@selector(wybutClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [but setImage:[UIImage imageNamed:@"下一页-拷贝-3"] forState:UIControlStateNormal];

    but.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin*1.5);
    return but;
    
}
#pragma mark --------按钮点击
- (void)wybutClick:(WyBut *)but{
    
    switch (but.tag) {
        case 0:{//头像点击
           
        }
            break;
        case 1:{//姓名点击
            
        }
            break;
        case 2:{//身份证号
            
        }
            break;
        case 3:{//手机号码
            
        }
            break;
        case 4:{//邮箱
            
        }
            break;
        case 5:{//地址
            
        }
            break;
        case 6:{//密码
            
        }
            break;
            
        default:
            break;
    }

}
@end
