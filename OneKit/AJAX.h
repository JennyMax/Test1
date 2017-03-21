//
//  Ajax.h
//  OneKit
//
//  Created by www.onekit.cn on 15/2/26.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 请求方式
 */
typedef enum {
    AJAXModeGet,
    AJAXModePost,
    AJAXModePut,
    AJAXModeDelete
}AJAXMode;
/**
 *  网络请求
 */
@interface AJAX : NSObject

/**
 *  无返回网络请求
 *
 *  @param url       地址
 *  @param params    参数
 *  @param mode      请求方式
 *  @param callback  请求完成的回调
 */
+ (void)getVoidWithUrl:(NSString*)url
                params:(NSDictionary*)params
                  mode:(AJAXMode)mode
              callback:(void(^)(BOOL isError))callback;
/**
 *  返回二进制
 *
 *  @param url       地址
 *  @param params    参数
 *  @param mode      请求方式
 *  @param callback  请求完成的回调
 */
+ (void)getDataWithUrl:(NSString*)url
                params:(NSDictionary*)params
                  mode:(AJAXMode)mode
              callback:(void (^)(BOOL isError,NSData* data))callback;
/**
 *  返回字符串
 *
 *  @param url       地址
 *  @param params    参数
 *  @param mode      请求方式
 *  @param callback  请求完成的回调
 */
+ (void)getStringWithUrl:(NSString*)url
                  params:(NSDictionary*)params
                    mode:(AJAXMode)mode
                callback:(void (^)(BOOL isError,NSString* string))callback;
/**
 *  返回json
 *
 *  @param url       地址
 *  @param params    参数
 *  @param mode      请求方式
 *  @param callback  请求完成的回调
 */
+ (void)getJSONWithUrl:(NSString*)url
                params:(NSDictionary*)params
                  mode:(AJAXMode)mode
              callback:(void (^)(BOOL isError,NSDictionary* json))callback;
+ (void)getJSONsWithUrl:(NSString *)url
                 params:(NSDictionary *)params
                   mode:(AJAXMode)mode
               callback:(void (^)(BOOL, NSArray *))callback;
/**
 *  返回图片
 *
 *  @param url       地址
 *  @param callback  请求完成的回调
 */
+ (void)getImageWithUrl:(NSString*)url
               callback:(void (^)(BOOL isError,UIImage* image))callback;
/**
 *  上传
 *
 *  @param url       地址
 *  @param params    参数
 *  @param images    图片数组
 *  @param callback  请求完成的回调
 */
+ (void)uploadWithUrl:(NSString *)url
               params:(NSDictionary *)params
               images:(NSDictionary*)images
                 mode:(AJAXMode)mode
             callback:(void (^)(BOOL isError,NSDictionary* json))callback;
/**
 *  设置是否为demo测试(demo测试需在项目中根据接口地址创建文件夹和文件具体操作请参考OneKitDemo，参数的值含有特殊字符请先使用URLEncode转换)
 *
 *  @param isDemo  是否为demo测试
 */
+(void)isDemo:(BOOL)isDemo;
/**
 *  设置header
 *
 *  @param header header字典
 */
+(void)setHeader:(NSDictionary*)header;
/**
 *  返回的header
 */
+(NSDictionary *)headers;
@end
