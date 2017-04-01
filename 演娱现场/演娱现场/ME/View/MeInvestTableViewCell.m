//
//  MeInvestTableViewCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/13.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "MeInvestTableViewCell.h"
@interface MeInvestTableViewCell()
//设置顶部的分割线
@property(nonatomic,weak)WyBut *topBut;
//设置顶部状态label
@property(nonatomic,weak)UILabel *rightLabel;
//图片
@property(nonatomic,weak)UIImageView *leftImageView;
//设置标题label
@property(nonatomic,weak)UILabel *title;
//设置内容label
@property(nonatomic,weak)UILabel *content;
//设置底部右下角按钮
@property(nonatomic,weak)WyBut *bottomBut;
@end
@implementation MeInvestTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"MeInvestTableViewCell";
    
    MeInvestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[MeInvestTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =  [UIColor colorWithHexString:@"ffffff"];
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
    //设置顶部的分割线
    UIView *topView = [[UIView alloc]init];
    topView.frame = CGRectMake(0, 0, ScreenWidth, WYmargin);
    topView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.contentView addSubview:topView];
    //设置左边按钮
    WyBut *topBut = [[WyBut alloc]init];
    [topBut setTitleColor:[UIColor colorWithHexString:@"242424"] forState:UIControlStateNormal];
    [topBut setImage:[UIImage imageNamed:@"我的投资-更多-"] forState:UIControlStateNormal];
    [topBut setTitle:@"戏剧表演" forState:UIControlStateNormal];
    topBut.titleLabel.font = Font18;
    _topBut = topBut;
    [self.contentView addSubview:topBut];
    topBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    topBut.imageEdgeInsets = UIEdgeInsetsMake(0, WYmargin*10, 0, 0);
    _topBut.frame = CGRectMake(11.5, CGRectGetMaxY(topView.frame), 120, 48.5);
    //设置右边的label
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.text = @"募捐成功";
    rightLabel.textColor = [UIColor colorWithHexString:@"6198ce"];
    _rightLabel = rightLabel;
    rightLabel.font = Font12;
    rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:rightLabel];
    rightLabel.sd_layout.rightSpaceToView(self.contentView,12).topEqualToView(topBut).bottomEqualToView(topBut).widthIs(80);
    //设置分割线
    UIView *topWireView = [[UIView alloc]init];
    topWireView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.contentView addSubview:topWireView];
    topWireView.sd_layout.rightSpaceToView(self.contentView,0).topSpaceToView(rightLabel,0  ).leftEqualToView(self.contentView).heightIs(1);
    //设置图片
    UIImageView *leftImageView = [[UIImageView alloc]init];
    _leftImageView = leftImageView;
    [self.contentView addSubview:leftImageView];
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489630436&di=c02373ce2dc67abf99fda1867b46c773&imgtype=jpg&er=1&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F5243fbf2b21193138ff8eeb167380cd791238d73.jpg"] placeholderImage:nil];
    leftImageView.sd_layout.leftSpaceToView(self.contentView,8).topSpaceToView(topWireView,8).widthIs(83.5).heightIs(80);
    
    //设置标题
    UILabel *title = [[UILabel alloc]init];
    title.font = Font18;
    title.textColor = [UIColor colorWithHexString:@"808080"];
    _title = title;
    [self.contentView addSubview:title];
    title.text = @"千呼万唤,华语乐坛巅峰《今晚打老虎》";
    title.sd_layout.leftSpaceToView(leftImageView,WYmargin).topEqualToView(leftImageView).rightSpaceToView(self.contentView,WYmargin).heightRatioToView(leftImageView,0.4);
    
    //设置内容
    UILabel *content = [[UILabel alloc]init];
    content.numberOfLines = 2;
    content.font = Font12;
    content.textColor = [UIColor colorWithHexString:@"9c9c9c"];
    _content = content;
    [self.contentView addSubview:content];
    content.text = @"千呼万唤,华语乐坛巅峰《今晚打老虎》,千呼万唤,华语乐坛巅峰《今晚打老虎》";
    content.sd_layout.leftSpaceToView(leftImageView,WYmargin).topSpaceToView(title,0).rightSpaceToView(self.contentView,WYmargin).heightRatioToView(leftImageView,0.6);
    
    //设置分割线
    UIView *bottomWireView = [[UIView alloc]init];
    bottomWireView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.contentView addSubview:bottomWireView];
    bottomWireView.sd_layout.rightSpaceToView(self.contentView,0).topSpaceToView(leftImageView,8  ).leftEqualToView(self.contentView).heightIs(1);
    
    //设置底部按钮
    WyBut *bottomBut = [[WyBut alloc]init];
    _bottomBut = bottomBut;
    [self.contentView addSubview:bottomBut];
    [bottomBut setTitle:@"我要投资" forState:UIControlStateNormal];
    [bottomBut setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    bottomBut.backgroundColor = [UIColor colorWithHexString:@"0a76d8"];
    bottomBut.sd_layout.rightSpaceToView(self.contentView,WYmargin).topSpaceToView(bottomWireView,8).heightIs(32.5).widthIs(90);
    // 设置圆角的大小
    bottomBut.layer.cornerRadius = 5;
    [bottomBut.layer setMasksToBounds:YES];
}


@end
