//
//  JSON.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/2.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
//#import "OneKit.h"
/**
 *  JSON
 */
@interface JSON : NSObject

/**
 *  用字符串实例化JSON对象
 *
 *  @param string 字符串
 *
 *  @return JSON对象
 */
+ (id)parse:(NSString *)string;

/**
 *  JSON对象转换为字符串
 *
 *  @param json JSON对象
 *
 *  @return 字符串
 */
+ (NSString *)stringify:(id)json;
@end
