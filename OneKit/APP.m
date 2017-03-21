//
//  APP.m
//  OneKit
//
//  Created by 张瑾 on 15/6/30.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

#import "APP.h"
#import "Macro.h"
#import "DIALOG.h"
@implementation APP
+ (void)init
{
    //[OneKit init];
}
+ (NSString*)appID
{
    [self init];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return infoDict[(NSString*)kCFBundleIdentifierKey];
}
+ (void)openEmail:(NSString*)email
{
    [self init];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:email]];
}
+ (void)openUrl:(NSString*)url
{
    [self init];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (void)callPhone:(NSString *)number
{
    [self init];
    if(isNull(number)){
        return;
    }
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
    {
        [DIALOG alert:@"您的设备不能拨打电话。"];
        return;
    }
    NSString* str = [NSString stringWithFormat:@"telprompt:%@", number];
    NSURL* url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}
     
+ (void)sendSMS:(NSString *)sms
         number:(NSString *)number
 viewController:(UIViewController<MFMessageComposeViewControllerDelegate> *)viewController
{
    [self init];
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = viewController;
            picker.recipients = @[number];
            picker.body = sms;
            viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [viewController presentViewController:picker animated:YES completion:nil];
            //[viewController dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            NSLog(@"[OneKit-DEVICE-sendSMS]:DEVICE does not have text messaging capabilities.");
            //设备没有短信功能
        }
    }
    else {
        NSLog(@"[OneKit-DEVICE-sendSMS]:iOS4.0 above is supported within the program to send text messages.");
        // iOS版本过低,iOS4.0以上才支持程序内发送短信
    }
}
+ (NSString*)version
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_ID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@\nVersion: %@\nBundle: %@",app_ID,app_Version,app_build];
}
@end
