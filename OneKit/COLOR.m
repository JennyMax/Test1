//
//  COLOR.m
//  OneKit
//
//  Created by HeYanTao on 15/9/28.
//  Copyright © 2015年 张瑾. All rights reserved.
//

#import "COLOR.h"
#import "MATH.h"
#import "UIColor+OneKit.h"
@implementation COLOR
+ (void)init
{
    //[OneKit init];
}
+(UIColor*)parse:(NSString*)str
{
    [self init];
    return [UIColor parse:str];
}
+(NSString*)toString:(UIColor*)color
{
    [self init];
    CGFloat red, green, blue, alpha;
    if(![color getRed:&red green:&green blue:&blue alpha:&alpha]){
        return @"";
    }
    return [NSString stringWithFormat:@"#%@%@%@",
            [MATH toHex:red*255],
            [MATH toHex:green*255],
            [MATH toHex:blue*255]];

}
@end
