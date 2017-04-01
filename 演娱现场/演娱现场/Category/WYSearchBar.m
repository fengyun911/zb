//
//  WYSearchBar.m
//  汪洋微博
//
//  Created by 汪洋 on 15/5/26.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "WYSearchBar.h"

@implementation WYSearchBar


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置输入框背景
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.textColor = [UIColor whiteColor];
        self.tintColor = [UIColor whiteColor];
        //输入框尺寸
        self.width = ScreenWidth - 100;
        self.height = 40;
        //输入框文字大小
        self.font = [UIFont systemFontOfSize:16];
        //设置输入框左面的图片
        UIImageView * SearchBarIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索栏-搜索"]];
        self.leftView = SearchBarIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //设置图片的大小
        SearchBarIcon.width = 40;
        SearchBarIcon.height = 40;
        
        //设置图片居中
        SearchBarIcon.contentMode = UIViewContentModeCenter;
        
       
        
    }
    return self;
}
+(instancetype)SearchBar{

    
    return [[self alloc]init];
}

@end
