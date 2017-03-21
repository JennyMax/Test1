//
//  PASSWORD.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  加密
 */
@interface PASSWORD : NSObject
/**
 *  MD5
 *
 *  @param text 加密内容
 *
 *  @return 结果
 */
+ (NSString *) md5:(NSString*)text;
/**
 *  SHA1
 *
 *  @param text 加密内容
 *
 *  @return 结果
 */
+ (NSString *)sha1:(NSString*)text;
@end
