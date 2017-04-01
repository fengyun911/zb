//
//  LiveTopCell.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "liveDetailModel.h"
@class LiveTopCell;

@protocol VideoDelegate <NSObject>

- (void)PlayVideoWithCell:(LiveTopCell *)cell;

@end
@interface LiveTopCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)liveDetailModel *model;

@property (nonatomic,weak) id <VideoDelegate>videoDelegate;


- (CGFloat)cellOffset;
@end
