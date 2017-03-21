//
//  JSON.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/2.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "JSON.h"
#import "Macro.h"

@implementation JSON
+ (void)init
{
    //[OneKit init];
}
+ (id)parse:(NSString *)string
{
    [self init];
    if (isNull(string)) {
        NSLog(@"[OneKit-JSON-parse]:json string is null.");
        return nil;
    }
    
    NSData *stringData;
    NSError *error;
    stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    id result = [NSJSONSerialization JSONObjectWithData:stringData options:kNilOptions error:&error];
    if (notNull(error)) {
        NSLog(@"[OneKit-JSON-parse]:parse error");
        return nil;
    }
    return result;
}

+ (NSString *)stringify:(id)json
{
    [self init];
    if (isNull(json)) {
        NSLog(@"[OneKit-JSON-stringify]:json object is null.");
        return nil;
    }
    
    if (![NSJSONSerialization isValidJSONObject:json]) {
        NSLog(@"[OneKit-JSON-stringify]:json object is invalid");
        return nil;
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
    if (notNull(error)) {
        NSLog(@"[OneKit-JSON-stringify]:stringify error");
        return nil;
    }
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

@end
