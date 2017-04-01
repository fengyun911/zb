//
//  CommentTwoCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/1.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "CommentTwoCell.h"
#import "UIImageView+WebCache.h"
@interface CommentTwoCell()
@property(nonatomic,weak)UILabel *leftTextLabel;
@property(nonatomic,weak)UILabel *leftTitleLabel;
@property(nonatomic,weak)UIImageView *leftBotoomImage;
@property(nonatomic,weak)UIButton *leftBotoomBut;
@property(nonatomic,weak)UIImageView *rightImage1;
@property(nonatomic,weak)UIImageView *rightImage2;
@property(nonatomic,weak)UIImageView *rightImage3;
@property(nonatomic,weak)UILabel *rightTextLabel;
@property(nonatomic,weak)UILabel *rightTitleLabel;
@property(nonatomic,weak)UIView *leftView;
@property(nonatomic,weak)UIView *rightView;
@end
@implementation CommentTwoCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CommentTwoCell";
    
    CommentTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[CommentTwoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
   
    //设置左面的数据
    UIView *leftView = [[UIView alloc]init];
    _leftView = leftView;
    leftView.backgroundColor = HOMECELLBG;
    [self.contentView addSubview:leftView];
    leftView.sd_layout.topSpaceToView(self.contentView,0).leftEqualToView(self.contentView).widthIs(ScreenWidth/2-WYmargin/4).heightIs(ScreenWidth*0.618);
    
    UIImageView *leftBotoomImage = [[UIImageView alloc]init];
    _leftBotoomImage = leftBotoomImage;
    [leftView addSubview:leftBotoomImage];
    leftBotoomImage.sd_layout.bottomEqualToView(leftView).leftEqualToView(leftView).widthRatioToView(leftView,0.25).heightRatioToView(leftView,0.25);
    [leftBotoomImage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489748398393&di=f89b9db9237469894688de6bfaa4207c&imgtype=0&src=http%3A%2F%2Fimg.popoho.com%2Fallimg%2F141016%2F1411131M3-22.jpg"] placeholderImage:nil];
    WyBut *leftBotoomBut = [[WyBut alloc]init];
    _leftBotoomBut = leftBotoomBut;
    [leftView addSubview:leftBotoomBut];
    [leftBotoomBut setImage:[UIImage imageNamed:@"点赞-拷贝"] forState:UIControlStateNormal];
    leftBotoomBut.backgroundColor = [UIColor colorWithHexString:@"01fffd"];
    leftBotoomBut.titleLabel.font = Font18;
    [leftBotoomBut setTitle:@" 9999" forState:UIControlStateNormal];
    [leftBotoomBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBotoomBut.sd_layout.leftSpaceToView(leftBotoomImage,2).rightSpaceToView(leftView,0).bottomEqualToView(leftView).heightRatioToView(leftBotoomImage,1);
    
   //设置文字
    UILabel *leftTitleLabel = [[UILabel alloc]init];
    leftTitleLabel.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _leftTitleLabel = leftTitleLabel;
        leftTitleLabel.text = @"主持人:曼妥思好心情";
        leftTitleLabel.textAlignment = NSTextAlignmentCenter;
        _leftTitleLabel = leftTitleLabel;
        [leftView addSubview:leftTitleLabel];
        leftTitleLabel.font = Font16;
        leftTitleLabel.textColor = [UIColor colorWithHexString:@"7b7b7b"];
    leftTitleLabel.sd_layout.topEqualToView(leftView).rightEqualToView(leftView).bottomSpaceToView(leftBotoomImage,2).heightRatioToView(leftBotoomImage,0.6);
    
    //设置内容
    UIView *leftTextLabelView = [[UIView alloc]init];
    [leftView addSubview:leftTextLabelView];
    leftTextLabelView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    leftTextLabelView.sd_layout.topEqualToView(leftView).rightEqualToView(leftView).bottomSpaceToView(leftTitleLabel,-1).leftEqualToView(leftView);
    
    UILabel *leftTextLabel = [[UILabel alloc]init];
    leftTextLabel.textAlignment = NSTextAlignmentCenter;
    leftTextLabel.numberOfLines = 3;
    leftTextLabel.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    leftTextLabel.text = @"BAT要国际化何不花500万买￥买30S超级碗广告?";
    [leftTextLabelView addSubview:leftTextLabel];
    _leftTextLabel = leftTextLabel;
    leftTextLabel.font = CFont20;
    leftTextLabel.textColor = [UIColor colorWithHexString:@"040404"];
    leftTextLabel.sd_layout.topSpaceToView(leftTextLabelView,WYmargin).rightSpaceToView(leftTextLabelView,WYmargin).rightEqualToView(leftTextLabelView).bottomEqualToView(leftTextLabelView);
    
    
    
    
    //设置右边的数据
    UIView *rightView = [[UIView alloc]init];
    _rightView = rightView;
    rightView.backgroundColor = HOMECELLBG;
    [self.contentView addSubview:rightView];
    rightView.sd_layout.topSpaceToView(self.contentView,0).rightEqualToView(self.contentView).widthIs(ScreenWidth/2-WYmargin/4).heightIs(ScreenWidth*0.618);
    
    
    
    UIImageView *rightImage1 = [[UIImageView alloc]init];
    _rightImage1 = rightImage1;
    [rightView addSubview:rightImage1];
    rightImage1.sd_layout.topEqualToView(rightView).leftEqualToView(rightView).widthRatioToView(rightView,0.45).heightRatioToView(rightView,0.25);
    [rightImage1 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1489740363&di=a6599250ca6084b84355747cddc9e708&src=http://m1.sinaimg.cn/maxwidth.2880/m1.sinaimg.cn/52c14c25fb77be858ca6dbadc442b23a_626_347.jpg"] placeholderImage:nil];
    
    UIImageView *rightImage2 = [[UIImageView alloc]init];
    _rightImage2 = rightImage2;
    [rightView addSubview:rightImage2];
    [rightImage2 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1489750953472&di=7db41e53e962bb7f9285e0d5e29322c5&imgtype=0&src=http%3A%2F%2Fimg.taopic.com%2Fuploads%2Fallimg%2F130919%2F240424-13091Z9321147.jpg"] placeholderImage:nil];
    
    
    
    UIImageView *rightImage3 = [[UIImageView alloc]init];
    _rightImage3 = rightImage3;
    [rightView addSubview:rightImage3];
    [rightImage3 sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3128273613,1704413661&fm=23&gp=0.jpg"] placeholderImage:nil];
    
    
    rightImage3.sd_layout.topEqualToView(rightView).rightEqualToView(rightView).heightRatioToView(rightView,0.25).leftSpaceToView(rightImage2,2).widthRatioToView(rightView,0.26);
    
    rightImage2.sd_layout.topEqualToView(rightView).leftSpaceToView(rightImage1,2).heightRatioToView(rightView,0.25).rightSpaceToView(rightImage3,2);
    //右边的文字
    UILabel *rightTitleLabel = [[UILabel alloc]init];
    rightTitleLabel.backgroundColor = [UIColor whiteColor];
    _rightTitleLabel = rightTitleLabel;
    rightTitleLabel.text = @"特邀嘉宾:Sean Zha";
    rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    _rightTitleLabel = leftTitleLabel;
    [rightView addSubview:rightTitleLabel];
    rightTitleLabel.font = Font16;
    rightTitleLabel.textColor = [UIColor colorWithHexString:@"7b7b7b"];
    rightTitleLabel.sd_layout.topSpaceToView(rightImage1,0).rightEqualToView(rightView).heightRatioToView(rightImage2,0.6).leftEqualToView(rightView);
    
    UIView *rightTextLabelView = [[UIView alloc]init];
    [rightView addSubview:rightTextLabelView];
    rightTextLabelView.backgroundColor = [UIColor whiteColor];
    rightTextLabelView.sd_layout.topSpaceToView(rightTitleLabel,-1  ).rightEqualToView(rightView).leftEqualToView(rightView).bottomEqualToView(rightView);
    
    UILabel *rightTextLabel = [[UILabel alloc]init];
    rightTextLabel.textAlignment = NSTextAlignmentCenter;
    rightTextLabel.numberOfLines = 3;
    rightTextLabel.backgroundColor = [UIColor whiteColor];
    rightTextLabel.text = @"美国超级碗真如央视说的那样,被中国春晚秒杀吗?";
    [rightTextLabelView addSubview:rightTextLabel];
    _rightTextLabel = rightTextLabel;
    rightTextLabel.font = CFont20;
    rightTextLabel.textColor = [UIColor colorWithHexString:@"040404"];
    rightTextLabel.sd_layout.topSpaceToView(rightTextLabelView,-1).rightSpaceToView(rightTextLabelView,WYmargin).leftSpaceToView(rightTextLabelView,WYmargin).bottomEqualToView(rightTextLabelView);
    [self setupAutoHeightWithBottomView:leftView bottomMargin:2];
}
#pragma mark --------设置view
- (void)setupView{
    [self setupCell];
}
@end
