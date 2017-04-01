//
//  TopicCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/3.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "TopicCell.h"
#import "UIImageView+WebCache.h"
@interface TopicCell()
@property(nonatomic,weak)UIImageView *leftImageView;
@property(nonatomic,weak)UILabel *labelTitle;
@property(nonatomic,weak)UILabel *labelText;
@end
@implementation TopicCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"TopicCell";
    
    TopicCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[TopicCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //设置头像
    UIImageView *leftImageView = [[UIImageView alloc]init];
    _leftImageView = leftImageView;
    [self.contentView addSubview:leftImageView];
    leftImageView.backgroundColor = [UIColor grayColor];
    leftImageView.sd_layout.leftSpaceToView(self.contentView,WYmargin).topSpaceToView(self.contentView,WYmargin).widthIs(44).heightIs(44);
    // 设置圆角的大小
    leftImageView.layer.cornerRadius = 22;
    [leftImageView.layer setMasksToBounds:YES];
    
    //设置标题
    
    UILabel * labelTitle = [[UILabel alloc]init];
    _labelTitle =labelTitle;
    [self.contentView addSubview:labelTitle];
    labelTitle.font = Font16;
    labelTitle.textColor = [UIColor colorWithHexString:@"c4c4c4"];
    labelTitle.text = @"测试显示标题文字";
    labelTitle.sd_layout.leftSpaceToView(leftImageView,WYmargin).rightSpaceToView(self.contentView,WYmargin).topSpaceToView(self.contentView,WYmargin).heightIs(22);
    
    //设置内容
    UILabel *labelText = [[UILabel alloc]init];
    _labelText =labelText;
    [self.contentView addSubview:labelTitle];
    labelTitle.font = Font16;
    labelTitle.textColor = [UIColor colorWithHexString:@"c4c4c4"];
    labelTitle.sd_layout.leftSpaceToView(leftImageView,WYmargin).rightSpaceToView(self.contentView,WYmargin).topSpaceToView(leftImageView,0).autoHeightRatio(0);
    
        [self setupAutoHeightWithBottomView:labelTitle bottomMargin:WYmargin*2];
//    @property(nonatomic,weak)UIImageView *leftImageView;
//    @property(nonatomic,weak)UILabel *labelTitle;
//    @property(nonatomic,weak)UILabel *labelText;
    
}
#pragma mark --------设置view
- (void)setModel:(commentListModel *)model{
    _model = model;
    _labelTitle.text =model.cContent;
}
@end
