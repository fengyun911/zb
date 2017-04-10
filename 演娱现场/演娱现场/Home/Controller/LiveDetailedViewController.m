//
//  LiveDetailedViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "LiveDetailedViewController.h"
#import "LivetTopView.h"
#import "LiveTopCell.h"
#import "EventCell.h"
#import "RecommendCell.h"
#import "TopicCell.h"
#import "liveDetailModel.h"
#import "correlateListModel.h"
#import "commentListModel.h"
#import "LoginController.h"
#import "UIView+CLSetRect.h"
#import "CLPlayerView.h"
#import  "Masonry.h"
@interface LiveDetailedViewController ()<LivetTopViewDelegate,UITableViewDelegate,UITableViewDataSource,VideoDelegate>
{
    LivetTopView *_topNav;
   
}
@property(nonatomic,weak)UITableView *tabView;
//其它推荐
@property(nonatomic,strong)NSMutableArray *correlateList;
//互动话题
@property(nonatomic,strong)NSMutableArray *commentList;
@property(nonatomic,strong)liveDetailModel *liveDetailModel;
/**CLplayer*/
@property (nonatomic,weak) CLPlayerView *playerView;
/**记录Cell*/
@property (nonatomic,weak) LiveTopCell *cell;
@end

@implementation LiveDetailedViewController
- (NSMutableArray *)correlateList{
    if (!_correlateList) {
        NSMutableArray *correlateList = [NSMutableArray array];
        _correlateList =correlateList;
    }
    return _correlateList;
}
- (NSMutableArray *)commentList{
    if (!_commentList) {
        NSMutableArray *commentList = [NSMutableArray array];
        _commentList =commentList;
    }
    return _commentList;
}
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


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置顶部页面
    [self setupUi];
    //加载网络请求
    [self setupHttps];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //监听通知
    [self addNot];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark --------监听通知
- (void)addNot{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playLive:) name:@"playLive" object:nil];
    
    //其它推荐点击按钮
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(RecommendCellClick:) name:@"RecommendCellClick" object:nil];
    
    //我要众筹按钮点击
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(meCrowdfundingButClick:) name:@"meCrowdfundingButClick" object:nil];
  
}
//我要众筹
- (void)meCrowdfundingButClick:(NSNotification *)not{
    [self ShowComplitedHUDWith:@"我要众筹功能开发中..."];
    
}
#pragma mark -------通知的方法
//其它推荐
- (void)RecommendCellClick:(NSNotification *)not{
    NSInteger tag = [not.userInfo[@"key"] integerValue];
    correlateListModel *correlateModel = self.correlateList[tag];
    liveListModel *mode = [[liveListModel alloc]init];
    mode.type = correlateModel.type;
    mode.liveId  = correlateModel.busId;
    //创建控制器
    LiveDetailedViewController *live = [[LiveDetailedViewController alloc]init];
    live.model = mode;
    [self.navigationController pushViewController:live animated:YES];

}
- (void)playLive:(NSNotification *)not{
    
    liveDetailModel *mode = not.userInfo[@"key"];
    if (mode.liveUrl.length) {
      
    }
   
}
#pragma mark --------加载网络请求
- (void)setupHttps{
    [WYHttpTool getHttps:[NSString stringWithFormat:EDITORURL,self.model.liveId,self.model.type] param:nil Success:^(NSDictionary *dict, BOOL success) {
         WYLog(@"%@",dict);
        if ([dict[@"code"] isEqualToString:@"0"]) {//请求成功
       liveDetailModel *model=  [liveDetailModel objectWithKeyValues:dict[@"data"][@"liveDetail"]];
        self.liveDetailModel = model;
            
        self.correlateList =[correlateListModel objectArrayWithKeyValuesArray:dict[@"data"][@"correlateList"]];
        self.commentList = [commentListModel objectArrayWithKeyValuesArray:dict[@"data"][@"commentList"]];
            _topNav.textLabel.text = self.model.title;
            [self HideTheHUD];
            [self.tabView reloadData];
        }
        
    } fail:^(NSError *error) {
        [self HideTheHUD];
        
    }];
}

#pragma mark --------设置页面
- (void)setupUi{
    
    //设置顶部导航栏
    _topNav = [[LivetTopView alloc]init];
    _topNav.delegate = self;
    _topNav.frame = CGRectMake(0, 0, ScreenWidth, 64);
    [_topNav layoutSubviews];
    [self.tabView addSubview:_topNav];
    self.tabView.backgroundColor = [UIColor blackColor];
  }
