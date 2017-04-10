//
//  HomeViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/22.
//  Copyright © 2017年 yyxc. All rights reserved.
#import "CrowdfundingListViewController.h"
#import "HomeViewController.h"
#import "TopNavView.h"
#import "TopUIScrollViewCell.h"
#import "CrowdfundingCell.h"
#import "NewsCell.h"
#import "CommentCell.h"
#import "CommentOneCell.h"
#import "LiveDetailedViewController.h"
#import "CommentThreeCell.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
#import "PersonCenterViewController.h"
#import "CrowdfundingDetailedViewController.h"
#import "MeInvestmentViewController.h"
#import "perToppicListModel.h"
#import "bannerListModel.h"
#import "liveListModel.h"
#import "crowdListModel.h"
#import "LoginController.h"
#import "CommentTwoCell.h"
#import "ReleaseTopicViewController.h"
@interface HomeViewController ()<TopNavViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HomeMenuViewDelegate>
{
    TopNavView *_topNav;
    //记录最后一个坐标
    UIButton *_butY;
    
    LeftMenuViewDemo *_me;
}
@property(nonatomic,weak)UITableView *tabView;
@property (nonatomic ,strong)MenuView   *menu;
//众筹的数据
@property(nonatomic,strong)NSMutableArray *crowdListArray;
//轮播图的数据
@property(nonatomic,strong)NSMutableArray *bannerListArray;
//直播的数据
@property(nonatomic,strong)NSMutableArray *liveListArray;
//话题的数据
@property(nonatomic,strong)NSMutableArray *perToppicListArray;
//遮盖
@property(nonatomic,weak)UIScrollView *cover;

@end

