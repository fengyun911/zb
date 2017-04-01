//
//  MeBankCardViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/15.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "BankCell.h"
#import "MeBankCardViewController.h"
#import "AddBankViewController.h"
@interface MeBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tabView;
@end

@implementation MeBankCardViewController
- (UITableView *)tabView{
    if (!_tabView) {
        UITableView *tabView = [[UITableView alloc]init];
        tabView.contentInset = UIEdgeInsetsMake(0, 0,64, 0);
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.showsVerticalScrollIndicator = NO;
        tabView.delegate = self;
        tabView.dataSource = self;
        [self.view addSubview:tabView];
        tabView.frame = self.view.bounds;
        _tabView = tabView;
    }
    return _tabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    UIBarButtonItem *bar = [UIBarButtonItem itemWithTarget:self action:@selector(addBtnClick) image:@"添加" highImage:@"添加"];
    self.navigationItem.rightBarButtonItem = bar;
    self.view.backgroundColor = WYRGb(237, 238, 239);
    [self.tabView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark --------添加按钮点击的方法
- (void)addBtnClick{
    [self.navigationController pushViewController:[[AddBankViewController alloc]init] animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   BankCell *cell = [BankCell cellWithTableView:    tableView];
    return cell;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return ScreenWidth*0.618/2;
}

@end