#pragma mark --------tabView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==3) {
        return self.commentList.count;
    }else{
         return 1;
    }
     return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LiveTopCell *cell = [LiveTopCell cellWithTableView:tableView];
        cell.model = self.liveDetailModel;
        cell.videoDelegate = self;
        return cell;
    }else if (indexPath.section == 1){
        EventCell * cell = [EventCell cellWithTableView:tableView];
        cell.model = self.liveDetailModel;
            return cell;
    }else if (indexPath.section == 2){
        RecommendCell * cell = [RecommendCell cellWithTableView:tableView];
        [cell setupView:self.correlateList];
        return cell;
    }else{
        TopicCell * cell = [TopicCell cellWithTableView:tableView];
        cell.model  = self.commentList[indexPath.row];
        return cell;
    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return ScreenWidth*0.618 + 44;
    }else if(indexPath.section == 1){
        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
    }else if(indexPath.section == 2){
        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
    }else{
         return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
    }
    
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//}
/////**
//// *  header标题
//// */
////- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
////{
////
////    return @"最新评论";
////}
//
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WyBut *header = [[WyBut alloc] init];
    header.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    header.imageEdgeInsets = UIEdgeInsetsMake(0, WYmargin, 0, 0);
    header.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin*2, 0, 0);
    header.backgroundColor = HOMEPARTITION;

    header.titleLabel.font = Font16;
    
    UIView *topView = [[UIView alloc]init];
    [header addSubview:topView];
    topView.backgroundColor = HOMEWIRE;
    topView.sd_layout.leftEqualToView(header).topEqualToView(header).rightEqualToView(header).heightIs(1);
    
    
    UIView *bottom = [[UIView alloc]init];
    [header addSubview:bottom];
    bottom.backgroundColor = HOMEWIRE;
    bottom.sd_layout.leftEqualToView(header).rightEqualToView(header).bottomEqualToView(header).heightIs(1);
    
    if (section == 0) {
        return nil;
    }else if(section == 1) {
       
        [header setTitle:@"活动详情" forState:UIControlStateNormal];
        [header setImage:[UIImage imageNamed:@"资讯"] forState:UIControlStateNormal];
        return header;
        
    }else if (section == 2){
        [header setTitle:@"其他推荐" forState:UIControlStateNormal];
        [header setImage:[UIImage imageNamed:@"直播-其他推荐"] forState:UIControlStateNormal];
        return header;
    }else if (section == 3){
        [header setTitle:@"互动话题" forState:UIControlStateNormal];
        [header setImage:[UIImage imageNamed:@"直播-互动话题"] forState:UIControlStateNormal];
        return header;
    }else{
        return nil;
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return 44;
    }
    
}

#pragma mark --------顶部导航条代理方法
-(void)LivetTopView:(LivetTopView *)LivetTopView returnButClick:(UIButton *)but{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)LivetTopView:(LivetTopView *)LivetTopView bulletScreenButClick:(UIButton *)but{
    WYLog(@"弹幕");
    [self ShowComplitedHUDWith:@"弹幕功能开发中..."];
}
-(void)LivetTopView:(LivetTopView *)LivetTopView shareButClick:(UIButton *)but{
     [self ShowComplitedHUDWith:@"分享功能开发中..."];
  
}
#pragma mark - 点击播放代理
- (void)PlayVideoWithCell:(LiveTopCell  *)cell;
{
    
    
    //记录被点击的Cell
    _cell = cell;
    
 //判断是否登陆，没有登录到登陆页面
    NSDictionary * userinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    if (userinfo == nil) {
        //弹出登陆页面
        LoginController * login = [[LoginController alloc]init];
        [self.navigationController pushViewController:login  animated:YES];
    }else{//用户已经登陆
        //发送网络请求判断是否已经购买
//        NSDictionary *dict = 
//    [WYHttpTool postHttps:WHETHERWATCH param:<#(NSDictionary *)#> Success:<#^(NSDictionary *dict, BOOL success)success#> fail:<#^(NSError *error)fail#>]
        
        
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
        
        CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, cell.CLwidth, cell.CLheight)];
        
        _playerView = playerView;
        [cell.contentView addSubview:_playerView];
        
        
        //根据旋转自动支持全屏，默认支持
        //        _playerView.autoFullScreen = NO;
        //重复播放，默认不播放
        //    _playerView.repeatPlay     = YES;
        //如果播放器所在页面支持横屏，需要设置为Yes，不支持不需要设置(默认不支持)
        //        _playerView.isLandscape    = YES;
        //设置等比例全屏拉伸，多余部分会被剪切
        //    _playerView.fillMode = ResizeAspectFill;
        
        //视频地址
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _playerView.url = [NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
            //播放
            [_playerView playVideo];
            
        });
        
        //返回按钮点击事件回调
        [_playerView backButton:^(UIButton *button) {
            //销毁播放器
            //[_playerView destroyPlayer];
            //_playerView = nil;
        }];
        
        //播放完成回调
        [_playerView endPlay:^{
            
            //销毁播放器
            [_playerView destroyPlayer];
            _playerView = nil;
            NSLog(@"播放完成");
        }];

    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    //销毁播放器
    [_playerView destroyPlayer];
    _playerView = nil;
}
@end
