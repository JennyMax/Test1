//
//  UILabel+OneKit.m
//  Ecen
//
//  Created by 张 瑾 on 14-4-10.
//  Copyright (c) 2014年 zhangjin. All rights reserved.
//
//#import "OneKit.h"
#import "UILabel+OneKit.h"
#import "NSString+OneKit.h"
@implementation UILabel (OneKit)
- (CGSize)autoSize
{
    NSString* text = self.text;
    if([NSString isEmpty:text]){
        return self.frame.size;
    }
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}
@end
