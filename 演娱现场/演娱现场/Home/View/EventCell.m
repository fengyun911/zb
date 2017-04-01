//
//  EventCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "EventCell.h"
@interface EventCell()
@property(nonatomic,weak)UILabel *title;
@property(nonatomic,weak)UILabel *date;
@property(nonatomic,weak)UILabel *content;
@end
@implementation EventCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"EventCell";
    
    EventCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[EventCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //设置标题
    UILabel *title = [[UILabel alloc]init];
    _title = title;
    [self.contentView addSubview:title];
    title.font = Font18;
    title.textColor = [UIColor whiteColor];
    title.sd_layout.leftSpaceToView(self.contentView,WYmargin).topEqualToView(self.contentView).rightSpaceToView(self.contentView,WYmargin).heightIs(44);
    
    //设置日期
    UILabel *date = [[UILabel alloc]init];
    _date = date;
    [self.contentView addSubview:date];
    date.font = Font15;
    date.textColor = LIVEDATE;
    date.sd_layout.leftSpaceToView(self.contentView,WYmargin).topSpaceToView(title,0).rightSpaceToView(self.contentView,WYmargin).heightIs(30);
    //设置内容
    UILabel *content = [[UILabel alloc]init];
    _content = content;
    [self.contentView addSubview:content];
    content.font = Font15;
    content.textColor = LIVECONTENT;
    content.sd_layout.leftSpaceToView(self.contentView,WYmargin).topSpaceToView(date,WYmargin).rightSpaceToView(self.contentView,WYmargin).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:content bottomMargin:WYmargin];
//    @property(nonatomic,weak)UILabel *title;
//    @property(nonatomic,weak)UILabel *date;
//    @property(nonatomic,weak)UILabel *content;
    
}
#pragma mark --------设置view
-(void)setModel:(liveDetailModel *)model{
        _model = model;
        _title.text = model.titleName;
        _content.text = model.introduction;
        _date.text = model.actTime;
}
@end
