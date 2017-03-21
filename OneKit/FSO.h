//
//  FSO.h
//  OneKit
//
//  Created by Visitors on 15/3/3.
//  Copyright (c) 2015年 visitors. All rights reserved.
//

//#import "OneKit.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  文件操作
 */
@interface FSO : NSObject

/**
 *  判断文件是否在沙盒Documents目录（或Documents的子目录）下
 *
 *  @param fileName 文件名称
 *
 *  @return 结果
 */
+ (BOOL)isEmpty:(NSString*)fileName;
+ (NSString*)getPathWithFileName:(NSString*)fileName;
/**
 *  加载文件
 *
 *  @param fileName 文件名称
 *
 *  @return 结果
 */
+ (NSData*)loadDataWithFileName:(NSString*)fileName;

/**
 *  保存文件
 *
 *  @param data     数据
 *  @param fileName 文件名称
 *
 *  @return 操作结果
 */
+ (BOOL)saveDataWithData:(NSData*)data fileName:(id)fileName;

/**
 *  删除文件
 *
 *  @param fileName 文件名称
 *
 *  @return 操作结果
 */
+ (BOOL)deleteDataWithFileName:(NSString *)fileName;
/**
 *  保存图片
 *
 *  @param image    图片
 *  @param fileName 文件名称
 *
 *  @return 操作结果
 */
+(BOOL)saveImageWith:(UIImage*)image fileName:(NSString*)fileName;
/**
 *  加载图片
 *
 *  @param fileName 文件名称
 *
 *  @return 结果
 */
+ (UIImage*)loadImageWithFileName:(NSString*)fileName;

/**
 *  加载字符串
 *
 *  @param fileName 文件名称
 *
 *  @return 结果
 */
+ (NSString*)loadStringWithFileName:(NSString*)fileName;

/**
 *  保存字符串
 *
 *  @param string   字符串内容
 *  @param fileName 文件名称
 *
 *  @return 操作结果
 */
+ (BOOL)saveStringWithString:(NSString*)string fileName:(NSString*)fileName;

/**
 *  加载JSON
 *
 *  @param fileName 文件名称
 *
 *  @return 结果
 */
+ (id)loadJSONWithFileName:(NSString*)fileName;

/**
 *  保存JSON
 *
 *  @param json     JSON内容
 *  @param fileName 文件名称
 *
 *  @return 操作结果
 */
+ (BOOL)saveJSONWithJSON:(NSDictionary*)json fileName:(id)fileName;

@end
