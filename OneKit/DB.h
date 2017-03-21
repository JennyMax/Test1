//
//  DB.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
//#import "OneKit.h"
/**
 *  数据库操作
 */
@interface DB : NSObject
/**
 *  打开数据库(必须存在)
 *
 *  @param name 名称
 *
 *  @return 数据库
 */
+ (DB*)openDB:(NSString*)name;
/**
 *  打开数据库
 *
 *  @param name 名称
 *  @param check 检查是否存在(false为自动创建)
 *
 *  @return 数据库
 */
+ (DB*)openDB:(NSString *)name check:(BOOL)check;
/**
 *  查询
 *
 *  @param sql 查询语句
 *
 *  @return 查询结果
 */
- (NSArray*)execSql:(NSString*)sql;
/**
 *  快速查询
 *
 *  @param sql 查询语句
 *  @param firstArgument 查询条件
 *
 *  @return 查询结果
 */
- (NSArray*)execSql:(NSString*)sql arguments:(id)firstArgument, ...;
/**
 *  关闭数据库
 */
- (void)closeDB;

+ (NSArray*)execDB:(NSString*)name sql:(NSString*)sql;

+ (NSArray*)execDB:(NSString*)name sql:(NSString*)sql arguments:(id)firstArgument, ...;
@end
