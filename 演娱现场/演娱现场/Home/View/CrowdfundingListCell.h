//
//  CrowdfundingListCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/4/1.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "liveListModel.h"
@interface CrowdfundingListCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,weak)liveListModel *model;
@end
