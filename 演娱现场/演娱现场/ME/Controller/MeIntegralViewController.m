//
//  MeIntegralViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/14.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "MeIntegralViewController.h"
#import "IntegralCell.h"
@interface MeIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
{    

    UIImageView *_topImageView;
}
@property(nonatomic,weak)UITableView *tabView;
@end

@implementation MeIntegralViewController
- (UITableView *)tabView{
    if (!_tabView) {
        UITableView *tabView = [[UITableView alloc]init];
        tabView.contentInset = UIEdgeInsetsMake(-20, 0,0, 0);
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.showsVerticalScrollIndicator = NO;
        tabView.delegate = self;
        tabView.dataSource = self;
        [self.view addSubview:tabView];
        tabView.frame = CGRectMake(0, ScreenWidth*0.618+WYmargin, ScreenWidth, self.view.height - ScreenWidth*0.618-WYmargin);
        _tabView = tabView;
    }
    return _tabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabView reloadData];
    self.view.backgroundColor = WYRGb(240, 241, 241);
    [self setupUi];

}
#pragma mark --------设置UI
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
    title.text = @"我的积分";
    [_topImageView addSubview:title];
    title.sd_layout.leftSpaceToView(_topImageView,WYmargin*10).rightSpaceToView(_topImageView,WYmargin*10).heightIs(40).topSpaceToView(_topImageView,WYmargin*2);
    //设置总资产(元)
    UILabel *text = [[UILabel alloc]init];
    text.textAlignment = NSTextAlignmentCenter;
    text.font = Font18;
    text.textColor = [UIColor colorWithHexString:@"ffffff"];
    text.text = @"总积分 >";
    [_topImageView addSubview:text];
    text.sd_layout.leftSpaceToView(_topImageView,WYmargin*10).rightSpaceToView(_topImageView,WYmargin*10).heightRatioToView(_topImageView,0.2).topSpaceToView(title,0);
    //总金额(元)
    UILabel *amount = [[UILabel alloc]init];
    amount.textAlignment = NSTextAlignmentCenter;
    amount.font = Font30;
    amount.textColor = [UIColor colorWithHexString:@"ffffff"];
    amount.text = @"825";
    [_topImageView addSubview:amount];
    amount.sd_layout.leftSpaceToView(_topImageView,WYmargin*10).rightSpaceToView(_topImageView,WYmargin*10).heightRatioToView(_topImageView,0.2).topSpaceToView(text,0);
    
    //设置底部view
    UIView *bottomView = [[UIView alloc]init];
    [_topImageView addSubview:bottomView];
    bottomView.sd_layout.leftEqualToView(_topImageView).rightEqualToView(_topImageView).heightIs(60).bottomEqualToView(_topImageView);
    bottomView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    //创建两个按钮
    WyBut *bottomleftBut = [[WyBut alloc]init];
    [bottomView addSubview:bottomleftBut];
    [bottomleftBut setTitle:@"积分明细" forState:UIControlStateNormal];
     [bottomleftBut setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [bottomleftBut setImage:[UIImage imageNamed:@"积分明细-1"] forState:UIControlStateNormal];
    bottomleftBut.sd_layout.leftSpaceToView(bottomView,WYmargin).topEqualToView(bottomView).bottomEqualToView(bottomView).widthIs(ScreenWidth/2-WYmargin);
    bottomleftBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    bottomleftBut.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin, 0, 0);
    [bottomleftBut addTarget:self action:@selector(bottomleftButClick:) forControlEvents:UIControlEventTouchUpInside];
    //中间分隔的view
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = WYRGb(150, 100, 144);
    [bottomView addSubview:view];
    view.sd_layout.leftSpaceToView(bottomleftBut,0).widthIs(1).topSpaceToView(bottomView,WYmargin+WYmargin2).bottomSpaceToView(bottomView,WYmargin+WYmargin2);
    
    WyBut *bottomRightBut = [[WyBut alloc]init];
    [bottomView addSubview:bottomRightBut];
    [bottomRightBut setTitle:@"积分兑换 >>" forState:UIControlStateNormal];
    [bottomRightBut setTitleColor:WYRGb(150, 100, 144) forState:UIControlStateNormal];
    bottomRightBut.sd_layout.rightSpaceToView(bottomView,WYmargin2).topEqualToView(bottomView).bottomEqualToView(bottomView).widthIs(ScreenWidth/2-WYmargin);
    bottomRightBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    bottomRightBut.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin);
    [bottomRightBut addTarget:self action:@selector(bottomRightButClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
#pragma mark --------左边顶部按钮点击
- (void)topLeftButClick:(WyBut *)but{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--------积分明细按钮点击
- (void)bottomleftButClick:(WyBut *)but{

}
#pragma mark--------积分兑换按钮点击
- (void)bottomRightButClick:(WyBut *)but{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
         IntegralCell *cell = [IntegralCell cellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 64;
    
}

@end
