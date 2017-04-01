//
//  CrowdfundingListViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/31.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "TopUIScrollViewCell.h"
#import "CrowdfundingListViewController.h"
#import "TopNavView.h"
#import "LiveDetailedViewController.h"
#import "bannerListModel.h"
#import "CrowdfundingListCell.h"
@interface CrowdfundingListViewController ()<TopNavViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    TopNavView *_topNav;
}
//遮盖
@property(nonatomic,weak)WyBut *cover;
@property(nonatomic,weak)UITableView *tabView;
@end

@implementation CrowdfundingListViewController
- (UITableView *)tabView{
    if (!_tabView) {
        UITableView *tabView = [[UITableView alloc]init];
        tabView.contentInset = UIEdgeInsetsMake(-20, 0,0, 0);
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.showsVerticalScrollIndicator = NO;
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.frame = self.view.bounds;
        
        [self.view addSubview:tabView];
        _tabView = tabView;
    }
    return _tabView;
}

-(WyBut *)cover{
    if (!_cover) {
        WyBut *cover = [[WyBut alloc]init];
        [cover addTarget:self action:@selector(coverButClick) forControlEvents:UIControlEventTouchUpInside];
        _cover =cover;
        cover.backgroundColor = [UIColor grayColor];
        cover.alpha = 0.5 ;
        cover.frame = CGRectMake(0, 64, ScreenWidth, self.tabView.height - 64);
        [self.tabView addSubview:cover];
        
    }
    return _cover;
}
- (NSMutableArray *)bannerListArray{
    if (!_bannerListArray) {
        NSMutableArray *bannerListArray = [NSMutableArray array];
        _bannerListArray =bannerListArray;
    }
    return _bannerListArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置顶部页面
    [self setupUi];
    //监听通知
    [self addNot];
    
    [self.tabView reloadData];
}
#pragma mark --------监听通知
- (void)addNot{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cycleScrollView:) name:@"cycleScrollView"object:nil];
    
    
}
#pragma mark --------设置页面
- (void)setupUi{
    //设置顶部导航栏
    _topNav = [[TopNavView alloc]init];
    [_topNav setupLeftBut:@"返回-(1)"];
    _topNav.delegate = self;
    _topNav.searchBar.delegate = self;
    _topNav.frame = CGRectMake(0, 0, ScreenWidth, 64);
    [_topNav layoutSubviews];
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    [window addSubview:_topNav];
//    self.tabView.hidden = YES;
//    self.tabView.backgroundColor = [UIColor blackColor];
}
#pragma mark --------搜索框的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length == 0) {
        [self ShowComplitedHUDWith:@"请输入查询条件"];
    }else{//发送网络请求
        //发送条件搜索的网络请求方法
    }
    
    return YES;
}
#pragma mark --------左侧滑动点击的代理
- (void)TopNavView:(TopNavView *)TopNavView didLeftButClick:(UIButton *)but{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --------textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.cover.hidden = NO;
}
#pragma mark --------遮盖点击
- (void)coverButClick{
    self.cover.hidden = YES;
    _topNav.searchBar.text = nil;
    [_topNav.searchBar endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _topNav.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _topNav.hidden = YES;
}
- (void)dealloc{
    [_topNav removeFromSuperview];
    _topNav = nil;
}
#pragma mark --------tabView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        TopUIScrollViewCell *cell = [TopUIScrollViewCell cellWithTableView:tableView];
        [cell setupView:self.bannerListArray];
           return cell;
    }else{
        CrowdfundingListCell * cell = [CrowdfundingListCell cellWithTableView:tableView];
        return cell;
    }

    
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth *0.618;
//    if (indexPath.section == 0) {
//        return ScreenWidth *0.618;
//    }else if(indexPath.section == 1){
//        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
//    }else if(indexPath.section == 2){
//        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
//    }else if(indexPath.section == 3){
//        return ScreenWidth *0.618+45;
//    }else{
//        //           return ScreenWidth *0.618;
//        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
//    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else if(section == 1) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = HOMEWIRE;
        return header;
        
    }else{
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = HOMEPARTITION;
        
        UIView *topView = [[UIView alloc]init];
        [header addSubview:topView];
        topView.backgroundColor = HOMEWIRE;
        topView.sd_layout.leftEqualToView(header).topEqualToView(header).rightEqualToView(header).heightIs(1);
        
        UIView *bottom = [[UIView alloc]init];
        [header addSubview:bottom];
        bottom.backgroundColor = HOMEWIRE;
        bottom.sd_layout.leftEqualToView(header).rightEqualToView(header).bottomEqualToView(header).heightIs(1);
        return header;
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else if (section == 1){
        return 1;
    }else{
        return 6.5;
    }
    
}
- (void)cycleScrollView:(NSNotification *)not{
    //获取顶部数据信息判断是直播还是众筹
    NSInteger tag = [not.userInfo[@"key"] integerValue];
    bannerListModel *bannerModel = self.bannerListArray[tag];
    if ([bannerModel.type isEqualToString:@"1"]) {//类型是直播
        LiveDetailedViewController *live = [[LiveDetailedViewController alloc]init];
        liveListModel *mode = [[liveListModel alloc]init];
        mode.type = bannerModel.type;
        mode.liveId = bannerModel.relationId;
        live.model = mode;
        [self.navigationController pushViewController:live animated:YES];
    }
    
    
}

@end
