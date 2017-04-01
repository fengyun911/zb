//
//  CommentOneCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/2/27.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "CommentOneCell.h"
#import "UIImageView+WebCache.h"
@interface CommentOneCell()
{
    BOOL _image;
}

@property(nonatomic,weak)UILabel *name;
@property(nonatomic,weak)UILabel *text;
@property(nonatomic,weak)UIImageView *rightImageView;
@property(nonatomic,weak)WyBut *botoomImageBut;
@property(nonatomic,weak)UILabel *botoomLabel;
@property(nonatomic,weak)UIView *bgView;
@end
@implementation CommentOneCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CommentOneCell";
    
    CommentOneCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[CommentOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    //设置右边的图片
    UIImageView *rightImageView = [[UIImageView alloc]init];
    _rightImageView = rightImageView;
    [self.contentView addSubview:rightImageView];
    rightImageView.sd_layout.rightEqualToView(self.contentView).topSpaceToView(self.contentView,1).widthIs(54).heightIs(54);
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"] placeholderImage:nil];
    //设置底部文字
    UILabel *botoomLabel = [[UILabel alloc]init];
    _botoomLabel = botoomLabel;
    [self.contentView addSubview:botoomLabel];
    botoomLabel.font = Font16;
    botoomLabel.textColor = [UIColor blackColor];
    botoomLabel.backgroundColor = [UIColor greenColor];
    botoomLabel.textAlignment = NSTextAlignmentCenter;
    botoomLabel.text = @"2802";
    botoomLabel.sd_layout.topSpaceToView(rightImageView,2).rightEqualToView(rightImageView).widthIs(54).heightIs(25);
    //设置底部的图片
    WyBut * botoomImageBut = [[WyBut alloc]init];
    [self.contentView addSubview:botoomImageBut];
    _botoomImageBut = botoomImageBut;
    botoomImageBut.titleLabel.textColor = [UIColor blackColor];
    botoomImageBut.titleLabel.font = Font10;
    botoomImageBut.backgroundColor = [UIColor greenColor];
    
    [botoomImageBut setImage:[UIImage imageNamed:@"点赞-拷贝"] forState:UIControlStateNormal];

    
    botoomImageBut.sd_layout.topSpaceToView(botoomLabel,0).rightEqualToView(rightImageView).widthIs(54).heightIs(27);
    
    if (_image == NO) {
//        //使图片和文字水平居中显示
//        [botoomImageBut setTitleEdgeInsets:UIEdgeInsetsMake(botoomImageBut.imageView.frame.size.height+WYmargin ,-botoomImageBut.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
     
        
    }
    _image = YES;
    
    
    //设置背景的view
    UIView *bgView = [[UIView alloc]init];
    _bgView = bgView;
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
   
    bgView.sd_layout.leftSpaceToView(self.contentView,1).topSpaceToView(self.contentView,1).rightSpaceToView(rightImageView,2).bottomEqualToView(botoomImageBut);
    //设置姓名
    UILabel *name = [[UILabel alloc]init];
    _name = name;
    [bgView addSubview:name];
    name.text = @"特邀嘉宾：菲利普斯";
    name.textColor = [UIColor colorWithHexString:@"7b7b7b"];
    name.sd_layout.leftSpaceToView(bgView,17.5).topSpaceToView(bgView,13.5).rightSpaceToView(bgView,3).heightIs(WYmargin*2);
    name.font = Font16;
    //设置内容
    UILabel *text = [[UILabel alloc]init];
    text.backgroundColor = [UIColor whiteColor];
    text.numberOfLines = 2;
    _text = text;
    [bgView addSubview:text];
    text.text = @"新浪网新闻中心是新浪网最重要的频道之一,24小时滚动报道";
    text.font = CFont20;
    text.textColor = [UIColor colorWithHexString:@"040404"];
    text.sd_layout.leftEqualToView(name).rightEqualToView(name).bottomEqualToView(bgView).topSpaceToView(name,0);
    
     [self setupAutoHeightWithBottomView:botoomImageBut bottomMargin:2];
}
#pragma mark --------设置view
- (void)setupView{
    [self setupCell];
}
@end
