//
//  NSArray+OneKit.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/4.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (OneKit)

/**
 *  转换为字符串 每个元素之间用'|'隔开
 *
 *  @return 结果
 */
- (NSString*)toString;

/**
 *  转换为字符串
 *
 *  @param split 用来隔开的字符
 *
 *  @return 结果
 */
- (NSString*)toStringWithSplit:(NSString*)split;

/**
 *  如果数组的某个元素是一个字典且该字典参数key的值和参数value相匹配则返回这个元素
 *
 *  @param value 值
 *  @param key   键
 *
 *  @return 相匹配的字典元素
 */
- (NSDictionary *)findItemWithValue:(NSObject*)value key:(NSString*)key;

/**
 *  如果数组的某个元素是字典且该字典参数key的值和参数object的参数key值相匹配则返回这个元素在数组中得位置
 *
 *  @param item object
 *  @param key  键
 *
 *  @return  元素的位置
 */
- (NSInteger)indexOfObjectWithItem:(id)item key:(NSString*)key;
@end
