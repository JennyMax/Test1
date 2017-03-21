//
//  CONFIG.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "CONFIG.h"

@implementation CONFIG
+ (void)init
{
    //[OneKit init];
}
+(void)set:(NSString*)key value:(id)value
{
    [self init];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)get:(NSString*)key
{
    [self init];
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
