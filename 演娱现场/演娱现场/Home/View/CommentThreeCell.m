//
//  CommentThreeCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/3.
//  Copyright © 2017年 yyxc. All rights reserved.
//
#import "CommentThreeCell.h"
#import "UIImageView+WebCache.h"
@interface CommentThreeCell()
{
    BOOL _image;
}
@property(nonatomic,weak)UIImageView *leftImageView;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)WyBut *rightBut;
@property(nonatomic,weak)UIView *zView;
@end
@implementation CommentThreeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CommentThreeCell";
    
    CommentThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[CommentThreeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //设置左边的imageView
    UIImageView *leftImageView = [[UIImageView alloc]init];
    _leftImageView = leftImageView;
    [self.contentView addSubview:leftImageView];

    //右边的图片按钮
    WyBut *rightBut = [[WyBut alloc]init];
    rightBut.titleLabel.font = Font13;
    _rightBut = rightBut;
    [self.contentView addSubview:rightBut];
    //中间的按钮
    UIView *view = [[UIView alloc]init];
    _zView = view;
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor colorWithHexString:@"6b01fb"];
    //设置里面的内容
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.numberOfLines = 2;
    [view addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffe8"];
    _titleLabel = titleLabel;
    titleLabel.font = CFont16;
   
    
    [_rightBut setImage:[UIImage imageNamed:@"观看"] forState:UIControlStateNormal];
    
       _leftImageView.sd_layout.leftSpaceToView(self.contentView,2).topEqualToView(self.contentView).widthIs(64).heightIs(64);
    
    _rightBut.sd_layout.rightEqualToView(self.contentView).bottomEqualToView(_leftImageView).widthIs(56).heightIs(64);
    [_rightBut setTitle:@"123456" forState:UIControlStateNormal];
    [_rightBut setTitleColor:HOMELABELCOLOR forState:UIControlStateNormal];
    
    _zView.sd_layout.leftSpaceToView(_leftImageView,3).rightSpaceToView(_rightBut,0).bottomEqualToView(_leftImageView).heightRatioToView(_leftImageView,1);
    
    _titleLabel.sd_layout.leftSpaceToView(_zView,WYmargin).rightEqualToView(_zView).topEqualToView(_zView).heightRatioToView(_zView,1);
    [self setupAutoHeightWithBottomView:_leftImageView bottomMargin:2];
}
#pragma mark --------设置view
- (void)setModel:(perToppicListModel *)model{
    _model =model;
 
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.image1] placeholderImage:nil];
    

    if (_image == NO) {
        //使图片和文字水平居中显示
        [_rightBut setTitleEdgeInsets:UIEdgeInsetsMake(_rightBut.imageView.frame.size.height+WYmargin2 ,-_rightBut.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        
        [_rightBut setImageEdgeInsets:UIEdgeInsetsMake(-_rightBut.titleLabel.bounds.size.height - WYmargin2, 0.0,0.0, -_rightBut.titleLabel.bounds.size.width -WYmargin*2-WYmargin2)];//图片距离右边框距离减少图片的宽度，其它不边
        
    }
    _image = YES;
    
    _titleLabel.text =model.topicTitle;



}



@end
