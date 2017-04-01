//
//  LeftMenuViewDemo.m
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.

#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200

#import "LeftMenuViewDemo.h"
#import "MeCell.h"
#import "TitleCell.h"
@interface LeftMenuViewDemo ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView    *contentTableView;
@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;
@end

@implementation LeftMenuViewDemo

 
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}

-(void)initView{
    
    self.backgroundColor = [UIColor colorWithHexString:@"252525"];

    
    
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Frame_Width, self.frame.size.height - 64)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    self.contentTableView = contentTableView;
    contentTableView.backgroundColor = [UIColor colorWithHexString:@"252525"];
    [self addSubview:contentTableView];
    
    
}
/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
    _sectionArray = [NSMutableArray array];
    _flagArray  = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
//        NSMutableArray *rowArray = [NSMutableArray array];
//        for (int j = 0; j < arc4random()%20 + 1; j ++) {
//            [rowArray addObject:[NSString stringWithFormat:@"%d",j]];
//        }
//        [_sectionArray addObject:rowArray];
        [_flagArray addObject:@"0"];
    }
   
    
  
    if (self.leftLiveList.count) {
         [_sectionArray addObject:self.leftLiveList];
    }
    if (self.leftCrowdList.count) {
        [_sectionArray addObject:self.leftCrowdList];
    }

    [self.contentTableView reloadData];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSArray *arr = _sectionArray[section-1];
        return arr.count;
    }
 
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        return 84;
    }else{
        if ([_flagArray[indexPath.section] isEqualToString:@"0"]){
            return 0;
        }else{
            return 50;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
           MeCell *cell = [MeCell cellWithTableView:tableView];
          cell.clipsToBounds = YES;//这句话很重要 
           return cell;
    }else{
        TitleCell *cell = [TitleCell cellWithTableView:tableView];
        cell.title.text = _sectionArray[indexPath.section-1][indexPath.row][@"itemName"];
//        itemName : 大马戏,
//        itemId : 19
          cell.clipsToBounds = YES;//这句话很重要
           return cell;
    }
 
  
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath];
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        UIView *header = [[UIView alloc] init];
        header.tag = 100 + section;
        header.backgroundColor = MEBG;
        UILabel *sectionLabel = [[UILabel alloc] init];
        [header addSubview:sectionLabel];
        sectionLabel.sd_layout.leftSpaceToView(header,WYmargin).topSpaceToView(header,WYmargin).rightSpaceToView(header,WYmargin).bottomEqualToView(header);
        sectionLabel.textColor = [UIColor colorWithHexString:@"c8cccf"];
        if (section == 1) {
            sectionLabel.text = @"   直播";
        }else{
            sectionLabel.text = @"   众筹";
        }
     
        sectionLabel.textAlignment = NSTextAlignmentLeft;
        sectionLabel.backgroundColor = MENR;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
        [header addGestureRecognizer:tap];
        //按钮
        WyBut * wy = [[WyBut alloc]init];
        wy.userInteractionEnabled = NO;
        [header addSubview:wy];
        wy.sd_layout.topSpaceToView(header,WYmargin).rightSpaceToView(header,WYmargin).bottomEqualToView(header).widthIs(64);
        [wy setImage:[UIImage imageNamed:@"下一页-拷贝-3"] forState:UIControlStateNormal];
        return header;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else{
        return 64;
    }

}
- (void)sectionClick:(UITapGestureRecognizer *)tap{
    int index = tap.view.tag % 100;
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
//    NSArray *arr = _sectionArray[index];
    for (int i = 0; i < 2; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:path];
    }
    //展开
    if ([_flagArray[index] isEqualToString:@"0"]) {
        _flagArray[index] = @"1";
        [_contentTableView  reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
        for (UIView *view in tap.view.subviews) {
            if ([view isKindOfClass:[WyBut class]]) {
                [UIView animateWithDuration:0.25 animations:^{
                    view.transform = CGAffineTransformMakeRotation (M_PI_2);
                }];
            }
        }
    } else { //收起
        _flagArray[index] = @"0";
        [_contentTableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
        for (UIView *view in tap.view.subviews) {
            if ([view isKindOfClass:[WyBut class]]) {
                [UIView animateWithDuration:0.25 animations:^{
                    view.transform = CGAffineTransformMakeRotation (0);
                }];
            }
        }
       
    }
    //	NSRange range = NSMakeRange(index, 1);
    //	NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    //	[_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