@implementation HomeViewController
-(UIScrollView *)cover{
    if (!_cover) {
        UIScrollView *cover = [[UIScrollView alloc]init];

        _cover =cover;
        cover.backgroundColor = [UIColor whiteColor];
        cover.frame = self.view.bounds;
        cover.y = 64;
        UIWindow *windows = [UIApplication sharedApplication].windows.lastObject;
        [windows addSubview:cover];
        [self addAGesutreRecognizerForYourView];
        [self setreMenUI];
        
        
    }
    return _cover;
}
- (NSMutableArray *)crowdListArray{
    if (!_crowdListArray) {
        NSMutableArray *crowdListArray = [NSMutableArray array];
        _crowdListArray =crowdListArray;
    }
    return _crowdListArray;
}
- (NSMutableArray *)bannerListArray{
    if (!_bannerListArray) {
        NSMutableArray *bannerListArray = [NSMutableArray array];
        _bannerListArray =bannerListArray;
    }
    return _bannerListArray;
}
- (NSMutableArray *)liveListArray{
    if (!_liveListArray) {
        NSMutableArray *liveListArray = [NSMutableArray array];
        _liveListArray =liveListArray;
    }
    return _liveListArray;
}
- (NSMutableArray *)perToppicListArray{
    if (!_perToppicListArray) {
        NSMutableArray *perToppicListArray = [NSMutableArray array];
        _perToppicListArray =perToppicListArray;
    }
    return _perToppicListArray;
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
//获取侧边栏
- (void)sideList{
    [WYHttpTool getHttps:SIDE_LIST param:nil Success:^(NSDictionary *dict, BOOL success) {
        if ([dict[@"code"]isEqualToString:@"0"]) {
            _me = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.8, [[UIScreen mainScreen] bounds].size.height)];
            WYLog(@"%@",dict);
            _me.leftCrowdList = dict[@"data"][@"crowdList"];
            _me.leftLiveList = dict[@"data"][@"liveList"];
            _me.customDelegate = self;
            [_me makeData];
            self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:_me isShowCoverView:YES];
        }
    } fail:^(NSError *error) {
      
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _topNav.hidden = NO;
    //监听通知
    [self addNot];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    _topNav.hidden = YES;
}
#pragma mark --------监听通知
- (void)addNot{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cycleScrollView:) name:@"cycleScrollView"object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(crowdfundingCellButClick:) name:@"CrowdfundingCellButClick" object:nil];
    //直播图标点击
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NewsCell:) name:@"NewsCell" object:nil];
    
    
}
#pragma mark --------获取通知的方法
//直播页面点击
- (void)NewsCell:(NSNotification *)not{
    
    NSInteger tag = [not.userInfo[@"tag"] integerValue];
    liveListModel *model = self.liveListArray[tag];
    if ([model.type isEqualToString:@"1"]) {//直播
        LiveDetailedViewController *live = [[LiveDetailedViewController alloc]init];
        live.model = model;
        [self.navigationController pushViewController:live animated:YES];
    }
    
    
}
//众筹详情页面点击
- (void)crowdfundingCellButClick:(NSNotification *)not{
    CrowdfundingDetailedViewController * crowdfundingDetailedViewController = [[CrowdfundingDetailedViewController alloc]init];
    [self.navigationController pushViewController:crowdfundingDetailedViewController animated:YES];
    WYLog(@"%@",not.userInfo);

}
- (void)cycleScrollView:(NSNotification *)not{
  
        //获取顶部数据信息判断是直播还是众筹
    NSInteger tag = [not.userInfo[@"key"] integerValue];
   bannerListModel *bannerModel = self.bannerListArray[tag];
      WYLog(@"%@=%@",not.userInfo[@"key"],bannerModel.type);
    if ([bannerModel.type isEqualToString:@"1"]) {//类型是直播
        LiveDetailedViewController *live = [[LiveDetailedViewController alloc]init];
        liveListModel *mode = [[liveListModel alloc]init];
        mode.type = bannerModel.type;
        mode.liveId = bannerModel.relationId;
        live.model = mode;
        [self.navigationController pushViewController:live animated:YES];
    }
    

}
#pragma mark --------设置页面
- (void)setupUi{
    //设置顶部导航栏
    _topNav = [[TopNavView alloc]init];
    _topNav.delegate = self;
    _topNav.searchBar.delegate = self;
    _topNav.frame = CGRectMake(0, 0, ScreenWidth, 64);
    [_topNav layoutSubviews];
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    
    [window addSubview:_topNav];
    self.tabView.hidden = YES;
    self.tabView.backgroundColor = [UIColor blackColor];
}
#pragma mark --------加载网络请求
- (void)setupHttps{
    [self ShowMBProgressHUD];
    [WYHttpTool postHttps:[NSString stringWithFormat:HOMEURL,1] param:nil Success:^(NSDictionary *dict, BOOL success) {
          [self HideTheHUD];
        if ([dict[@"code"] isEqualToString:@"0"]) {//请求成功
            self.tabView.hidden = NO;
            //获取侧边栏数据
            [self sideList];
            
            self.perToppicListArray = [perToppicListModel objectArrayWithKeyValuesArray:dict[@"data"][@"perToppicList"]];
            
            self.bannerListArray =[bannerListModel objectArrayWithKeyValuesArray:dict[@"data"][@"bannerList"]];
            self.liveListArray = [liveListModel objectArrayWithKeyValuesArray:dict[@"data"][@"liveList"]];
            
            self.crowdListArray = [crowdListModel objectArrayWithKeyValuesArray:dict[@"data"][@"crowdList"]];
        
            
            [self.tabView reloadData];
            
        }else{
        [self ShowComplitedHUDWith:dict[@"msg"]];
        }
       
    } fail:^(NSError *error) {
        [self HideTheHUD];
        [self ShowComplitedHUDWith:@"网络加载失败..."];
    }];
}
#pragma mark --------顶部自定义view的代理方法
- (void)TopNavView:(TopNavView *)TopNavView didLeftButClick:(UIButton *)but{
    [_topNav setupRightBut:@"北京"];
    [_topNav.searchBar endEditing:YES];
    [self.cover removeFromSuperview];
    [self.menu show];

}
- (void)TopNavView:(TopNavView *)TopNavView didRightButClick:(UIButton *)but{
    if ([but.currentTitle isEqualToString:@"取消"]) {
        [_topNav setupRightBut:@"北京"];
        [_topNav.searchBar endEditing:YES];
        [self.cover removeFromSuperview];
        
    }
    WYLog(@"%@",but.currentTitle);
}
#pragma mark --------tabView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
         return self.perToppicListArray.count;
    }else{
        return 1;
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        TopUIScrollViewCell *cell = [TopUIScrollViewCell cellWithTableView:tableView];
          [cell setupView:self.bannerListArray];
       
        return cell;
    }else if (indexPath.section == 1){
        CrowdfundingCell *cell = [CrowdfundingCell cellWithTableView:tableView];
        [cell setupView:self.crowdListArray];
        return cell;
    }else if(indexPath.section == 2){
        NewsCell *cell = [NewsCell cellWithTableView:tableView];
        [cell setupView:self.liveListArray];
        return cell;

        return cell;
    }else if(indexPath.section == 3){
       CommentCell *cell = [CommentCell cellWithTableView:tableView];
       [cell setupView];
       return cell;
   }else{
       perToppicListModel *model  =self.perToppicListArray[indexPath.row];
//       if ([model.modeType isEqualToString:@"1"]) {
//            CommentThreeCell *cell = [CommentThreeCell cellWithTableView:tableView];
//           cell.model = model;
//           return cell;
//       }else if([model.modeType isEqualToString:@"2"]){
//           CommentOneCell *cell = [CommentOneCell cellWithTableView:tableView];
//               [cell setupView];
//           return cell;
//       }else{
//           CommentTwoCell *cell = [CommentTwoCell cellWithTableView:tableView];
//           [cell setupView];
//           return cell;
//       }
                   CommentThreeCell *cell = [CommentThreeCell cellWithTableView:tableView];
                  cell.model = model;
                  return cell;
       
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return ScreenWidth *0.618;
    }else if(indexPath.section == 1){
        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
    }else if(indexPath.section == 2){
        return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
    }else if(indexPath.section == 3){
        return ScreenWidth *0.618+45;
    }else{
//           return ScreenWidth *0.618;
      return [self.tabView cellHeightForIndexPath:indexPath cellContentViewWidth:ScreenWidth tableView:_tabView];
    }
  
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        ReleaseTopicViewController *release = [[ReleaseTopicViewController alloc]init];
        [self.navigationController pushViewController:release animated:YES];
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 ||section==4 ) {
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
    }else if (section == 4){
        return 0.01;
    }else{
    return 6.5;
    }
    
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
- (void)LeftMenuViewClick:(NSIndexPath *)indexPath{
    [self.menu hidenWithAnimation];
    NSDictionary * userinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    
    if (indexPath.section ==0 &&indexPath.row ==0) {
        
        if (userinfo == nil) {
              [self.navigationController pushViewController:[[LoginController alloc]init] animated:YES];
        }else{
         [self.navigationController pushViewController:[[PersonCenterViewController alloc]init] animated:YES];
        }

    }else{
        if (userinfo == nil) {
            [self.navigationController pushViewController:[[LoginController alloc]init] animated:YES];
        }else{
             CrowdfundingListViewController *crowdFundingList = [[CrowdfundingListViewController alloc]init];
            if (indexPath.section == 1) {
                //直播
                crowdFundingList.dict = _me.leftLiveList[indexPath.row];
                crowdFundingList.isState = 0;
            }else if (indexPath.section == 2){
                //众筹
                crowdFundingList.dict = _me.leftCrowdList[indexPath.row];
                crowdFundingList.isState = 1;
            }
            [self.navigationController pushViewController:crowdFundingList animated:YES];
        }
    
    }

}

