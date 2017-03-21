//
//  DEVICE.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

//#import "OneKit.h"
#import <MessageUI/MessageUI.h>
/**
 *  设备参数
 */
@interface DEVICE : NSObject
/**
 *  获取设备ID
 *
 *  @return 返回设备ID
 */
+ (NSString*)ID;
/**
 *  查看CPU的使用率
 *
 *  @return 返回CPU的使用率
 */
+ (NSString*)CPU;
/**
 *  查看内存
 *
 *  @param isAll 是否查看所有内存
 *
 *  @return 返回内存
 */
+ (NSString*)Memroy:(BOOL)isAll;
/**
 *  查看磁盘
 *
 *  @param isAll 是否查看总磁盘大小
 *
 *  @return 返回磁盘状态
 */
+ (NSString*)SD:(BOOL)isAll;
/**
 *  查看网络
 *
 *  @return 返回当前使用网络
 */
+ (NSString*)NET;
@end
