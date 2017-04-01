//
//  MeInvestmentViewController.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/10.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "LTExperstParticularsLabel.h"
#import "MeInvestmentViewController.h"
#import "MeAllViewController.h"
#import "MeNonPaymentViewController.h"
#import "MeRaiseViewController.h"
#import "MeSucceedViewController.h"
#import "MeFailureViewController.h"
#import "TitleView.h"
#import "guanzhuScrollView.h"
@interface MeInvestmentViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    CGFloat _margin;
    UIView *_breadView;
}
/**
 *  按钮存放的view
 */
@property(nonatomic,weak)TitleView *topView;
/**
 *  存放内容的scrollView
 */
@property(nonatomic,weak)guanzhuScrollView *scrollView;
@property(nonatomic,weak)UILabel *label;
@end

@implementation MeInvestmentViewController
- (guanzhuScrollView *)scrollView{
    if (!_scrollView) {
        guanzhuScrollView *scrollView =[[guanzhuScrollView alloc]init];
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.frame = CGRectMake(0, 64, self.view.width, self.view.height);
        //设置内容的宽度
        CGFloat contentsContentW = self.childViewControllers.count * self.scrollView.width;
        _scrollView.contentSize = CGSizeMake(contentsContentW, 0);
        _scrollView.pagingEnabled = YES;
        // 隐藏水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)topView{
    if (!_topView) {
        TitleView * topView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        [self.view addSubview:topView];
        _topView = topView;
        _breadView = [[UIView alloc]init];
        _breadView.backgroundColor = [UIColor blackColor];
        _breadView.frame = CGRectMake(0,60,0,4);
        [_topView addSubview:_breadView];

    }
    return _topView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置页面
    self.title = @"我的投资";
    //添加子控制器
    [self setupChildVces];
    //添加点击按钮
    [self setupTitles];
    //添加默认控制器
    [self setupController];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
/**
 *  添加子控制器
 */
- (void)setupChildVces{
    
    MeAllViewController *MeAll = [[MeAllViewController alloc]init];
    MeAll.title = @"全部";
    [self addChildViewController:MeAll];
    
    MeNonPaymentViewController *MeNonPayment = [[MeNonPaymentViewController alloc]init];
    MeNonPayment.title = @"未付款";
    [self addChildViewController:MeNonPayment];
    
    MeRaiseViewController *MeRaise = [[MeRaiseViewController alloc]init];
    MeRaise.title =@"募集中";
    [self addChildViewController:MeRaise];
    
    MeSucceedViewController *MeSucceed = [[MeSucceedViewController alloc]init];
    MeSucceed.title = @"募集成功";
    [self addChildViewController:MeSucceed];
    
    MeFailureViewController * MeFailure = [[MeFailureViewController alloc]init];
    MeFailure.title = @"募集失败";
    [self addChildViewController:MeFailure];
}
- (void)setupTitles{
     LTExperstParticularsLabel * mjcg = [[LTExperstParticularsLabel alloc]init];
        mjcg.font = Font17;
        mjcg.text = @"募集成功";
    CGSize mjcgSize = [mjcg sizeThatFits:CGSizeMake(mjcg.frame.size.width, 64)];

    
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelW = mjcgSize.width;
    CGFloat labelH = 64;
    CGFloat labelY = 0;
    CGFloat labelX = 0;
    _margin = (ScreenWidth - mjcgSize.width*5)/6;
    for (NSUInteger i = 0 ; i <count; i++) {
        
        LTExperstParticularsLabel * label = [[LTExperstParticularsLabel alloc]init];
         label.lineBreakMode = NSLineBreakByWordWrapping;
        [self.topView addSubview:label];
        self.label =label;
        
        if (i==0) {
            labelX = _margin +labelW * i + _margin * i -WYmargin2;
        }else if(i ==1||i==2){
             labelX = _margin +labelW * i + _margin * i -WYmargin*2;
        }else if(i ==3){
            labelX = _margin +labelW * i + _margin * i -WYmargin-WYmargin;
        }else{
         labelX = _margin +labelW * i + _margin * i -WYmargin;
        }
        label.font = Font17;
        label.textColor = [UIColor colorWithHexString:@"242424"];
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        label.tag = i;
        if (i ==0) {
            _breadView.width = labelW;
            _breadView.x = labelX;
        }
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);

       
//
        //监听点击
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)]];
        
    }
}
- (void)setupController{
    //添加默认控制器
    UIViewController *firstVc =[self.childViewControllers firstObject];
    firstVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:firstVc.view];
    LTExperstParticularsLabel *firstLabel = self.topView.subviews[1];
    firstLabel.scale = 1.0;
    
}

