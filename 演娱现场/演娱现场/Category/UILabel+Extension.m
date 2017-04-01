//
//  UILabel+Extension.m
//  演娱现场
//
//  Created by 汪洋 on 2017/3/9.
//  Copyright © 2017年 yyxc. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (CGFloat)getLabelW:(UIFont*)font text:(NSString *)text{
     NSDictionary *attrs = @{NSFontAttributeName : font};
     CGSize size= [text sizeWithAttributes:attrs];
     return size.width;
}
@end
