//
//  CrowdfundingListCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/4/1.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "PICircularProgressView.h"
#import "CrowdfundingListCell.h"
#import "UIImageView+WebCache.h"
@interface CrowdfundingListCell()
@property(nonatomic,weak)UIImageView *topImage;
@property(nonatomic,weak)UILabel *title;
@property(nonatomic,weak)UILabel *content;
@property(nonatomic,weak)WyBut *look;
@property(nonatomic,weak)WyBut *zan;
@property(nonatomic,weak)UILabel *amount;
/**百分比的数值*/
@property(nonatomic,weak)PICircularProgressView *pICircularProgressView;
@end
@implementation CrowdfundingListCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CrowdfundingListCell";
    
    CrowdfundingListCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[CrowdfundingListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //设置顶部的图片
    UIImageView *topImage = [[UIImageView alloc]init];
    _topImage = topImage;
    [self.contentView addSubview:topImage];
    topImage.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topEqualToView(self.contentView).heightRatioToView(self.contentView,0.6);
    [topImage sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/15/27/54/92t58PICsYq_1024.jpg"] placeholderImage:nil];
    //设置标题
    UILabel *title = [[UILabel alloc]init];
    title.text = @"千呼万唤 华语乐坛巅峰的天后";
    _title = title;
    [self.contentView addSubview:title];
    title.textColor = [UIColor colorWithHexString:@"bebebe"];
    title.font = Font16;
    title.sd_layout.leftSpaceToView(self.contentView,11.5).rightSpaceToView(self.contentView,11.5).topSpaceToView(topImage,WYmargin).heightRatioToView(self.contentView,0.1);
    //设置内容
    UILabel *content = [[UILabel alloc]init];
    content.text = @"张惠妹《乌托邦2.0庆典》世界巡回演唱会北京站";
    _content = content;
    [self.contentView addSubview:content];
    content.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    content.font = Font14;
    content.sd_layout.leftSpaceToView(self.contentView,11.5).rightSpaceToView(self.contentView,11.5).topSpaceToView(title,0).heightRatioToView(self.contentView,0.1);
    //进度条初始化
    PICircularProgressView *progressView = [[PICircularProgressView alloc] init];
    _pICircularProgressView =progressView;
    [_topImage addSubview:progressView];
    progressView.sd_layout.rightSpaceToView(topImage,WYmargin*2).bottomSpaceToView(topImage,WYmargin).widthRatioToView(topImage,0.12).heightEqualToWidth();
    
    progressView.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:0.0];
    progressView.textLabel.text = [NSString stringWithFormat:@"%@%%",@"50"];
    //        progressView.textLabel.font = Font14;
    progressView.progress = 0.5;
    
    //左边观看按钮
    //观看数
    WyBut *look = [[WyBut alloc]init];
    look.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contentView addSubview:look];
    [look setTitle:@"9999+" forState:UIControlStateNormal];
    [look setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    [look setImage:[UIImage imageNamed:@"观看-拷贝-2"] forState:UIControlStateNormal];
    look.imageEdgeInsets = UIEdgeInsetsMake(0, 11.5, 0, 0);
    
     look.titleEdgeInsets = UIEdgeInsetsMake(0, 23, 0,0);
    look.titleLabel.font = Font14;
    look.sd_layout.leftEqualToView(self.contentView).bottomEqualToView(self.contentView).topSpaceToView(content,0).widthRatioToView(self.contentView,0.4);
    
    //点赞数
    //观看数
    WyBut *zan = [[WyBut alloc]init];
    zan.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.contentView addSubview:zan];
    [zan setTitle:@"9999+" forState:UIControlStateNormal];
    [zan setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    [zan setImage:[UIImage imageNamed:@"心"] forState:UIControlStateNormal];
    zan.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,11.5);
    zan.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 23);
    zan.titleLabel.font = Font14;
    zan.sd_layout.rightEqualToView(self.contentView).bottomEqualToView(self.contentView).topSpaceToView(content,0).widthRatioToView(self.contentView,0.4);
}

@end
