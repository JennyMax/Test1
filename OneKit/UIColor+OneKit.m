//
//  UIColor+OneKit.m
//  Phone
//
//  Created by 张 瑾 on 13-7-4.
//  Copyright (c) 2013年 Edison. All rights reserved.
//

#import "UIColor+OneKit.h"
#import "MATH.h"
@implementation UIColor (OneKit)
+ (UIColor*)colorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue Alpha:(NSInteger)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}
+ (UIColor*)parse:(NSString*)str
{
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor blackColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return [UIColor blackColor];
    if(cString.length==6) cString = [cString stringByAppendingString:@"FF"];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    range.location = 6;
    NSString *aString = [cString substringWithRange:range];
    
    unsigned int red, green, blue, alpha;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&red];
    [[NSScanner scannerWithString:gString] scanHexInt:&green];
    [[NSScanner scannerWithString:bString] scanHexInt:&blue];
    [[NSScanner scannerWithString:aString] scanHexInt:&alpha];
    
    return [UIColor colorWithRed:red
                           Green:green
                            Blue:blue
                           Alpha:alpha];
}
-(NSString*)toString
{
    CGFloat red, green, blue, alpha;
    if(![self getRed:&red green:&green blue:&blue alpha:&alpha]){
        return @"";
    }
    return [NSString stringWithFormat:@"#%@%@%@",
            [MATH toHex:red*255],
            [MATH toHex:green*255],
            [MATH toHex:blue*255]];

}
/*-(NSString *)toHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;  
        }  
        
    }  
    return str;  
}
- (NSString*)description
{
    CGFloat red, green, blue, alpha;
    if(![self getRed:&red green:&green blue:&blue alpha:&alpha]){
        return @"";
    }
    return [NSString stringWithFormat:@"#%@%@%@",
            [self toHex:red],
            [self toHex:green],
            [self toHex:blue]];
}*/
@end
