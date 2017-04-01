//
//  NSString+LTMD5.h
//  folk
//
//  Created by 孙卫超 on 16/1/4.
//  Copyright © 2016年 luoteng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTMD5)

/**
 *计算NSData的MD5值
 */
+(NSString*)getMD5WithData:(NSData*)data;

/**
 *  计算字符串的MD5值
 */
+(NSString*)getmd5WithString:(NSString*)string;

/**
 *  计算大文件的MD5值
 */
+(NSString*)getFileMD5WithPath:(NSString*)path;
@end
