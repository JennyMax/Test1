//
//  UI.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "UI.h"
#import "UIViewController+OneKit.h"
//#import "OneKit.h"
@implementation UI
+ (void)init
{
    //[OneKit init];
}
+ (id)loadNibNamed:(NSString *)name
{
    [self  init];
    return [UI loadNibNamed:name placeHolder:nil];
}

+ (id)loadNibNamed:(NSString *)name placeHolder:(UIView *)placeHolder
{
    [self  init];
    UIView* uc = [[NSBundle mainBundle] loadNibNamed:name owner:[UIViewController current] options:nil][0];
    if(placeHolder){
        CGRect frame = placeHolder.bounds;
        uc.frame = frame;
        [placeHolder addSubview:uc];
    }
    return uc;
}

@end
