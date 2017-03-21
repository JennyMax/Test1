//
//  NSDate+OneKit.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/4.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "NSDate+OneKit.h"
//#import "OneKit.h"
@implementation NSDate(OneKit)
+ (void)init
{
    //[OneKit init];
}
+ (NSDate *)parseWithString:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:FORMAT];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

- (NSString *)toString{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:FORMAT];
    return [dateFormat stringFromDate:self];
}

-(NSString *)formatWithString:(NSString *)format{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:self];
}

@end
