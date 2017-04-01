//
//  CommentThreeCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/3.
//  Copyright © 2017年 yyxc. All rights reserved.
//  评论的cell小距离

#import <UIKit/UIKit.h>
#import "perToppicListModel.h"
@interface CommentThreeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)perToppicListModel *model;
@end
