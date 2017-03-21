//
//  IMAGE.m
//  OneKit
//
//  Created by HeYanTao on 15/9/28.
//  Copyright © 2015年 张瑾. All rights reserved.
//

#import "IMAGE.h"
#import "UIImage+OneKit.h"
@implementation IMAGE
+ (void)init
{
    //[OneKit init];
}
+ (UIImage *)roundImage:(UIImage *)image
{
    [self init];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    CGFloat bigRadius = MIN(imageW, imageH) * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (UIImage *)compressImage:(UIImage *)image asize:(CGSize)asize
{
    [self init];
    return [image compressImage:asize];
}
@end
