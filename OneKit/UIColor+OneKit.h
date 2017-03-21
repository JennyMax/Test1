//
//  UIColor+OneKit.h
//  Phone
//
//  Created by 张 瑾 on 13-7-4.
//  Copyright (c) 2013年 Edison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (OneKit)
//+ (UIColor*)colorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue Alpha:(NSInteger)alpha;
/**
 *  字符串转颜色
 *
 *  @param str 字符串
 *
 *  @return 结果
 */
+ (UIColor*)parse:(NSString*)str;
/**
 *  颜色转字符串
 *
 *  @return 结果
 */
- (NSString*)toString;
@end
