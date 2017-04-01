//
//  RecommendCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//  推荐的cell

#import <UIKit/UIKit.h>

@interface RecommendCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setupView:(NSMutableArray *)array;
@end
