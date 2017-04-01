//
//  TopicCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/3.
//  Copyright © 2017年 yyxc. All rights reserved.
//  互动话题

#import <UIKit/UIKit.h>
#import "commentListModel.h"
@interface TopicCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)commentListModel *model;
@end
