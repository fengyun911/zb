//
//  BankCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/15.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "BankCell.h"
@interface BankCell()
@property(nonatomic,weak)UIImageView *bgImageView;
@property(nonatomic,weak)UIImageView *logo;
@property(nonatomic,weak)UILabel *title;
@property(nonatomic,weak)UILabel *content;
@property(nonatomic,weak)UILabel *numbers;
@end
@implementation BankCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"BankCell";
    
    BankCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[BankCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
//    @property(nonatomic,weak)UIImageView *bgImageView;
//    @property(nonatomic,weak)UIImageView *logo;
//    @property(nonatomic,weak)UILabel *title;
//    @property(nonatomic,weak)UILabel *content;
//    @property(nonatomic,weak)UILabel *numbers;
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图层-1"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImageView = bgImageView;
    bgImageView.layer.cornerRadius = 5;
    [bgImageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:bgImageView];
    bgImageView.sd_layout.topSpaceToView(self.contentView,WYmargin).leftSpaceToView(self.contentView,WYmargin).rightSpaceToView(self.contentView,WYmargin).bottomSpaceToView(self.contentView,0);
    
}

@end
