//
//  TopNavView.h
//  演娱现场
//
//  Created by 汪洋 on 2017/2/22.
//  Copyright © 2017年 yyxc. All rights reserved.
//  首页顶部的view

#import <UIKit/UIKit.h>
#import "WYSearchBar.h"
@class TopNavView;
@protocol TopNavViewDelegate <NSObject>
@optional
/**
 左边按钮的代理方法
 */
- (void)TopNavView:(TopNavView *)TopNavView didLeftButClick:(UIButton *)but;
/**
 右边按钮的代理方法
 */
- (void)TopNavView:(TopNavView *)TopNavView didRightButClick:(UIButton *)but;
/**
 搜索的代理方法
 */
- (void)TopNavView:(TopNavView *)TopNavView topSearchBarTextFieldShouldReturn:(UITextField *)textField;
@end
@interface TopNavView : UIView<UITextFieldDelegate>
/**
 代理方法属性
 */
@property(nonatomic,weak)id<TopNavViewDelegate> delegate;
@property(nonatomic,weak)WYSearchBar *searchBar;
//设置左面返回按钮
- (void)setupLeftBut:(NSString *)butStr;
@end
