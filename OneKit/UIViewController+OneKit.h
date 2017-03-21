//
//  UIViewController+OneKit.h
//  OneKit
//
//  Created by 张瑾 on 15/6/30.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(OneKit)
+ (UIViewController*)current;
- (void)callback:(dispatch_block_t)callback;
@end