/**
 *  监听label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer{
    //获取被点击的label
    LTExperstParticularsLabel * label = (LTExperstParticularsLabel *)recognizer.view;
    //计算X方向上的偏移量
    CGFloat offsetX = label.tag * self.scrollView.frame.size.width;
    //设置偏移量
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark --------监听UIscrollView
/**
 *  在scrollView动画结束时调用
 手动触发动画结束，不会调用这个方法
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //获得当前需要显示的子控制器的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    CGFloat value = scrollView.contentOffset.x/scrollView.frame.size.width;
    if (value==0) {
        _breadView.x = _margin+(self.label.width*value)+_margin*value;
    }else if(value ==1||value==2){
        _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin*2;
    }else if(value ==3){
        _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin-WYmargin;
    }else{
        _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin;
    }
    //如果子控制器的View已经在上面,就直接返回
    if (vc.view.superview) return;
    //添加
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcX = index*vcW;
    CGFloat vcY = 0;
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    [scrollView addSubview:vc.view];
    
   

    
}

/**
 *  当scrollView停止滚动调用这个方法(手动触发触发动画停止)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //2,2个文字的比例值
    //偏移量/宽度
    CGFloat value = scrollView.contentOffset.x/scrollView.frame.size.width;
    //    //左边文字的索引
    //    NSUInteger leftIndex = (NSUInteger)(scrollView.contentOffset.x/scrollView.frame.size.width);
    //    //右边文字的索引
    //    NSUInteger rightInex = leftIndex +1;
    //
    //    //右边文字的比例
    //    CGFloat rightScale = value - leftIndex;
    //    //左边文字的索引
    //    CGFloat leftScale = 1 - rightScale;
    //    //取出label设置大小和颜色
    //    LTExperstParticularsLabel * leftLabel = self.topView.subviews[leftIndex+2];
    //    leftLabel.scale = leftScale;
    //    if (rightInex < self.topView.subviews.count-2) {
    //        LTExperstParticularsLabel * rightLabel = self.topView.subviews[rightInex+2];
    //        rightLabel.scale = rightScale;
    //
    //    }
    if (value==0) {
        _breadView.x = _margin+(self.label.width*value)+_margin*value;
    }else if(value ==1||value==2){
        _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin*2;
    }else if(value ==3){
        _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin-WYmargin;
    }else{
        _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1,需要进行控制的文字(2个文字)
    //2,2个文字的比例值
    //偏移量/宽度
    //CGFloat value = scrollView.contentOffset.x/scrollView.frame.size.width;
//    //左边文字的索引
//    NSUInteger leftIndex = (NSUInteger)(scrollView.contentOffset.x/scrollView.frame.size.width);
//    //右边文字的索引
//    NSUInteger rightInex = leftIndex +1;
//
//    //右边文字的比例
//    CGFloat rightScale = value - leftIndex;
//    //左边文字的索引
//    CGFloat leftScale = 1 - rightScale;
//    //取出label设置大小和颜色
//    LTExperstParticularsLabel * leftLabel = self.topView.subviews[leftIndex+2];
//    leftLabel.scale = leftScale;
//    if (rightInex < self.topView.subviews.count-2) {
//        LTExperstParticularsLabel * rightLabel = self.topView.subviews[rightInex+2];
//        rightLabel.scale = rightScale;
//        
//    }
    //if (value==0) {
       //_breadView.x = _margin+(self.label.width*value)+_margin*value;
    //}else if(value ==1||value==2){
         //_breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin*2;
    //}else if(value ==3){
        // _breadView.x = _margin+(self.label.width*value)+_margin*value-WYmargin-WYmargin;
    //}else{
     // _breadView.x = _margin+(self.label.width*value)+_margin*value;
   // }

   
    
   
}

@end
