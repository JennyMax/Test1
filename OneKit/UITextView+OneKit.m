//
//  UITextView+OneKit.m
//  Ecen
//
//  Created by 张 瑾 on 14-4-10.
//  Copyright (c) 2014年 zhangjin. All rights reserved.
//
//#import "OneKit.h"
#import "UITextView+OneKit.h"
#import "NSString+OneKit.h"
@implementation UITextView (OneKit)
- (CGSize)autoSize
{
    NSString* str = self.text;
    if([NSString isEmpty:str]){
        return self.frame.size;
    }
    CGSize size = self.frame.size;
    UIFont* font = self.font;
    if(!font){
        self.font = font = [UIFont systemFontOfSize:12];
    }
    CGSize stringSize;
    //if(iOS7){
    stringSize = [str sizeWithSize:CGSizeMake(size.width-20, CGFLOAT_MAX) font:font];
    /*}else{
        stringSize = [str sizeWithFont:font constrainedToSize:CGSizeMake(size.width-20, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }*/
    CGRect frame = self.frame;
    //frame.size.width = stringSize.width+20;
    frame.size.height = stringSize.height+20;
    self.frame = frame;
    //
    return frame.size;
}
@end
