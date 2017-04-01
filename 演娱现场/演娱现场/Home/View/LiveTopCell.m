//
//  LiveTopCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#define CellHeight   300
#import "LiveTopCell.h"
#import "UIButton+WebCache.h"
@interface LiveTopCell()
@property(nonatomic,weak)WyBut *topImageView;
@property(nonatomic,weak)WyBut *yj;
@property(nonatomic,weak)WyBut *xx;
@property(nonatomic,weak)WyBut *wyzc;
@end
@implementation LiveTopCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"LiveTopCell";
    
    LiveTopCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[LiveTopCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //我要众筹
    WyBut *wyzc = [[WyBut alloc]init];
    [wyzc addTarget:self action:@selector(meCrowdfundingButClick) forControlEvents:UIControlEventTouchUpInside];
    _wyzc = wyzc;
    [self.contentView addSubview:wyzc];
    wyzc.backgroundColor = [UIColor colorWithHexString:@"ed3ff6"];
    [wyzc setTitle:@"我要众筹" forState:UIControlStateNormal];
    [wyzc setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    wyzc.titleLabel.font = Font16;
    
    wyzc.sd_layout.rightEqualToView(self.contentView).bottomEqualToView(self.contentView).widthIs(78).heightIs(44);
    
    UIView *bootom = [[UIView alloc]init];
    [self.contentView addSubview:bootom];
    bootom.backgroundColor = [UIColor colorWithHexString:@"6603fe"];
    bootom.sd_layout.leftEqualToView(self.contentView).rightSpaceToView(wyzc,0).bottomEqualToView(self.contentView).heightIs(wyzc.height);
    
    //眼睛按钮
    WyBut *yj = [[WyBut alloc]init];
     yj.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin, 0, 0);
    _yj = yj;
    [bootom addSubview:yj];
    [yj setTitle:@"2100万" forState:UIControlStateNormal];
    [yj setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    yj.titleLabel.font = Font16;
    [yj setImage:[UIImage imageNamed:@"观看"] forState:UIControlStateNormal];
    yj.sd_layout.leftSpaceToView(bootom,WYmargin).topEqualToView(bootom).bottomEqualToView(bootom).widthRatioToView(bootom,0.3);
    
    
    //星星按钮
    WyBut *xx = [[WyBut alloc]init];
    xx.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin, 0, 0);
    _xx= xx;
    [bootom addSubview:xx];
    [xx setTitle:@"324555" forState:UIControlStateNormal];
    [xx setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    xx.titleLabel.font = Font16;
    [xx setImage:[UIImage imageNamed:@"点赞(点)"] forState:UIControlStateNormal];
    xx.sd_layout.leftSpaceToView(yj,WYmargin+5).topEqualToView(bootom).bottomEqualToView(bootom).widthRatioToView(bootom,0.3);
    
    //设置页面数据
    WyBut *topImageView = [[WyBut alloc]init];
    _topImageView = topImageView;
    [self.contentView addSubview:topImageView];
    topImageView.sd_layout.topEqualToView(self.contentView).leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomSpaceToView(bootom,0);
    UIButton *imageBug = [[UIButton alloc]init];
    [topImageView addSubview:imageBug];
    imageBug.sd_layout.topEqualToView(topImageView).leftEqualToView(topImageView).rightEqualToView(topImageView).bottomEqualToView(topImageView);
    [imageBug setImage:[UIImage imageNamed:@"直播"] forState:UIControlStateNormal];
    [imageBug addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark --------设置view
- (void)setModel:(liveDetailModel *)model{
    _model = model;
    [_topImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:nil];
}
#pragma mark 点击直播按钮
- (void)imageBugClick{
    WYLog(@"%@",self.model.liveUrl);
    //传送通知打开视频
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playLive" object:nil userInfo:@{@"key":self.model}];
}
- (void)playAction:(UIButton *)button
{
    if (_videoDelegate && [_videoDelegate respondsToSelector:@selector(PlayVideoWithCell:)])
    {
        [_videoDelegate PlayVideoWithCell:self];
    }
}
#pragma mark --------我要众筹按钮点击
- (void)meCrowdfundingButClick{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"meCrowdfundingButClick" object:nil];
}
@end
