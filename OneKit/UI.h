//
//  UI.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  UI
 */
@interface UI : NSObject

/**
 *  加载xib文件
 *
 *  @param name  文件名
 *
 *  @return 加载对象
 */
+ (id)loadNibNamed:(NSString*)name;

/**
 *  加载xib文件
 *
 *  @param name        文件
 *  @param placeHolder 容器
 *
 *  @return 加载对象
 */
+ (id)loadNibNamed:(NSString*)name placeHolder:(UIView*)placeHolder;

@end
