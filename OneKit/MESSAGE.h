//
//  MESSAGE.h
//  OneKit
//
//  Created by 张瑾 on 15/6/30.
//  Copyright (c) 2015年 visitors. All rights reserved.
//
#import <Foundation/Foundation.h>
//#import "OneKit.h"
/**
 *  消息
 */
@interface MESSAGE : NSObject
/**
 *  发送消息
 *
 *  @param message 消息名称
 *  @param data    信息
 */
+ (void)sendMessage:(NSString*)message data:(NSDictionary*)data;
+ (void)sendMessage:(NSString*)message target:(id)target data:(NSDictionary*)data;
/**
 *  接受消息
 *
 *  @param message  消息名称
 *  @param callback 回调函数
 */
+ (void)receiveMessage:(NSString*)message callback:(void (^)(NSDictionary* data))callback;
+ (void)receiveMessage:(NSString*)message target:(id)target callback:(void (^)(NSDictionary* data))callback;
@end
