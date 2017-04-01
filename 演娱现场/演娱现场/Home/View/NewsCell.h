//
//  NewsCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/2/24.
//  Copyright © 2017年 yyxc. All rights reserved.
//  直播资讯的cell

#import <UIKit/UIKit.h>
#import "liveListModel.h"
@interface NewsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setupView:(NSMutableArray *)array;
@end
