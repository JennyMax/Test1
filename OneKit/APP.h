//
//  APP.h
//  OneKit
//
//  Created by 张瑾 on 15/6/30.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

//#import "OneKit.h"
#import <MessageUI/MessageUI.h>
/**
 *  本程序
 */
@interface APP : NSObject
/**
 *  返回appID
 */
+ (NSString*)appID;
/**
 *  发邮件
 *
 *  @param email 邮件信息
 */
+ (void)openEmail:(NSString*)email;
/**
 *  打开浏览器
 *
 *  @param url 地址
 */
+ (void)openUrl:(NSString*)url;
/**
 *  打电话
 *
 *  @param number 电话号码
 */
+ (void)callPhone:(NSString*)number;
/**
 *  发短信
 *
 *  @param sms            短信内容
 *  @param number         电话号码
 *  @param viewController 当前的viewController
 */
+ (void)sendSMS:(NSString*)sms
         number:(NSString*)number
 viewController:(UIViewController<MFMessageComposeViewControllerDelegate>*)viewController;
+ (NSString*)version;


@end
