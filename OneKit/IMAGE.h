//
//  IMAGE.h
//  OneKit
//
//  Created by HeYanTao on 15/9/28.
//  Copyright © 2015年 张瑾. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "OneKit.h"
/**
 *  图片操作
 */
@interface IMAGE : NSObject
/**
 *  剪切成圆角图片
 *
 *  @param image 原始图片
 *
 *  @return 圆角图片
 */
+ (UIImage *)roundImage:(UIImage *)image;
/**
 *  图片压缩
 *
 *  @param image 图片
 *  @param asize 压缩后的大小
 *
 *  @return 压缩图片
 */
+ (UIImage *)compressImage:(UIImage *)image asize:(CGSize)asize;
@end
