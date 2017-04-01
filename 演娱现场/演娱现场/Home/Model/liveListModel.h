//
//  liveListModel.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/15.
//  Copyright © 2017年 yyxc. All rights reserved.
//  直播的模型

#import <Foundation/Foundation.h>

@interface liveListModel : NSObject
//liveId: 65,
//title: "张学友-饿狼传说",
//imgUrl: "",
//type: "1",
//liveURL: "",
//remainTime: "",
//followSize: 0
@property(nonatomic,copy)NSString *liveId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *liveURL;
@property(nonatomic,copy)NSString *remainTime;
@property(nonatomic,copy)NSString *followSize;
@end
