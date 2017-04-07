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
@property(nonatomic,weak)UIButton *leftBut;
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
    labelTitle.sd_layout.leftSpaceToView(leftImageView,WYmargin).rightSpaceToView(self.contentView,WYmargin).topSpaceToView(self.contentView,11+WYmargin).heightIs(22);
    
    //设置内容
    UILabel *labelText = [[UILabel alloc]init];
    _labelText =labelText;
    [self.contentView addSubview:labelText];
    labelText.font = Font16;
    labelText.textColor = [UIColor colorWithHexString:@"c4c4c4"];
    labelText.sd_layout.leftSpaceToView(leftImageView,WYmargin).rightSpaceToView(self.contentView,WYmargin).topSpaceToView(labelTitle,WYmargin).autoHeightRatio(0);
    //点赞和发表话题
    UIButton *rightBut = [[UIButton alloc]init];
    [rightBut addTarget:self action:@selector(rightButClcik) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:rightBut];
    rightBut.sd_layout.rightSpaceToView(self.contentView,WYmargin).heightIs(30).widthEqualToHeight().topSpaceToView(labelText,WYmargin);
    [rightBut setImage:[UIImage imageNamed:@"直播-评论"] forState:UIControlStateNormal];
    
    UIButton *leftBut = [[UIButton alloc]init];
    [leftBut addTarget:self action:@selector(leftButClick) forControlEvents:UIControlEventTouchUpInside];
    _leftBut = leftBut;
    [leftBut setTitleColor:[UIColor colorWithHexString:@"c4c4c4"] forState:UIControlStateNormal];
    [self.contentView addSubview:leftBut];
    leftBut.sd_layout.rightSpaceToView(rightBut,WYmargin*2).heightIs(30).widthIs(60).topSpaceToView(labelText,WYmargin);
    [leftBut setImage:[UIImage imageNamed:@"心"] forState:UIControlStateNormal];
    leftBut.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    leftBut.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, WYmargin);
    [self setupAutoHeightWithBottomView:rightBut bottomMargin:WYmargin];

}
#pragma mark --------设置view
- (void)setModel:(commentListModel *)model{
    _model = model;
    _labelTitle.text = [NSString stringWithFormat:@"%@ | %@",model.cName,model.cDate];
    _labelText.text =model.cContent;
    [_leftBut setTitle:@"112" forState:UIControlStateNormal];
   
}
#pragma mark--------点赞按钮点击
- (void)leftButClick{

}
#pragma mark--------发表评论按钮点击
- (void)rigthButClick{


}
@end
