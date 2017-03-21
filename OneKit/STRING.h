//
//  STRING.h
//  OneKit
//
//  Created by HeYanTao on 15/9/28.
//  Copyright © 2015年 张瑾. All rights reserved.
//
#import <Foundation/Foundation.h>

//#import "OneKit.h"
/**
 *  字符串
 */
@interface STRING : NSObject
/**
 *  判断是否为空
 *
 *  @param str 字符串
 *
 *  @return 判断结果
 */
+ (BOOL)isEmpty:(NSString*)str;
/**
 *  数组转字符串
 *
 *  @param array     数组
 *  @param seperator 分割标识
 *
 *  @return 结果
 */
+ (NSString *)toString:(NSArray *)array seperator:(NSString*)seperator;
/**
 *  字符串转数组
 *
 *  @param str       字符串
 *  @param seperator 分割标识
 *
 *  @return 结果
 */
+ (NSArray*)parse:(NSString*)str seperator:(NSString*)seperator;
@end
