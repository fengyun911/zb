//
//  CommentCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/2/24.
//  Copyright © 2017年 yyxc. All rights reserved.
//  个人评论的cell

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setupView;
@end
