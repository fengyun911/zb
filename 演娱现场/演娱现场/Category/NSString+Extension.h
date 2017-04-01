//
//  NSString+Extension.h
//  汪洋微博
//
//  Created by 汪洋 on 15/6/6.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
/** 计算字体大小和换行需要最大换行距离*/
- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat)maxW;
/** 计算字体大小和换行*/
- (CGSize)sizeWithText:(UIFont *)font;

/**
 *  计算当前文件\文件夹的内容大小
 */
- (NSInteger)fileSize;
/**
 *  判断手机号
 */
- (BOOL)isPhoneNumber;
/**
 *  判断手机号
 */
- (BOOL)validateMobile:(NSString *)mobileNum;
/**
 *  判断邮箱
 */
-(BOOL)isEmailWithString:(NSString *)str;

-(BOOL)isGloabelNumberWithString:(NSString *)str;

/**
 返回处理过的字符串，只保留小数点后两位，结尾0省略
 */
- (instancetype)dealedPriceString;
/**
 *  判断字符串是否为空
 */
+ (BOOL) isBlankString:(NSString *)string;
/**
 * 判断中文和英文字符串的长度
 */
- (int)convertToInt:(NSString*)strtemp;
/**
 * 判断显示的汉字和英文
 */
- (BOOL)isValidateName:(NSString *)name;
/**
 * json转字段和数组
 */
-(id)JSONValue;
@end
