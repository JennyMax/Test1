//
//  UIImage+OneKit.m
//  iOS7KitDemo
//
//  Created by 张 瑾 on 13-8-16.
//  Copyright (c) 2013年 www.onekit.cn. All rights reserved.
//

#import "UIImage+OneKit.h"

@implementation UIImage (OneKit)
+ (UIImage*)clearImage
{
    return [self imageWithColor:[UIColor clearColor]];
}
- (UIImage*)clipWithRect:(CGRect)rect
{
    CGRect frame = CGRectMake(rect.origin.x*self.scale, rect.origin.y*self.scale, rect.size.width*self.scale, rect.size.height*self.scale);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContextWithOptions(smallBounds.size, NO,self.scale);
    //UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}
+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha
{
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    CGContextSetFillColorWithColor(currentContext, [color CGColor]);
    CGContextFillRect(currentContext, fillRect);
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage;
}
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1) alpha:1];
}
- (UIImage *)changeColor:(UIColor *)theColor
{
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, self.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
	
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, self.CGImage);
	
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
- (UIImage *)blur
{
    /*CGImageRef beginImageRef = self.CGImage;
    CIImage* beginImage = [CIImage imageWithCGImage:beginImageRef];
    CIFilter* filter = [CIFilter filterWithName:@"CIVignette"];
    [filter setValue:@5.0 forKey:@"inputIntensity"];
    [filter setValue:@1.0 forKey:@"inputRadius"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    CIImage *outputImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return newImg;*/
    
    float weight[5] = {0.1270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162};
    // Blur horizontally
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:weight[0]];
    for (int x = 1; x < 5; ++x) {
        [self drawInRect:CGRectMake(x, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:weight[x]];
        [self drawInRect:CGRectMake(-x, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:weight[x]];
    }
    UIImage *horizBlurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Blur vertically
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [horizBlurredImage drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:weight[0]];
    for (int y = 1; y < 5; ++y) {
        [horizBlurredImage drawInRect:CGRectMake(0, y, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:weight[y]];
        [horizBlurredImage drawInRect:CGRectMake(0, -y, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:weight[y]];
    }
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    return blurredImage;
}
- (UIImage *)compressImage:(CGSize)asize
{
    if(asize.width>=self.size.width || asize.height>=self.size.height){
        return self;
    }
	UIImage *newimage;
    
    
    CGSize oldsize = self.size;
    
    CGRect rect;
    
    if (asize.width/asize.height > oldsize.width/oldsize.height) {
        
        rect.size.width = asize.height*oldsize.width/oldsize.height;
        
        rect.size.height = asize.height;
        
        rect.origin.x = (asize.width - rect.size.width)/2;
        
        rect.origin.y = 0;
        
    }
    
    else{
        
        rect.size.width = asize.width;
        
        rect.size.height = asize.width*oldsize.height/oldsize.width;
        
        rect.origin.x = 0;
        
        rect.origin.y = (asize.height - rect.size.height)/2;
        
    }
    
    UIGraphicsBeginImageContext(asize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
    
    [self drawInRect:rect];
    
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return newimage;
}

- (UIImage *)roundImage
{
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
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
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
