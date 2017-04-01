//
//  commentListModel.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/27.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentListModel : NSObject
@property(nonatomic,copy)NSString *cId;
@property(nonatomic,copy)NSString *cName;
@property(nonatomic,copy)NSString *cDate;
@property(nonatomic,copy)NSString *cContent;
@property(nonatomic,copy)NSString *agreeSize;
@end
