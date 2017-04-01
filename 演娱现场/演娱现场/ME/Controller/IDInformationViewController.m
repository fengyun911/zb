//
//  IDInformationViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/20.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "IDInformationViewController.h"

@interface IDInformationViewController ()
/**滚动的scrollView*/
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation IDInformationViewController
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        //隐藏指示条
        scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView = scrollView;
        scrollView.frame = self.view.bounds;
        scrollView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        [self.view addSubview:scrollView];
    }
    return  _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置页面
    [self setupUi];
}
#pragma mark --------设置页面
-(void)setupUi{
    //设置顶部的view
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, WYmargin, ScreenWidth, ScreenWidth*0.618);
    topView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:topView];
    
    //身份证上传
    UILabel *information = [[UILabel alloc]init];
    information.font = Font16;
    information.text = @"身份证上传";
    information.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:information];
    information.sd_layout.leftSpaceToView(topView,WYmargin).topEqualToView(topView).rightEqualToView(topView).heightRatioToView(topView,0.25);
    //设置分割线
    UIView *informationWire = [[UIView alloc]init];
    informationWire.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [topView addSubview:informationWire];
    informationWire.sd_layout.leftSpaceToView(topView,WYmargin).topSpaceToView(information,0).rightSpaceToView(topView,WYmargin).heightIs(1);
    //证件图片
    UILabel *credentials = [[UILabel alloc]init];
    credentials.font = Font16;
    credentials.text = @"证件图片";
    credentials.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:credentials];
    credentials.sd_layout.leftSpaceToView(topView,WYmargin).topSpaceToView(informationWire,0).widthRatioToView(topView,0.25).heightRatioToView(topView,0.25);
    
    //左面的证件图片
    WyBut *leftCredentialsBut = [[WyBut alloc]init];
    [leftCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [topView addSubview:leftCredentialsBut];
    leftCredentialsBut.sd_layout.leftSpaceToView(credentials,0).topSpaceToView(information,WYmargin*2+WYmargin2).widthRatioToView(topView,0.3).heightEqualToWidth();
    
    //右面的证件图片
    WyBut *rightCredentialsBut = [[WyBut alloc]init];
    [rightCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [topView addSubview:rightCredentialsBut];
    rightCredentialsBut.sd_layout.leftSpaceToView(leftCredentialsBut,WYmargin2).topSpaceToView(information,WYmargin*2+WYmargin2).widthRatioToView(topView,0.3).heightEqualToWidth();
    
    //设置底部
    UIView *bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame)+WYmargin2+WYmargin, ScreenWidth, ScreenWidth*0.618);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:bottomView];
    
    //银行卡上传
    UILabel *BankCard = [[UILabel alloc]init];
    BankCard.font = Font16;
    BankCard.text = @"银行卡上传";
    BankCard.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:BankCard];
    BankCard.sd_layout.leftSpaceToView(bottomView,WYmargin).topEqualToView(bottomView).rightEqualToView(bottomView).heightRatioToView(topView,0.25);
    //设置分割线
    UIView *bottomViewInformationWire = [[UIView alloc]init];
    bottomViewInformationWire.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [bottomView addSubview:bottomViewInformationWire];
    bottomViewInformationWire.sd_layout.leftSpaceToView(bottomView,WYmargin).topSpaceToView(BankCard,0).rightSpaceToView(bottomView,WYmargin).heightIs(1);
    //证件图片
    UILabel * bottomCredentials = [[UILabel alloc]init];
    bottomCredentials.font = Font16;
    bottomCredentials.text = @"证件图片";
    bottomCredentials.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:bottomCredentials];
    bottomCredentials.sd_layout.leftSpaceToView(bottomView,WYmargin).topSpaceToView(bottomViewInformationWire,0).widthRatioToView(bottomView,0.25).heightRatioToView(bottomView,0.25);
    
    //左面的证件图片
    WyBut * bottomLeftCredentialsBut = [[WyBut alloc]init];
    [bottomLeftCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [bottomView addSubview:bottomLeftCredentialsBut];
    bottomLeftCredentialsBut.sd_layout.leftSpaceToView(bottomCredentials,0).topSpaceToView(bottomViewInformationWire,WYmargin*2+WYmargin2).widthRatioToView(bottomView,0.3).heightEqualToWidth();
    
    //右面的证件图片
    WyBut * bottomRightCredentialsBut = [[WyBut alloc]init];
    [bottomRightCredentialsBut setBackgroundImage:[UIImage imageNamed:@"点此上传"] forState:UIControlStateNormal];
    [bottomView addSubview:bottomRightCredentialsBut];
    bottomRightCredentialsBut.sd_layout.leftSpaceToView( bottomLeftCredentialsBut,WYmargin2).topSpaceToView(bottomViewInformationWire,WYmargin*2+WYmargin2).widthRatioToView(bottomView,0.3).heightEqualToWidth();
    //顶部的显示文字
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.font = Font12;
    bottomLabel.numberOfLines = 2;
    bottomLabel.textColor = WYRGb(0, 113, 236);
    
    bottomLabel.frame = CGRectMake(WYmargin, CGRectGetMaxY(bottomView.frame), ScreenWidth- WYmargin*2, 30);
    bottomLabel.text = @"*请上传xx(130*****888)对应的身份证以及银行卡正反面照片";
   
    
    [self.scrollView addSubview:bottomLabel];
    
    WyBut *bottomeBut = [[WyBut alloc]init];
    
    [self.scrollView addSubview:bottomeBut];
    bottomeBut.frame = CGRectMake(WYmargin*2, CGRectGetMaxY(bottomLabel.frame)+WYmargin*2, ScreenWidth-WYmargin*4, 44);
    bottomeBut.titleLabel.font = Font18;
    [bottomeBut setTitle:@"上传" forState:UIControlStateNormal];
    [bottomeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomeBut.backgroundColor = WYRGb(0, 113, 236);
    bottomeBut.layer.cornerRadius = 5;
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(bottomeBut.frame)+WYmargin*2+64);
}
@end
