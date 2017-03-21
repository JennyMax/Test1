//
//  COLOR.h
//  OneKit
//
//  Created by HeYanTao on 15/9/28.
//  Copyright © 2015年 张瑾. All rights reserved.
//

//#import "OneKit.h"
/**
 *  颜色转换
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface COLOR : NSObject
/**
 *  字符串转颜色
 *
 *  @param str 16进制颜色
 *
 *  @return UIcolor
 */
+(UIColor*)parse:(NSString*)str;
/**
 *  颜色转字符串
 *
 *  @param color UIcolor
 *
 *  @return 字符串
 */
+(NSString*)toString:(UIColor*)color;
@end