#pragma mark --------textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textFiel
{
    
    [_topNav setupRightBut:@"取消"];
    self.cover.hidden = NO;
}
-(void)setreMenUI{
    
 
    //================
    
    UIImageView *shuimg= [[UIImageView alloc]initWithFrame:CGRectMake(15, 17, 3, 20)];
    shuimg.backgroundColor = [UIColor greenColor];
    [self.cover addSubview:shuimg];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shuimg.frame)+10, CGRectGetMinY(shuimg.frame), 200, 20)];
    lab.text = @"历史记录";
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:13];
    [self.cover addSubview:lab];
    
    NSArray *tarr = @[@"盗墓笔记盗墓笔记盗墓笔记",@"盗墓笔记",@"空空道人谈股市",@"叶文有话要说",@"相声",@"二货一箩筐",@"单田方",];
    
    float butX = 15;
    float butY = CGRectGetMaxY(shuimg.frame)+10;
    for(int i = 0; i < tarr.count; i++){
        
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [tarr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width+20>ScreenWidth-15) {
            
            butX = 15;
            
            butY += 55;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width+20, 40)];
        //搜索按钮点击
        [but addTarget:self action:@selector(searchButClick:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:tarr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 8;
        but.layer.borderColor = [UIColor lightGrayColor].CGColor;
        but.layer.borderWidth = 1;
        [self.cover addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+10;
        _butY = but;
    }
    //热门搜索
    
    UIImageView *bottomImage= [[UIImageView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(_butY.frame)+17, 3, 20)];
    bottomImage.backgroundColor = [UIColor greenColor];
    [self.cover addSubview:bottomImage];

    UILabel *bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bottomImage.frame)+10, CGRectGetMinY(bottomImage.frame), 200, 20)];
    bottomLab.text = @"热门搜索";
    bottomLab.textColor = [UIColor grayColor];
    bottomLab.font = [UIFont systemFontOfSize:13];
    [self.cover addSubview:bottomLab];
    
    NSArray *bottomTarr = @[@"盗墓笔记",@"空空道人谈股市",@"盗墓笔记盗墓笔记盗墓笔记",@"叶文有话要说",@"相声",@"二货一箩筐",@"盗墓笔记盗墓笔记盗墓笔记",@"单田方"];
    
    float bottombutX = 15;
    float bottombutY = CGRectGetMaxY(bottomImage.frame)+10;
    for(int i = 0; i < bottomTarr.count; i++){
        
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        CGRect frame_W = [bottomTarr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (bottombutX+frame_W.size.width+20>ScreenWidth-15) {
            
            bottombutX = 15;
            
            bottombutY += 55;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(bottombutX, bottombutY, frame_W.size.width+20, 40)];
        //搜索按钮点击
        [but addTarget:self action:@selector(searchButClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [but setTitle:bottomTarr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius = 8;
        but.layer.borderColor = [UIColor lightGrayColor].CGColor;
        but.layer.borderWidth = 1;
        [self.cover addSubview:but];
        
        bottombutX = CGRectGetMaxX(but.frame)+10;
        _butY = but;
    }
    
}

#pragma mark --------搜索按钮点击
- (void)searchButClick:(UIButton *)but{
    WYLog(@"%@",but.currentTitle);
    [_topNav.searchBar endEditing:YES];
    [self.cover removeFromSuperview];
}
#pragma mark --------退出输入框
- (void)addAGesutreRecognizerForYourView

{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
    [self.cover addGestureRecognizer:tapGesture];
    
}

- (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer

{
      [_topNav.searchBar endEditing:YES];
    
    
}
@end
