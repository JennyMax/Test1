//
//  NSArray+OneKit.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/4.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "NSArray+OneKit.h"
//#import "OneKit.h"
@implementation NSArray (OneKit)
+ (void)init
{
    //[OneKit init];
}
- (NSString *)toString
{
    [NSString init];
    return [self toStringWithSplit:@"|"];
}

- (NSString *)toStringWithSplit:(NSString *)split
{
    [NSString init];
    NSString *result = @"";
    for (id item in self) {
        result = [result stringByAppendingFormat:@"%@%@",split,[item description]];
    }
    if (result.length > 0) {
        result = [result substringFromIndex:1];
    }
    return result;
}

- (NSDictionary *)findItemWithValue:(NSObject*)value key:(NSString*)key
{
    for (int i=0;i<[self count];i++) {
        NSDictionary* temp = self[i];
        if([value isEqual:temp[key]]){
            return temp;
        }
    }
    return nil;
}

- (NSInteger)indexOfObjectWithItem:(id)item key:(NSString*)key
{
    for (int i=0;i<[self count];i++) {
        NSDictionary* temp = self[i];
        if([item[key] isEqual:temp[key]]){
            return i;
        }
    }
    return -1;
}
@end
