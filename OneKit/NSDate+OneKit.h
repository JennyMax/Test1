//
//  NSDate+OneKit.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/4.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#define FORMAT @"yyyy-MM-dd HH:mm:ss"
#import <Foundation/Foundation.h>

@interface NSDate(OneKit)

/**
 *  字符串转换为时间
 *
 *  @param string 呆转换的字符串
 *
 *  @return 结果
 */
+ (NSDate *) parseWithString: (NSString *)string;

/**
 *  转换为字符串
 *
 *  @return 结果
 */
- (NSString *)toString;

/**
 *  时间格式化为字符串
 *
 *  @param format format
 *
 *  @return 结果
 */
- (NSString *)formatWithString:(NSString *)format;
@end
