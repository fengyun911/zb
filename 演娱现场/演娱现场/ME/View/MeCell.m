//
//  MeCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/6.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "MeCell.h"
#import "UIImageView+WebCache.h"
@interface MeCell()
//头像
@property(nonatomic,weak)UIImageView *photoImageView;
//标题
@property(nonatomic,weak)UILabel *title;
//内容
@property(nonatomic,weak)UILabel *text;
//右边按钮
@property(nonatomic,weak)WyBut *rightBut;
//背景view
@property(nonatomic,weak)UIView *bgView;
@end
@implementation MeCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"MeCell";
    
    MeCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[MeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =  [UIColor colorWithHexString:@"252525"];
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
    
    UIView *bgView = [[UIView alloc]init];
    _bgView = bgView;
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = MENR;
    bgView.sd_layout.leftSpaceToView(self.contentView,WYmargin).topEqualToView(self.contentView).rightSpaceToView(self.contentView,WYmargin).bottomEqualToView(self.contentView);
    //头像
    UIImageView *photoImageView = [[UIImageView alloc]init];
    [bgView addSubview:photoImageView];
    
    [photoImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"] placeholderImage:nil];
    photoImageView.sd_layout.leftSpaceToView(bgView,WYmargin*1.5).topSpaceToView(bgView,WYmargin).widthIs(64).heightIs(64);
    // 设置圆角的大小
    photoImageView.layer.cornerRadius = photoImageView.width/2;
    [photoImageView.layer setMasksToBounds:YES];
    //设置标题
    UILabel *title = [[UILabel alloc]init];
    [bgView addSubview:title];
    title.font = Font16;
    title.textColor = [UIColor colorWithHexString:@"ffffff"];
    title.text = @"wangyang";
    title.sd_layout.leftSpaceToView(photoImageView,WYmargin*1.5).topEqualToView(photoImageView).widthIs(150).heightIs(photoImageView.height/2);
    
    //设置内容
    UILabel *text = [[UILabel alloc]init];
    [bgView addSubview:text];
    text.font = Font14;
    text.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    text.text = @"个人信息:银行卡,会员";
    text.sd_layout.leftSpaceToView(photoImageView,WYmargin*1.5).topSpaceToView(title,0).widthIs(150).heightIs(photoImageView.height/2);
    
    //设置右边按钮
    WyBut *rightBut = [[WyBut alloc]init];
    [bgView addSubview:rightBut];
    [rightBut setImage:[UIImage imageNamed:@"下一页-拷贝-3"] forState:UIControlStateNormal];
    rightBut.sd_layout.rightEqualToView(bgView).topEqualToView(bgView).bottomEqualToView(bgView).widthIs(64);
}
@end
