//
//  crowdListModel.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/15.
//  Copyright © 2017年 yyxc. All rights reserved.
//  众筹的模型

#import <Foundation/Foundation.h>

@interface crowdListModel : NSObject
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *crowdId;
@property(nonatomic,copy)NSString *title1;
@property(nonatomic,copy)NSString *title2;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *collectSize;
@property(nonatomic,copy)NSString *followSize;
@property(nonatomic,copy)NSString *curCapital;
@property(nonatomic,copy)NSString *allCapital;
@property(nonatomic,copy)NSString *complRate;
@end
