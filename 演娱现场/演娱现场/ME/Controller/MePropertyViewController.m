//
//  MePropertyViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/14.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "MePropertyViewController.h"
#import "MePayViewController.h"
@interface MePropertyViewController ()
{
    UIImageView *_topImageView;
}
@end

@implementation MePropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f4f9"];
   //设置页面
    [self setupUi];
}
#pragma mark --------设置页面UI
- (void)setupUi{
    //设置顶部背景图片
    _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"形状-2"]];
    _topImageView.userInteractionEnabled = YES;
    _topImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.618);
    [self.view addSubview:_topImageView];
    
    //设置返回的按钮
   WyBut *leftBut = [[WyBut alloc]init];
    [leftBut setImage:[UIImage imageNamed:@"返回-(1)"] forState:UIControlStateNormal];
    //添加按钮监听方法
    [leftBut addTarget:self action:@selector(topLeftButClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topImageView addSubview:leftBut];
    //左边按钮的位置
    leftBut.sd_layout.leftSpaceToView(_topImageView,WYmargin).widthIs(40).heightIs(40).topSpaceToView(_topImageView,WYmargin*2);
    //设置我的标题
    UILabel *title = [[UILabel alloc]init];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = Font20;
    title.textColor = [UIColor colorWithHexString:@"ffffff"];
    title.text = @"我的资产";
    [_topImageView addSubview:title];
    title.sd_layout.leftSpaceToView(_topImageView,WYmargin*10).rightSpaceToView(_topImageView,WYmargin*10).heightIs(40).topSpaceToView(_topImageView,WYmargin*2);
    //设置总资产(元)
    UILabel *text = [[UILabel alloc]init];
    text.textAlignment = NSTextAlignmentCenter;
    text.font = Font18;
    text.textColor = [UIColor colorWithHexString:@"ffffff"];
    text.text = @"总资产(元)";
    [_topImageView addSubview:text];
    text.sd_layout.leftSpaceToView(_topImageView,WYmargin*10).rightSpaceToView(_topImageView,WYmargin*10).heightIs(18).topSpaceToView(title,30);
    //总金额(元)
    UILabel *amount = [[UILabel alloc]init];
    amount.textAlignment = NSTextAlignmentCenter;
    amount.font = Font30;
    amount.textColor = [UIColor colorWithHexString:@"ffffff"];
    amount.text = @"825123";
    [_topImageView addSubview:amount];
    amount.sd_layout.leftSpaceToView(_topImageView,WYmargin*10).rightSpaceToView(_topImageView,WYmargin*10).heightIs(30).topSpaceToView(text,20);
    //创建三个按钮

    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:bottomView];
     CGFloat butWH = ScreenWidth/3;
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i<5; i++) {
        WyBut *bottomBut = [[WyBut alloc]init];
        bottomBut.tag = i;
        [bottomBut addTarget:self action:@selector(bottomButClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bottomBut];
        [bottomBut setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        bottomBut.sd_layout.autoHeightRatio(1);
        bottomBut.titleLabel.font = Font20;
       [temp addObject:bottomBut];
        WyBut *but = [[WyBut alloc]init];
        but.frame = CGRectMake(0, 0, butWH, butWH);
        switch (i) {
            case 0:{
                [bottomBut setImage:[UIImage imageNamed:@"我的资产-提现"] forState:UIControlStateNormal];
                [bottomBut setTitle:@"提现" forState:UIControlStateNormal];
                
                [but setImage:[UIImage imageNamed:@"我的资产-提现"] forState:UIControlStateNormal];
                [but setTitle:@"提现" forState:UIControlStateNormal];
            }
                break;
            case 1:{
                [bottomBut setImage:[UIImage imageNamed:@"我的资产-充值-(1)"] forState:UIControlStateNormal];
                [bottomBut setTitle:@"充值" forState:UIControlStateNormal];
                [but setImage:[UIImage imageNamed:@"我的资产-充值-(1)"] forState:UIControlStateNormal];
                [but setTitle:@"充值" forState:UIControlStateNormal];
            }
                break;
            case 2:{
                [bottomBut setImage:[UIImage imageNamed:@"我的资产收益明细"] forState:UIControlStateNormal];
                [bottomBut setTitle:@"收益明细" forState:UIControlStateNormal];
                
                [but setImage:[UIImage imageNamed:@"我的资产收益明细"] forState:UIControlStateNormal];
                [but setTitle:@"收益明细" forState:UIControlStateNormal];
            }
                break;
            case 3:{
                [bottomBut setImage:[UIImage imageNamed:@"我的资产-交易记录"] forState:UIControlStateNormal];
                [bottomBut setTitle:@"交易记录" forState:UIControlStateNormal];
                [but setImage:[UIImage imageNamed:@"我的资产-交易记录"] forState:UIControlStateNormal];
                [but setTitle:@"交易记录" forState:UIControlStateNormal];
            }
                break;
            case 4:{
                [bottomBut setImage:[UIImage imageNamed:@"我的资产银行卡"] forState:UIControlStateNormal];
                [bottomBut setTitle:@"银行卡" forState:UIControlStateNormal];
                
                [but setImage:[UIImage imageNamed:@"我的资产银行卡"] forState:UIControlStateNormal];
                [but setTitle:@"银行卡" forState:UIControlStateNormal];
            }
                break;
            default:
                break;
        }
       //使图片和文字水平居中显示
        [bottomBut setTitleEdgeInsets:UIEdgeInsetsMake(but.imageView.frame.size.height+WYmargin ,-but.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        
        [bottomBut setImageEdgeInsets:UIEdgeInsetsMake(-but.titleLabel.bounds.size.height - WYmargin, 0.0,0.0, -but.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
       
    }
     [bottomView setupAutoMarginFlowItems:[temp copy] withPerRowItemsCount:3 itemWidth:butWH verticalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    
    bottomView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(_topImageView, 0);
    
    //创建3个线
    for (int i = 0; i<3; i++) {
        UIView *view=[[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexString:@"d5d5d5"];
        [self.view addSubview:view];
        if (i==0) {
            view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(_topImageView,butWH).heightIs(1);
        }else if (i ==1){
            view.sd_layout.leftSpaceToView(self.view,butWH).topSpaceToView(_topImageView,0).widthIs(1).heightIs(butWH*2);
        }else{
        
            view.sd_layout.leftSpaceToView(self.view,butWH*2).topSpaceToView(_topImageView,0).widthIs(1).heightIs(butWH*2);
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
#pragma mark --------左边顶部按钮点击
- (void)topLeftButClick:(WyBut *)but{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --------九宫格按钮点击
- (void)bottomButClick:(WyBut*)but{
    switch (but.tag) {
        case 0:{//提现
            
        }break;
        case 1:{//充值
            [self.navigationController pushViewController:[[MePayViewController alloc]init] animated:YES];
        }break;
        case 2:{//收益明细
            
        }break;
        case 3:{//交易记录
            
        }break;
        case 4:{//银行卡
            
        }break;
        default:
            break;
    }

}
@end
