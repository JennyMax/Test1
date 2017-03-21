//
//  UIImage+OneKit.h
//  iOS7KitDemo
//
//  Created by 张 瑾 on 13-8-16.
//  Copyright (c) 2013年 www.onekit.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OneKit)
+ (UIImage*)clearImage;
+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;
+ (UIImage*)imageWithColor:(UIColor *)color;
- (UIImage*)changeColor:(UIColor *)color;
- (UIImage*)blur;
/**
 *  图片压缩
 *
 *  @param asize 目标大小
 *
 *  @return 返回结果
 */
- (UIImage *)compressImage:(CGSize)asize;
/**
 *  图片剪切
 *
 *  @param rect 目标大小
 *
 *  @return 返回结果
 */
- (UIImage*)clipWithRect:(CGRect)rect;
/**
 *  圆形图片剪切
 *
 *  @return 返回结果
 */
- (UIImage *)roundImage;
@end
