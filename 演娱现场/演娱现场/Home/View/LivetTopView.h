//
//  LivetTopView.h
//  演娱现场
//
//  Created by 汪洋 on 2017/3/2.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LivetTopView;
@protocol LivetTopViewDelegate <NSObject>
@optional
/**
 返回按钮的代理方法
 */
- (void)LivetTopView:(LivetTopView *)LivetTopView returnButClick:(UIButton *)but;
/**
 弹幕按钮代理方法
 */
- (void)LivetTopView:(LivetTopView *)LivetTopView bulletScreenButClick:(UIButton *)but;
/**
 分享按钮代理方法
 */
- (void)LivetTopView:(LivetTopView *)LivetTopView shareButClick:(UIButton *)but;
@end

@interface LivetTopView : UIView
@property(nonatomic,weak)id<LivetTopViewDelegate> delegate;
@property(nonatomic,weak)UILabel *textLabel;
@property(nonatomic,weak)WyBut *bulletScreenBut;
@property(nonatomic,weak)WyBut *returnBut;
@property(nonatomic,weak)WyBut *shareBut;
@end
