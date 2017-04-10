//
//  PersonCenterViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/7.
//  Copyright © 2017年 yyxc. All rights reserved.
#import "MeAllViewController.h"
#import "MeIntegralViewController.h"
#import "PersonCenterViewController.h"
#import "UIImageView+WebCache.h"
#import "MeInformationViewController.h"
#import "MePropertyViewController.h"
#import "MeInvestmentViewController.h"
#import "MeBankCardViewController.h"
#import "OpenCertificationViewController.h"
@interface PersonCenterViewController ()
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation PersonCenterViewController
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView*scrollView = [[UIScrollView alloc]init];
        scrollView.frame = self.view.bounds;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    
    return _scrollView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置ui
    [self setupUi];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark--------设置ui
- (void)setupUi{
    self.title = @"个人中心";
    self.view.backgroundColor = NAVBG;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
  //顶部的分割线
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexString:@"616161"];
    [self.scrollView addSubview:topView];
    topView.sd_layout.leftEqualToView(self.scrollView).topEqualToView(self.scrollView).rightEqualToView(self.scrollView).heightIs(1);
    //头像
    UIImageView *photoImageView = [[UIImageView alloc]init];
    [self.scrollView addSubview:photoImageView];
    
    [photoImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"] placeholderImage:nil];
    photoImageView.sd_layout.leftSpaceToView(_scrollView,WYmargin*1.5).topSpaceToView(_scrollView,WYmargin).widthIs(64).heightIs(64);
    // 设置圆角的大小
    photoImageView.layer.cornerRadius = photoImageView.width/2;
    [photoImageView.layer setMasksToBounds:YES];
    //设置标题
    UILabel *title = [[UILabel alloc]init];
    [_scrollView addSubview:title];
    title.font = Font18;
    title.textColor = [UIColor colorWithHexString:@"ffffff"];
    title.text = @"wangyang";
    title.sd_layout.leftSpaceToView(photoImageView,WYmargin*1.5).topEqualToView(photoImageView).widthIs(150).heightIs(photoImageView.height/2);
    
    //设置内容
    UILabel *text = [[UILabel alloc]init];
    [_scrollView addSubview:text];
    text.font = Font16;
    text.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    text.text = @"个人信息:头像,密码";
    text.sd_layout.leftSpaceToView(photoImageView,WYmargin*1.5).topSpaceToView(title,0).widthIs(150).heightIs(photoImageView.height/2);
    
    //设置右边按钮
    WyBut *rightBut = [[WyBut alloc]init];
    rightBut.tag = 0;
    [rightBut addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin*1.5);
    [_scrollView addSubview:rightBut];
    [rightBut setImage:[UIImage imageNamed:@"下一页-拷贝-3"] forState:UIControlStateNormal];
    rightBut.sd_layout.rightEqualToView(_scrollView).topEqualToView(_scrollView).topEqualToView(_scrollView).heightIs(84);
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"616161"];
    [self.scrollView addSubview:bottomView];
    bottomView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(rightBut,0).rightEqualToView(self.scrollView).heightIs(1);
   UIView *butBottomView = nil;//记录循环最后一个View的位置
    //遍历4个按钮
    for (int i = 0; i <4; i++) {
        
        WyBut *but1 = [[WyBut alloc]init];
        but1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        but1.imageEdgeInsets = UIEdgeInsetsMake(0, WYmargin*1.5, 0, 0);
        but1.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin*3, 0, 0);
        [but1 setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        but1.titleLabel.font = Font18;
        [self.scrollView addSubview:but1];
        WyBut *but2 = [[WyBut alloc]init];
        but2.tag = i+1;
        [self.scrollView addSubview:but2];
        but1.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(bottomView,i*65).rightEqualToView(self.scrollView).heightIs(64);
        
        but2.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(bottomView,i*65).rightEqualToView(self.scrollView).heightIs(64);
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"616161"];
        [self.scrollView addSubview:bottomView];
        bottomView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(but2,0).rightEqualToView(self.scrollView).heightIs(1);
        
        butBottomView = bottomView;
        
        [but2 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        but2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        but2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin*1.5);
        [but2 setImage:[UIImage imageNamed:@"下一页-拷贝-3"] forState:UIControlStateNormal];
        if (i == 0) {//我的众筹
            [but1 setTitle:@"我的众筹" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"个人中心众筹-"] forState:UIControlStateNormal];
        }else if (i == 1){//我的直播
            [but1 setTitle:@"我的直播" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"个人中心直播-(1)"] forState:UIControlStateNormal];
        }else if (i ==2){//我的投资
            [but1 setTitle:@"我的投资" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"我的投资"] forState:UIControlStateNormal];
        }else if (i == 3){//我的积分
            [but1 setTitle:@"我的积分" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"个人中心我的积分"] forState:UIControlStateNormal];
            
        }
        

    }
    //创建下面的数据，遍历3个按钮
    for (int i = 0; i <3; i++) {
        
        WyBut *but1 = [[WyBut alloc]init];
        but1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        but1.imageEdgeInsets = UIEdgeInsetsMake(0, WYmargin*1.5, 0, 0);
        but1.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin*3, 0, 0);
        [but1 setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        but1.titleLabel.font = Font18;
        [self.scrollView addSubview:but1];
        WyBut *but2 = [[WyBut alloc]init];
        but2.tag = i+5;
        [self.scrollView addSubview:but2];
        
        
        but1.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(butBottomView,i*65+WYmargin*2).rightEqualToView(self.scrollView).heightIs(64);
        
        but2.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(butBottomView,i*65+WYmargin*2).rightEqualToView(self.scrollView).heightIs(64);
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"616161"];
        [self.scrollView addSubview:bottomView];
        bottomView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(but2,0).rightEqualToView(self.scrollView).heightIs(1);
        
        [but2 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        but2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        but2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin*1.5);
        [but2 setImage:[UIImage imageNamed:@"下一页-拷贝-3"] forState:UIControlStateNormal];
        if (i == 0) {//银行卡信息
            UIView *topView = [[UIView alloc]init];
            topView.backgroundColor = [UIColor colorWithHexString:@"616161"];
            [self.scrollView addSubview:topView];
            topView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(butBottomView,WYmargin*2).rightEqualToView(self.scrollView).heightIs(1);
            [but1 setTitle:@"银行卡信息" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"个人中心银行卡"] forState:UIControlStateNormal];
        }else if (i == 1){//资金信息
            [but1 setTitle:@"资金信息" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"个人中心资金"] forState:UIControlStateNormal];
        }else if (i ==2){//我的认证
            [but1 setTitle:@"我的认证" forState:UIControlStateNormal];
            [but1 setImage:[UIImage imageNamed:@"个人中心认证"] forState:UIControlStateNormal];
            
               self.scrollView.contentSize = CGSizeMake(0, 700);
        }
        
        
    }
}
#pragma mark --------按钮点击
- (void)butClick:(WyBut *)but{
    
    if (but.tag == 0) {//头像点击
    [self.navigationController pushViewController:[[MeInformationViewController alloc]init] animated:YES];
    }else if (but.tag == 1){//我的众筹
        MeAllViewController * MeAllView = [[MeAllViewController alloc]init];
        MeAllView.title = @"我的众筹";
        [self.navigationController pushViewController:MeAllView animated:YES];
    }else if (but.tag == 3){//我的投资
        [self.navigationController pushViewController:[[MeInvestmentViewController alloc]init] animated:YES];
    }else if (but.tag == 4){//我的积分
        [self.navigationController pushViewController:[[MeIntegralViewController  alloc]init] animated:YES];
    }else if (but.tag == 5){//我的银行卡
        [self.navigationController pushViewController:[[MeBankCardViewController alloc]init] animated:YES];
    }else if (but.tag == 6){//我的资产
    [self.navigationController pushViewController:[[MePropertyViewController alloc]init] animated:YES];
    }else if (but.tag == 7){//我的认证
        //判断是否已经认证弹出认证页面
        [self.navigationController pushViewController:[[OpenCertificationViewController alloc]init] animated:YES];
    }

}
@end
