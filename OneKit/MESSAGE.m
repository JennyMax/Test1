//
//  MESSAGE.m
//  OneKit
//
//  Created by 张瑾 on 15/6/30.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

#import "MESSAGE.h"

@implementation MESSAGE
+ (void)init
{
    //[OneKit init];
}
+ (void)sendMessage:(NSString*)message target:(id)target data:(NSDictionary*)data
{
    [self init];
    [[NSNotificationCenter defaultCenter] postNotificationName:message object:target userInfo:data];
}
+ (void)sendMessage:(NSString*)message data:(NSDictionary*)data
{
    [MESSAGE sendMessage:message target:nil data:data];
}
+ (void)receiveMessage:(NSString*)message target:(id)target callback:(void (^)(NSDictionary* data))callback
{
    [self init];
    [[NSNotificationCenter defaultCenter] addObserverForName:message object:target queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        callback(note.userInfo);
    }];
}
+ (void)receiveMessage:(NSString*)message callback:(void (^)(NSDictionary* data))callback
{
    [MESSAGE receiveMessage:message target:nil callback:callback];
}
@end
