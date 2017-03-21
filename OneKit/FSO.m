//
//  FSO.m
//  OneKit
//
//  Created by Visitors on 15/3/3.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

#import "FSO.h"
#import "JSON.h"
#import "Macro.h"
@implementation FSO
+ (void)init
{
    //[OneKit init];
}
+ (NSString*)getPathWithFileName:(NSString*)fileName
{
    [self init];
    //NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSLog(@"%@",directory);
    NSString* path = [[NSString alloc] initWithString:
                      [directory stringByAppendingPathComponent:fileName]];
//    NSError* err;
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    //检查文件目录是否有效
//    if(![fileManager fileExistsAtPath:path])
//    {
//        [fileManager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:&err];
//        if(err){
//            return nil;
//        }
//    }
    return path;
}

+ (BOOL)isEmpty:(NSString*)fileName
{
    [self init];
    NSString *path = [self getPathWithFileName:fileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    return ![fileManager fileExistsAtPath:path];
}

+ (NSData*)loadDataWithFileName:(NSString*)fileName
{
    [self init];
    NSString* path = [self getPathWithFileName:fileName];
    if(isNull(path)){
        return nil;
    }
    return [NSData dataWithContentsOfFile:path];
}

+ (BOOL)saveDataWithData:(NSData*)data fileName:(id)fileName
{
    [self init];
    NSString* path = [self getPathWithFileName:fileName];
    if(isNull(path)){
        return FALSE;
    }
    return [data writeToFile:path atomically:TRUE];
}

+ (BOOL)deleteDataWithFileName:(NSString *)fileName
{
    [self init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString* path = [[NSString alloc] initWithString:
                      [directory stringByAppendingPathComponent:fileName]];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:&error];
    }
    if (error) {
        return NO;
    }
    return YES;
}

+ (UIImage*)loadImageWithFileName:(NSString*)fileName
{
    [self init];
    //NSString* path = [self getPathWithFileName:fileName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString* path = [[NSString alloc] initWithString:
                      [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",fileName]]];
    return [UIImage imageWithContentsOfFile:path];
}
+(BOOL)saveImageWith:(UIImage*)image fileName:(NSString*)fileName
{
    [self init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString* path = [[NSString alloc] initWithString:
                      [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",fileName]]];
    //NSString *path = [self getPathWithFileName:fileName];
    NSData *data = UIImagePNGRepresentation(image);
    if(isNull(path)){
        return FALSE;
    }
    return [data writeToFile:path atomically:TRUE];
}
+ (NSString*)loadStringWithFileName:(NSString*)fileName ext:(NSString*)ext
{
    [self init];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    fileName = [[NSString alloc] initWithString:
                [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName,ext]]];
    NSString *string = [NSString stringWithContentsOfFile:fileName
                                                 encoding:NSUTF8StringEncoding
                                                    error:&error];
    if (error){
        return nil;
    }
    return string;
}

+ (NSString*)loadStringWithFileName:(NSString*)fileName
{
    [self init];
    return [self loadStringWithFileName:fileName ext:@"txt"];
}

+ (BOOL)saveStringWithString:(NSString*)string fileName:(NSString*)fileName ext:(NSString*)ext
{
    [self init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    fileName = [[NSString alloc] initWithString:
                [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName,ext]]];
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [string dataUsingEncoding:encoding];
    return [data writeToFile:fileName atomically:NO];
}

+ (BOOL)saveStringWithString:(NSString*)string fileName:(NSString*)fileName
{
    [self init];
    return [self saveStringWithString:string fileName:fileName ext:@"txt"];
}

+ (id)loadJSONWithFileName:(NSString*)fileName
{
    [self init];
    NSString *string = [self loadStringWithFileName:fileName ext:@"json"];
    if (isNull(string)){
        return nil;
    }
    return [JSON parse:string];
}

+ (BOOL)saveJSONWithJSON:(NSDictionary*)json fileName:(id)fileName
{
    [self init];
    NSString* string = [JSON stringify:json];
    if(isNull(string)){
        return FALSE;
    }
    return [self saveStringWithString:string fileName:fileName ext:@"json"];
}

+ (void)loadHtmlFileWithFileName:(NSString*)fileName webView:(UIWebView*)webView
{
    [self init];
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[[NSURL alloc]init]];
}
@end
