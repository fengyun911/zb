//
//  bannerListModel.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/15.
//  Copyright © 2017年 yyxc. All rights reserved.
//  轮播图的模型

#import <Foundation/Foundation.h>

@interface bannerListModel : NSObject
//imgUrl: "pictrueImages\201703131543918lxy_&话剧现场 (1).jpg",
//type: 1,
//relationId: "20"
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *relationId;
@end
