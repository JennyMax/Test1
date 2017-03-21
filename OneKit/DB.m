//
//  DB.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "sqlite3.h"
#import "DB.h"
#import "FSO.h"
#import "Macro.h"
static NSMutableDictionary *connPooling = nil;

@interface DB ()

//数据库句柄
@property sqlite3 *Connection;
//数据库文件的名称
@property(nonatomic,strong) NSString *name;

@end

@implementation DB
+ (void)init
{
    //[OneKit init];
}
+ (DB *)openDB:(NSString *)name
{
    return [DB openDB:name check:true];
}
+ (DB *)openDB:(NSString *)name check:(BOOL)check
{
    [self init];
    if (check && [FSO isEmpty:name]) {
        NSLog(@"[OneKit-DB]:open Failed:Can't find the file");
        return nil;
    }
    if (isNull(connPooling)) {
        connPooling = [[NSMutableDictionary alloc] init];
    }
    DB* db = [connPooling objectForKey:name];
    if (isNull(db)){
        if ([db _open:name]) {
            db.name = name;
            [connPooling setValue:db forKey:name];
            return db;
        }else{
            NSLog(@"[OneKit-DB]:open Failed.");
            return nil;
        }
        
    }else{
        return db;
    }
}
- (BOOL)_open:(NSString *)name
{
    NSString *path;
    path = [FSO getPathWithFileName:name];
    NSInteger rc = sqlite3_open([path UTF8String], &(_Connection));
    if (rc != SQLITE_OK) {
        return false;
    }else{
        return true;
    }
}

- (NSArray *)execSql:(NSString *)sql
{
    [DB init];
    return [self execSql:sql arguments:nil];
}

- (NSArray *)execSql:(NSString *)sql arguments:(id)firstArgument, ...
{
    
    [DB init];
    //操作结果
    NSInteger result;
    //这个相当于ODBC的Command对象，用于保存编译好的SQL语句
    sqlite3_stmt *stmt;
    
    result = sqlite3_prepare_v2(_Connection, [sql UTF8String], (int)sql.length, &stmt, nil);
    if (result != SQLITE_OK) {
        NSLog(@"[OneKit-DB]:prepare error! %s",sqlite3_errmsg(_Connection));
        return nil;
    }
    
    //绑定参数
    va_list arguments;
    if (notNull(firstArgument)) {
        int i = 0;
        va_start(arguments, firstArgument);
        NSString *str = [NSString stringWithFormat:@"%@",firstArgument];
        result = sqlite3_bind_text(stmt, ++i, [str UTF8String], (int)str.length, nil);
        if (result != SQLITE_OK) {
            NSLog(@"[OneKit-DB]:firstArgument error! %s",sqlite3_errmsg(_Connection));
            return nil;
        }
        
        id otherArgument;
        while (true) {
            otherArgument = va_arg(arguments, id);
            if (isNull(otherArgument)) {
                break;
            }else{
                str = [NSString stringWithFormat:@"%@", otherArgument];
                result = sqlite3_bind_text(stmt, ++i, [str UTF8String], (int)str.length, nil);
                if (result != SQLITE_OK) {
                    NSLog(@"[OneKit-DB]:otherArgument error! please check sql or arguments.");
                    return nil;
                }
            }
        }
        va_end(arguments);
    }
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSInteger columnCount = sqlite3_column_count(stmt);
    
    //读取结果
    while(true){
        result = sqlite3_step(stmt);
        if (result != SQLITE_ROW) {
            break;
        }
        
        NSMutableDictionary* entity = [[NSMutableDictionary alloc] init];
        for(int i=0; i<columnCount; i++)
        {
            const char* col = sqlite3_column_name(stmt, i);
            const char* value = (char*)sqlite3_column_text(stmt, i);
            [entity setObject:(value != NULL?[NSString stringWithUTF8String:value]:[NSNull null]) forKey:[NSString stringWithUTF8String:col]];
        }
        [results addObject:entity];
    }
    
    sqlite3_finalize(stmt);
    return results;
}

- (void)closeDB
{
    [DB init];
    NSInteger rc = sqlite3_close(_Connection);
    if (rc != SQLITE_OK) {
        NSLog(@"[OneKit-DB]:close Failed.");
    }else{
        [connPooling removeObjectForKey:_name];
    }
}

+ (NSArray*)execDB:(NSString*)name sql:(NSString*)sql
{
    [DB init];
    /*
    [self init];
    DB* conn = [DB openDB:db];
    NSArray* RESULT = [conn execSql:sql];
    [conn closeDB];
    return RESULT;*/
    return [DB execDB:name sql:sql arguments:nil];
}
+ (NSArray*)execDB:(NSString*)name sql:(NSString*)sql arguments:(id)firstArgument, ...
{
    [DB init];
    DB* db = [DB openDB:name];
    va_list arguments;
    va_start(arguments, firstArgument);
    NSArray* RESULT = [db execSql:sql arguments:CFBridgingRelease(arguments)];
    [db closeDB];
    return RESULT;
}
@end
