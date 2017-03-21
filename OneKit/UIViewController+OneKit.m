//
//  UIViewController+OneKit.m
//  OneKit
//
//  Created by 张瑾 on 15/6/30.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

#import "UIViewController+OneKit.h"

@implementation UIViewController(OneKit)
+ (UIViewController*)current
{
    UIViewController *result;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}
- (void)callback:(dispatch_block_t)callback
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue,callback);
}
@end
