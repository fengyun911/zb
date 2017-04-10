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
//state: "",
//title1: "陈奕迅简介",
//title2: "",
//countDown: "",
//followSize: 2,
//collectSize: 2
//targetAmount : 5.0E7,
@property(nonatomic,copy)NSString *liveId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *liveURL;
@property(nonatomic,copy)NSString *remainTime;
@property(nonatomic,copy)NSString *title1;
@property(nonatomic,copy)NSString *title2;
@property(nonatomic,copy)NSString *countDown;
@property(nonatomic,copy)NSString *followSize;
@property(nonatomic,copy)NSString *collectSize;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *targetAmount;
@end
