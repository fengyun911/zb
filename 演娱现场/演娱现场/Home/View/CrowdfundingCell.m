//
//  CrowdfundingCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/22.
//  Copyright © 2017年 yyxc. All rights reserved.
#import "crowdListModel.h"
#import "CrowdfundingCell.h"
#import "PICircularProgressView.h"
#import "UIButton+WebCache.h"
@interface CrowdfundingCell()
@property(nonatomic,weak)UIView *bgView;
/**滚动的scrollView*/
@property(nonatomic,weak)UIScrollView *scrollView;
/**分割的view*/
@property(nonatomic,weak)UIImageView *intervalImageView;
/**众筹的label*/
@property(nonatomic,weak)UILabel *crowdfundingLabel;
/**状态的imageView*/
@property(nonatomic,weak)UIImageView *statusImageView;
/**按钮的图片*/
@property(nonatomic,weak)UIButton *imageBut;
/**介绍的label*/
@property(nonatomic,weak)UILabel *introductionLabel;
/**金额的label*/
@property(nonatomic,weak)UILabel *amountLabel;
/**百分比的数值*/
@property(nonatomic,weak)PICircularProgressView *pICircularProgressView;
@end
@implementation CrowdfundingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CrowdfundingCell";
    
    CrowdfundingCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[CrowdfundingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = HOMECELLBG;
    }
    
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置cell
        [self setupCell];
    }
    
    return  self;
}
- (void)setupCell{
    //众筹的view
    UILabel *crowdfundingLabel = [[UILabel alloc]init];
    _crowdfundingLabel = crowdfundingLabel;
    crowdfundingLabel.font = CFont16;
    crowdfundingLabel.text = @"众筹";
    crowdfundingLabel.textColor = HOMELABELCOLOR;
    [self.contentView addSubview:crowdfundingLabel];
    crowdfundingLabel.sd_layout.leftSpaceToView(self.contentView,WYmargin).topEqualToView(self.contentView).widthRatioToView(self.contentView,1).heightIs(42);
    [self.contentView addSubview:crowdfundingLabel];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    //隐藏指示条
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    [self.contentView addSubview:scrollView];

    
}
#pragma mark --------设置view
- (void)setupView:(NSMutableArray *)array{
    if (self.bgView == nil&&array.count) {
        CGFloat viewW = (ScreenWidth - WYmargin2*3) /2;
        for (int i = 0; i<array.count; i++) {
            UIView *bgView = [[UIView alloc]init];
            _bgView = bgView;
            //图片
            UIButton *imageBut = [[UIButton alloc]init];
            imageBut.tag = i;
            [imageBut addTarget:self action:@selector(imageButClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:imageBut];
            crowdListModel *model = array[i];
            [imageBut sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal
                                  placeholderImage:nil];
            imageBut.frame = CGRectMake(0, 0, viewW, viewW *0.7);
            //标题
            UILabel *introductionLabel = [[UILabel alloc]init];
            [bgView addSubview:introductionLabel];
            introductionLabel.numberOfLines = 2;
            introductionLabel.text = model.title1;
            introductionLabel.font = CFont15;
            introductionLabel.textColor = HOMELABELCOLOR;
            introductionLabel.sd_layout.leftSpaceToView(bgView,WYmargin2).topSpaceToView(imageBut,0).rightSpaceToView(bgView,WYmargin2).heightIs(44);
            //金额
            UILabel *amountLabel = [[UILabel alloc]init];
            //设置圆角
            amountLabel.layer.cornerRadius = WYmargin;
            //将多余的部分切掉
            amountLabel.layer.masksToBounds = YES;
            amountLabel.textAlignment = NSTextAlignmentCenter;
            amountLabel.backgroundColor = HOMELABELBG;
            amountLabel.text = @"目标金额:300万";
            amountLabel.textColor  = HOMELABELCOLOR;
            amountLabel.font = Font14;
            [bgView addSubview:amountLabel];
            amountLabel.sd_layout.leftEqualToView(introductionLabel).widthRatioToView(introductionLabel,0.7).heightIs(WYmargin*2.5).topSpaceToView(introductionLabel,WYmargin*2);
            //进度条初始化
            PICircularProgressView *progressView = [[PICircularProgressView alloc] init];
            [bgView addSubview:progressView];
            progressView.sd_layout.leftSpaceToView (amountLabel,WYmargin).rightSpaceToView(bgView,0).heightRatioToView(progressView,1).centerYEqualToView(amountLabel);
            progressView.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:0.0];
            progressView.textLabel.text = [NSString stringWithFormat:@"%@%%",@"50"];
            //        progressView.textLabel.font = Font14;
            progressView.progress = 0.5;
            
            bgView.frame = CGRectMake(WYmargin2 +(i *(viewW +WYmargin2)), 0, viewW,0);
            [self.scrollView addSubview:bgView];
            
            [bgView setupAutoHeightWithBottomView:progressView bottomMargin:0];
            
        }
        
        self.scrollView.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(42+viewW *0.7+44+WYmargin*3).topSpaceToView(_crowdfundingLabel,0);
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.scrollView.subviews.lastObject.frame), 0);
        //***********************高度自适应cell设置步骤************************
        
        [self setupAutoHeightWithBottomView:self.scrollView bottomMargin:0];

    }
    
}
#pragma mark --------图片按钮点击
- (void)imageButClick:(UIButton *)but{
    //发送推送
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CrowdfundingCellButClick" object:nil userInfo:@{@"key":@"ceshi"}];
}
@end
