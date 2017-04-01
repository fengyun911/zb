//
//  TitleCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/7.
//  Copyright © 2017年 yyxc. All rights reserved.
//  内容的cell

#import <UIKit/UIKit.h>

@interface TitleCell : UITableViewCell
@property(nonatomic,weak)UILabel *title;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
