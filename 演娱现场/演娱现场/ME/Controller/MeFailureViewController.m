//
//  MeFailureViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/10.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "MeFailureViewController.h"
#import "MeInvestTableViewCell.h"
@interface MeFailureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tabView;

@end

@implementation MeFailureViewController
- (UITableView *)tabView{
    if (!_tabView) {
        UITableView *tabView = [[UITableView alloc]init];
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.contentInset = UIEdgeInsetsMake(0, 0, 64*2, 0);
        tabView.showsVerticalScrollIndicator = NO;
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.frame = self.view.bounds;
        tabView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        [self.view addSubview:tabView];
        _tabView = tabView;
    }
    return _tabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabView reloadData];
}
#pragma mark --------tabView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MeInvestTableViewCell *cell = [MeInvestTableViewCell cellWithTableView:tableView];
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
    
    
}


@end
