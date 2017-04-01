//
//  TitleCell.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/7.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "TitleCell.h"
@interface TitleCell()
@end
@implementation TitleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"TitleCell";
    
    TitleCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell =  [[TitleCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    UILabel *title = [[UILabel alloc]init];
    [self.contentView addSubview:title];
    _title = title;
    title.font = Font18;
    title.textColor = [UIColor colorWithHexString:@"cdcdcd"];
    title.sd_layout.leftSpaceToView(self.contentView,WYmargin*3).topEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView);
    
}

@end
