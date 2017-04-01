//
//  UIBarButtonItem+Extension.h
//  汪洋微博
//
//  Created by 汪洋 on 15/5/26.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString*)hihaImage;
@end
