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
    //记录最后一个坐标
    UIButton *_butY;
}
//遮盖
//轮播图的数据
@property(nonatomic,strong)NSMutableArray *bannerListArray;
//直播的数据
@property(nonatomic,strong)NSMutableArray *liveListArray;
//众筹数据
@property(nonatomic,strong)NSMutableArray *crowdListArray;
@property(nonatomic,weak)UIScrollView *cover;
@property(nonatomic,weak)UITableView *tabView;

@end

@implementation CrowdfundingListViewController
- (NSMutableArray *)liveListArray{
    if (!_liveListArray) {
        NSMutableArray *liveListArray = [NSMutableArray array];
        _liveListArray =liveListArray;
    }
    return _liveListArray;
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
- (NSMutableArray *)bannerListArray{
    if (!_bannerListArray) {
        NSMutableArray *bannerListArray = [NSMutableArray array];
        _bannerListArray =bannerListArray;
    }
    return _bannerListArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //监听通知
    [self addNot];
    _topNav.hidden = NO;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
     _topNav.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置顶部页面
    [self setupUi];
    //加载网络请求
    [self setupHttp];
}
#pragma mark --------加载网络请求
- (void)setupHttp{
    [self ShowMBProgressHUD];
    NSDictionary *dict = @{@"itemId":self.dict[@"itemType"]};

    WYLog(@"%@",dict);
    [WYHttpTool postHttps:GETCROWDLIST param:dict Success:^(NSDictionary *dict, BOOL success) {
        if ([dict[@"code"] isEqualToString:@"0"]) {//请求
            [self HideTheHUD];
            //判断是直播还是众筹
            self.bannerListArray =[bannerListModel objectArrayWithKeyValuesArray:dict[@"data"][@"bannerList"]];
            if (self.isState == 0) {
                self.liveListArray = [liveListModel objectArrayWithKeyValuesArray:dict[@"data"][@"liveList"]];
            }else{
             self.crowdListArray = [liveListModel objectArrayWithKeyValuesArray:dict[@"data"][@"crowdList"]];
            }
         
            self.tabView.hidden = NO;
            [self.tabView reloadData];
     
        }else{
        [self ShowComplitedHUDWith:dict[@"msg"]];
        }
               WYLog(@"%@",dict);
    } fail:^(NSError *error) {
        WYLog(@"%@",error);
        [self HideTheHUD];
        [self ShowComplitedHUDWith:@"网络加载失败..."];
    }];


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
    self.tabView.hidden = YES;
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
#pragma mark --------顶部自定义view的代理方法
- (void)TopNavView:(TopNavView *)TopNavView didLeftButClick:(UIButton *)but{
    [_topNav.searchBar endEditing:YES];
    [self.cover removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)TopNavView:(TopNavView *)TopNavView didRightButClick:(UIButton *)but{
    if ([but.currentTitle isEqualToString:@"取消"]) {
        [_topNav setupRightBut:@"北京"];
        [_topNav.searchBar endEditing:YES];
        [self.cover removeFromSuperview];
        
    }
    WYLog(@"%@",but.currentTitle);
}
#pragma mark --------textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [_topNav setupRightBut:@"取消"];
    self.cover.hidden = NO;
}
- (void)dealloc{
    [_topNav removeFromSuperview];
    _topNav = nil;
}
#pragma mark --------tabView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        if (self.isState == 0) {
            return self.liveListArray.count;
        }else{
            return self.crowdListArray.count;
        }
  
    }
    
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TopUIScrollViewCell *cell = [TopUIScrollViewCell cellWithTableView:tableView];
        [cell setupView:self.bannerListArray];
           return cell;
    }else{
        CrowdfundingListCell * cell = [CrowdfundingListCell cellWithTableView:tableView];
        if (self.isState == 0) {
            cell.model = self.liveListArray[indexPath.row];
        }else{
            cell.model = self.crowdListArray[indexPath.row];
        }
        
        return cell;
    }

    
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScreenWidth *0.618;
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
