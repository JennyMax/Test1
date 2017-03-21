//
//  NSString+OneKit.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/4.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "NSString+OneKit.h"
#import "Macro.h"

@implementation NSString(OneKit)
+ (void)init
{
    //[OneKit init];
}
+ (BOOL)isEmpty:(NSString*)str
{
    if (isNull(str)) {
        return TRUE;
    }
    if([str isEqualToString:@""]){
        return TRUE;
    }
    return FALSE;
}

+ (NSString *)newGUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}
+ (NSString*)fill:(NSInteger)value length:(NSInteger)length
{
    NSString* RESULT = [NSString stringWithFormat:@"%ld",(long)value];
    while (RESULT.length<length) {
        RESULT = [NSString stringWithFormat:@"0%@",RESULT];
    }
    return RESULT;
}
- (NSString*)trim
{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSInteger)indexOf:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return range.location;
}

- (BOOL)contains:(NSString *)string
{
    return !([self indexOf:string]==NSNotFound);
}

- (BOOL)startWith:(NSString *)string
{
    return ([self indexOf:string]==0);
}

- (BOOL)endWith:(NSString *)string
{
    return ([self indexOf:string] == self.length - string.length);
}

- (NSString*)replace:(NSString *)target to:(NSString*)to
{
    return [self stringByReplacingOccurrencesOfString:target withString:to];
}

- (NSArray*)split:(NSString *)split
{
    return [self componentsSeparatedByString:split];
}

- (NSString *)URLEncode
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,    (CFStringRef)self,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    return result;
}

- (CGSize)sizeWithSize:(CGSize)size font:(UIFont*)font
{
    return [self boundingRectWithSize:size
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}

@end
