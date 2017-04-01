//
//  EventCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
// 活动详情的cell

#import <UIKit/UIKit.h>
#import "liveDetailModel.h"
@interface EventCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)liveDetailModel *model;
@end
