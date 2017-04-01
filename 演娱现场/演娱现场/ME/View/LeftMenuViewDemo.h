//
//  LeftMenuViewDemo.h
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.
//
 
#import <UIKit/UIKit.h>


@protocol HomeMenuViewDelegate <NSObject>

-(void)LeftMenuViewClick:(NSIndexPath *)indexPath;

@end

@interface LeftMenuViewDemo : UIView

@property (nonatomic ,weak)id <HomeMenuViewDelegate> customDelegate;
//侧边栏众筹
@property(nonatomic,strong)NSMutableArray *leftCrowdList;
//侧边栏直播
@property(nonatomic,strong)NSMutableArray *leftLiveList;
- (void)makeData;

@end
