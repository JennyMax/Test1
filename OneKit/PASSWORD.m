//
//  PASSWORD.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "PASSWORD.h"
//#import "OneKit.h"

@implementation PASSWORD
+ (void)init
{
    //[OneKit init];
}
+ (NSString *)md5:(NSString *)text
{
    [self  init];
    const char *original_str = [text UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (uint)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
+ (NSString *)sha1:(NSString *)text
{
    [self  init];
    const char *cstr = [text cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:text.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (uint)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}
//+ (NSString *) sha1_base64:(NSString *)text
//{
//    const char *cstr = [text cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:text.length];
//    
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    
//    CC_SHA1(data.bytes, data.length, digest);
//    
//    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
//    base64 = [GTMBase64 encodeData:base64];
//    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
//    return output;
//}
@end
