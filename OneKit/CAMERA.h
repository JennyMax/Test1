//
//  CAMERA.h
//  OneKit
//
//  Created by HeYanTao on 15/9/28.
//  Copyright © 2015年 张瑾. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "OneKit.h"
/**
 *  回调返回图片
 *
 *  @param image image
 */
typedef void (^Callback) (UIImage* image);
/**
 *  回调返回url
 *
 *  @param path path
 */
typedef void (^VideoCallback) (NSURL *path);
/**
 *  拍照、录像、相册
 */
@interface CAMERA : NSObject
/**
 *  打开相机
 *
 *  @param callback 返回图片
 */
+(void)openCamera:(UIViewController*)viewController callback:(Callback)callback;
/**
 *  打开相册
 *
 *  @param callback 返回图片
 */
+(void)openGallery:(UIViewController*)viewController callback:(Callback)callback;
/**
 *  打开录像
 *
 *  @param callback 返回录像url
 */
+(void)openRecord:(VideoCallback)callback;
@end
