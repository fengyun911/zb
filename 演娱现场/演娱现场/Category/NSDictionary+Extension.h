//
//  NSDictionary+Extension.h
//  folk
//
//  Created by 汪洋 on 15/11/9.
//  Copyright © 2015年 luoteng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
/**
 把格式化的JSON格式的字符串转换成字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
