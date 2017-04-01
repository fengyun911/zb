//
//  IntegralCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/15.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "IntegralCell.h"
@interface IntegralCell()
@property(nonatomic,weak)WyBut *title;
@property(nonatomic,weak)UILabel *date;
@property(nonatomic,weak)UILabel *numbers;
@end
@implementation IntegralCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"IntegralCell";
    
    IntegralCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[IntegralCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    WyBut *title = [[WyBut alloc]init];
    [self.contentView addSubview:title];
    title.titleEdgeInsets = UIEdgeInsetsMake(0, WYmargin, 0, 0);
    title.titleLabel.font = Font18;
    [title setTitle:@"用户分享" forState:UIControlStateNormal];
    [title setTitleColor:[UIColor colorWithHexString:@"787878"] forState:UIControlStateNormal];
    [title setImage:[UIImage imageNamed:@"我的积分圆点"] forState:UIControlStateNormal];
    title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    title.sd_layout.leftSpaceToView(self.contentView,WYmargin+WYmargin2).topSpaceToView(self.contentView,6.5).widthIs(150).heightIs(25);
    //右边的数字
    UILabel *numbers = [[UILabel alloc]init];
    [self.contentView addSubview:numbers];
    numbers.textColor = [UIColor colorWithHexString:@"787878"];
    numbers.font = Font18;
    numbers.text = @"+433";
    numbers.sd_layout.rightSpaceToView(self.contentView,WYmargin2+WYmargin).topEqualToView(title).bottomEqualToView(title).widthIs(100);
    //底部的日期
    UILabel *date = [[UILabel alloc]init];
    date.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:date];
    date.textColor = [UIColor colorWithHexString:@"a1a1a1"];
    date.font = Font16;
    date.text = @"2017-12-03";
    date.sd_layout.leftSpaceToView(self.contentView,WYmargin+WYmargin2).topSpaceToView(title,0).heightIs(25).widthIs(100);
    //底部的分割线
    UIView *view = [[UIView alloc]init];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"d5d5d5"];
    view.sd_layout.topSpaceToView(date,6.5).leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(1);
}


@end
