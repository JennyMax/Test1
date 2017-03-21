//
//  CONFIG.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

//#import "OneKit.h"
/**
 *  配置
 */
#import <Foundation/Foundation.h>
@interface CONFIG : NSObject
/**
 *  设置配置
 *
 *  @param key   key
 *  @param value value
 */
+ (void)set:(NSString*)key
      value:(id)value;
/**
 *  获取配置
 *
 *  @param key key
 *
 *  @return 返回value
 */
+ (id)get:(NSString*)key;

@end
