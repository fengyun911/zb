//
//  CrowdfundingListViewController.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/31.
//  Copyright © 2017年 yyxc. All rights reserved.
//==============众筹列表的控制器=====================//

#import "BaseViewController.h"

@interface CrowdfundingListViewController : BaseViewController
//请求的列表数据
@property(nonatomic,strong)NSDictionary *dict;
//记录是直播还是众筹
@property(nonatomic,assign)BOOL isState;
@end
