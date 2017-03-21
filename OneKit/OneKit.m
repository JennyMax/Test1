//
//  Utility.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/6.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//
#import "OneKit.h"
@implementation OneKit
static BOOL checking = false;
//static NSDate *expire = nil;

+ (void)init
{
    if(checking){
        return;
    }
    checking = TRUE;
    /*NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDict[(NSString*)kCFBundleIdentifierKey];
    NSURL* url = [NSURL URLWithString:format(@"http://www.onekit.cn/app/%@.txt",appID)];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             if(connectionError){
                 
                 //[DIALOG alert:connectionError.description callback:^{
                    // [APP openUrl:@"http://www.onekit.cn"];
                     //exit(0);
                 //}];
                 return;
             }
             checking = FALSE;
             NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             if(isEmpty(string)){
                 [DIALOG alert:@"OneKit无效，请到www.onekit.cn购买正版。" callback:^{
                     [APP openUrl:@"http://www.onekit.cn"];
                     exit(0);
                 }];
                 return;
             }
             NSDate *expire = [NSDate parseWithString:string];
             if (isNull(expire)) {
                 [DIALOG alert:@"有效期无效，请到www.onekit.cn购买正版。" callback:^{
                     [APP openUrl:@"http://www.onekit.cn"];
                     exit(0);
                 }];
                 return;

             }
             NSDate* now = [NSDate date];
             if([now timeIntervalSinceDate:expire]>0){
                 [DIALOG alert:@"OneKit过期，请到www.onekit.cn续费。" callback:^{
                     [APP openUrl:@"http://www.onekit.cn"];
                     exit(0);
                 }];
                 return;
             }
            // [self init];
         }];
     
     
     return;
     */
    }
    /**/

/*
+ (id)invokeClassWithClass:(Class)cls object:(id)object method:(SEL)method arguments:(NSArray*)arguments
{
    NSMethodSignature *methodSignature = [cls instanceMethodSignatureForSelector:method];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = object;
    invocation.selector = method;
    for(int i=0;i<arguments.count;i++){
        id argument = arguments[i];
        [invocation setArgument:&argument atIndex:(i+2)];
    }
    [invocation retainArguments];
    [invocation invoke];
    const char *returnType = methodSignature.methodReturnType;
    id RESULT;
    if(!strcmp(returnType, @encode(void))){
        RESULT = nil;
    }else if(!strcmp(returnType, @encode(id))){
        [invocation getReturnValue:&RESULT];
    }else{
        RESULT = nil;
    }
    return RESULT;
}

+ (id)invokeClassWithClass:(Class)class method:(SEL)method arguments:(NSArray*)arguments
{
    return [self invokeClassWithClass:class object:nil method:method arguments:arguments];
}

+ (id)invokeObjectWithObject:(id)object method:(SEL)method arguments:(NSArray*)arguments
{
    return [self invokeClassWithClass:[object class] object:object method:method arguments:arguments];
}
*/
@end
