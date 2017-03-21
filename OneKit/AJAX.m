//
//  AJAX.m
//  OneKit
//
//  Created by www.onekit.cn on 15/2/26.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "AJAX.h"
#import "JSON.h"
#import "STRING.h"
#import "DIALOG.h"
#import "NSString+OneKit.h"
#import "Macro.h"
#import "MESSAGE.h"
@interface AJAX ()

@end
static NSDictionary *HEADERS;
static NSDictionary *HEADER;
static BOOL isDemo = FALSE;
@implementation AJAX
+ (void)init
{
    //[OneKit init];
}
+ (void)getResponseWithUrl:(NSString *)url
                    params:(NSDictionary *)params
                      mode:(AJAXMode)mode
                  callback:(void (^)(BOOL isError,NSHTTPURLResponse* response, NSData* data))callback
{
    [self init];
    if (isNull(url)) {
        NSLog(@"[OneKit-AJAX-getWithUrl]:url is null.");
        return;
    }
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSString* method;
    switch (mode) {
        case AJAXModeDelete:
            method = @"DELETE";
            break;
        case AJAXModeGet:
            method = @"GET";
            break;
        case AJAXModePost:
            method = @"POST";
            break;
        case AJAXModePut:
            method = @"PUT";
            break;
        default:
            method = nil;
            break;
    }
    request.HTTPMethod = method;
    
    //封装参数
    if (notNull(params))
    {
        switch (mode) {
            case AJAXModePost:
            case AJAXModePut:{
                NSMutableData *data = [[NSMutableData alloc] init];
                [data appendData:[[JSON stringify:params] dataUsingEncoding:NSUTF8StringEncoding]];
                request.HTTPBody = data;
                break;}
            case AJAXModeDelete:
            case AJAXModeGet:{
                NSString* fullUrl;
                NSString* str = @"";
                for (NSString* key in params) {
                    id value = [params objectForKey:key];
                    if([NSJSONSerialization isValidJSONObject:value]){
                        value = [JSON stringify:value];
                    }
                    if([value isKindOfClass:[NSString class]]){
                        value = [(NSString*)value URLEncode];
                    }
                    str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@"&%@=%@",key,value]];
                }
                if(str.length>0){
                    str = [str substringFromIndex:1];
                }
                if (isEmpty(str)) {
                    fullUrl = url;
                }else{
                    NSURL* url1 = [NSURL URLWithString:url];
                    if (url1.query) {
                        fullUrl = [NSString stringWithFormat:@"%@&%@",url,str];
                    }
                    else{
                        fullUrl = [NSString stringWithFormat:@"%@?%@",url,str];
                    }
                }
                request.URL = [NSURL URLWithString:fullUrl];
                break;}
            default:
                break;
        }
    }
    if (isDemo) {
        NSString *path = [url replace:@"http://" to:@""];
        NSArray *array = [STRING parse:path seperator:@"/"];
        NSString *filename = array(array, array.count-1);
        if ([filename contains:@"."]) {
            NSInteger index = [filename indexOf:@"."];
            filename = [filename substringToIndex:index];
        }
        filename = [filename URLEncode];
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:filename
                                  ofType:@"txt"];
        
        callback(FALSE,Nil,[NSData dataWithContentsOfFile:backupDbPath]);
        return;
    }
    if(notNull(HEADER)){
        for (NSString *key in HEADER.allKeys) {
            [request setValue:HEADER[key] forHTTPHeaderField:key];
        }
    }
    request.cachePolicy = NSURLCacheStorageAllowedInMemoryOnly;
    
    //发起请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  connectionError)
                                  {
                                      //成功返回取消loading
                                      NSString* message = nil;
                                      if(connectionError){
                                          message = @"服务器连接错误";
                                      }else{
                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                                          int statusCode = -1;
                                          if(httpResponse){
                                              statusCode = (int)httpResponse.statusCode;
                                          }
                                          if(statusCode!=200){
                                              if(statusCode==401){
                                                  //[MESSAGE sendMessage:MSG_LOGIN data:nil];
                                                  return;
                                              }
                                              switch (statusCode) {
                                                  case -1:
                                                  case 0:
                                                      message = @"网络无法连接，请检查网络设置。";
                                                      break;
                                                  default:{
                                                      NSError* error;
                                                      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                      message = json[@"error_msg"];
                                                      NSDictionary* error_detail = json[@"error_detail"];
                                                      if(error_detail){
                                                          NSMutableString* string = [NSMutableString stringWithString:message];
                                                          for (NSString* key in error_detail.allKeys) {
                                                              [string appendFormat:@"\n[%@]%@",key,error_detail[key]];
                                                          }
                                                          message = string;
                                                      }
                                                      break;}
                                              }
                                          }
                                      }
                                      if(message){
                                          dispatch_async(dispatch_get_main_queue(),^ {
                                              [DIALOG alert:message callback:^{
                                                  
                                                  callback(TRUE,(NSHTTPURLResponse*)response, nil);
                                              }];
                                          });
                                          return;
                                      };
                                      dispatch_async(dispatch_get_main_queue(),^ {
                                          callback(FALSE,(NSHTTPURLResponse*)response, data);
                                      });
                                  }];
    [task resume];
}
+(NSDictionary *)headers
{
    return HEADERS;
}
+(void)setHeader:(NSDictionary*)header
{
    HEADER = header;
}
+ (void)getVoidWithUrl:(NSString *)url
                params:(NSDictionary *)params
                  mode:(AJAXMode)mode
              callback:(void (^)(BOOL))callback
{
    [self getResponseWithUrl:url
                      params:params
                        mode:mode
                    callback:^(BOOL isError, NSHTTPURLResponse *response,NSData* data) {
                        if (isError) {
                            if (notNull(callback)) callback(TRUE);
                            return ;
                        }
                        if (notNull(callback)) callback(FALSE);
                    }];
}

+ (void)getDataWithUrl:(NSString *)url
                params:(NSDictionary *)params
                  mode:(AJAXMode)mode
              callback:(void (^)(BOOL, NSData *))callback
{
    [self getResponseWithUrl:url
                      params:params
                        mode:mode
                    callback:^(BOOL isError, NSHTTPURLResponse *response,NSData* data) {
                        if(isError)
                        {
                            callback(TRUE,Nil);
                            return ;
                        }
                        if (isDemo) {
                            callback(isError,data);
                            return;
                        }
                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                        HEADERS =httpResponse.allHeaderFields;
                        //检查状态码
                        switch (httpResponse.statusCode)
                        {
                            case 500:
                                NSLog(@"[OneKit-AJAX-getDataWithUrl]:Internal Server Error.");
                                [DIALOG warning:@"服务器内部错误,请稍后再试！" isSilence:TRUE callback:nil];
                                if (notNull(callback)) callback(TRUE, nil);
                                break;
                            case 404:
                                NSLog(@"[OneKit-AJAX-getDataWithUrl]:Resource not found.");
                                [DIALOG warning:@"未找到资源,请稍后再试！" isSilence:TRUE callback:nil];
                                if (notNull(callback)) callback(TRUE, nil);
                                break;
                            case 200:
                                if (notNull(callback)) callback(FALSE, data);
                                break;
                            default:
                                NSLog(@"[OneKit-AJAX-getDataWithUrl]:Unknown error.");
                                [DIALOG warning:@"未知错误,请稍后再试！" isSilence:TRUE callback:nil];
                                if (notNull(callback)) callback(TRUE, nil);
                                break;
                        }
                    }];
}

+ (void)getStringWithUrl:(NSString *)url
                  params:(NSDictionary *)params
                    mode:(AJAXMode)mode
                callback:(void (^)(BOOL, NSString *))callback
{
    [self getDataWithUrl:url
                  params:params
                    mode:mode
                callback:^(BOOL isError, NSData *data) {
                    if (isError) {
                        if (notNull(callback)) callback(TRUE, nil);
                        return ;
                    }
                    if (notNull(callback))
                    {
                        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        callback(FALSE, string);
                    }
                }];
}

+ (void)getJSONWithUrl:(NSString *)url
                params:(NSDictionary *)params
                  mode:(AJAXMode)mode
              callback:(void (^)(BOOL, NSDictionary *))callback{
    [self getDataWithUrl:url
                  params:params
                    mode:mode
                callback:^(BOOL isError, NSData *data) {
                    if (isError) {
                        if (notNull(callback)) callback(TRUE, nil);
                        return ;
                    }
                    if (data) {
                        NSError *error;
                        id result;
                        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                        if (error) {
                            if (notNull(callback)) callback(TRUE,nil);
                            return;
                        }
                        if (notNull(callback)) callback(FALSE, result);
                    }
                }];
}
+ (void)getJSONsWithUrl:(NSString *)url
                 params:(NSDictionary *)params
                   mode:(AJAXMode)mode
               callback:(void (^)(BOOL, NSArray *))callback{
    [self getDataWithUrl:url
                  params:params
                    mode:mode
                callback:^(BOOL isError, NSData *data) {
                    if (isError) {
                        if (notNull(callback)) callback(TRUE, nil);
                        return ;
                    }
                    if (data) {
                        NSError *error;
                        id result;
                        result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                        if (error) {
                            if (notNull(callback)) callback(TRUE,nil);
                            return;
                        }
                        if (notNull(callback)) callback(FALSE, result);
                    }
                }];
}
+(void)isDemo:(BOOL)isdemo
{
    isDemo = isdemo;
}
+ (void)getImageWithUrl:(NSString *)url
               callback:(void (^)(BOOL, UIImage *))callback{
    [AJAX getDataWithUrl:url params:nil mode:AJAXModeGet callback:^(BOOL isError, NSData *data) {
        if(isError){
            callback(TRUE,nil);
            return;
        }
        callback(FALSE,[UIImage imageWithData:data]);
    }];
    /*[self init];
     if (isDemo) {
     NSString *path = [url replace:@"http://" to:@""];
     NSArray *array = [STRING parse:path seperator:@"/"];
     NSString *filename = array(array, array.count-1);
     if ([filename contains:@"."]) {
     NSInteger index = [filename indexOf:@"."];
     filename = [filename substringToIndex:index];
     }
     filename = [filename URLEncode];
     NSString *backupDbPath = [[NSBundle mainBundle]
     pathForResource:filename
     ofType:@"png"];
     callback(FALSE,[UIImage imageWithContentsOfFile:backupDbPath]);
     return;
     }
     else{
     if (isNull(url)) {
     NSLog(@"[OneKit-AJAX-getImageWithUrl]:url is null.");
     return;
     }
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
     request.HTTPMethod = @"GET";
     request.cachePolicy = NSURLCacheStorageAllowedInMemoryOnly;
     
     //发起请求
     //[NSURLConnection sendAsynchronousRequest:request
     // queue:[NSOperationQueue mainQueue]
     //                      completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     NSURLSession *session = [NSURLSession sharedSession];
     NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  connectionError)
     {
     
     //成功返回取消loading
     if(connectionError){
     return;
     }
     //NSError* error;
     NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
     int statusCode = -1;
     if(httpResponse){
     statusCode = (int)httpResponse.statusCode;
     }
     if(statusCode!=200){
     if (notNull(callback)) callback(TRUE,nil);
     return;
     }else{
     if (notNull(callback)) callback(FALSE, [UIImage imageWithData:data]);
     return;
     }
     }];
     [task resume];
     }*/
    //    [self getDataWithUrl:url
    //                  params:params
    //                    mode:mode
    //                callback:^(BOOL isError, NSData *data) {
    //                    if (isError) {
    //                        if (notNull(callback)) callback(TRUE,nil);
    //                        return ;
    //                    }
    //                    if (notNull(callback)) callback(FALSE, [UIImage imageWithData:data]);
    //
    //                }];
}

+ (void)uploadWithUrl:(NSString *)url
               params:(NSDictionary *)params
               images:(NSDictionary*)images
                 mode:(AJAXMode)mode
             callback:(void (^)(BOOL isError,NSDictionary* json))callback
{
    [self init];
    if (isNull(url)) {
        NSLog(@"[OneKit-AJAX-getWithUrl]:url is null.");
        return;
    }
    
    //    if(!isSilence){
    //        [LOADING show];
    //    }
    /*
     NSString *TWITTERFON_FORM_BOUNDARY = @"qQNGmZztD7GsLMbtTN3xnkAwrdROWO";
     NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
     NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
     NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
     NSData* data = UIImagePNGRepresentation(image);
     NSMutableString *body=[[NSMutableString alloc]init];
     if(params){
     for (id key in params.allKeys) {
     [body appendFormat:@"%@\r\n",MPboundary];
     [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
     [body appendFormat:@"%@\r\n",[params objectForKey:key]];
     }
     }
     //
     [body appendFormat:@"%@\r\n",MPboundary];
     [body appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",name,name];
     [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
     NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
     //
     NSMutableData *myRequestData=[NSMutableData data];
     [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
     [myRequestData appendData:data];
     [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
     //
     NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
     [request setValue:content forHTTPHeaderField:@"Content-Type"];
     [request setValue:[NSString stringWithFormat:@"%ld",(unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
     [request setHTTPBody:myRequestData];
     request.HTTPMethod = (isPost?@"POST":@"GET");
     */
    /* NSString *TWITTERFON_FORM_BOUNDARY = @"qQNGmZztD7GsLMbtTN3xnkAwrdROWO";
     NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
     NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
     NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
     NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
     //
     NSMutableData *myRequestData=[NSMutableData data];
     NSMutableString *body0=[[NSMutableString alloc]init];
     if(params){
     for (id key in params.allKeys) {
     [body0 appendFormat:@"%@\r\n",MPboundary];
     [body0 appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
     [body0 appendFormat:@"%@\r\n",[params objectForKey:key]];
     [body0 appendFormat:@"%@\r\n",MPboundary];
     }
     [myRequestData appendData:[body0 dataUsingEncoding:NSUTF8StringEncoding]];
     }
     if(notNull(headers)){
     for (NSString *key in headers.allKeys) {
     [request setValue:headers[key] forHTTPHeaderField:key];
     }
     }
     //
     if(images){
     for (id key in images.allKeys) {
     NSMutableString *body=[[NSMutableString alloc]init];
     [body appendFormat:@"%@\r\n",MPboundary];
     [body appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",key,key];
     [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
     //NSData* file = [NSData dataWithContentsOfFile:files[key]];
     NSData* data = UIImagePNGRepresentation(images[key]);
     [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
     [myRequestData appendData:data];
     [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
     }
     }
     [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
     //
     [request setValue:[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY] forHTTPHeaderField:@"Content-Type"];
     [request setValue:[NSString stringWithFormat:@"%ld",(unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
     [request setHTTPBody:myRequestData];
     request.HTTPMethod = @"POST";
     */
    
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
    UIImage *image;//=[params objectForKey:@"pic"];
    //得到图片的data
    //NSData* data = UIImagePNGRepresentation(image);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [params allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是pic，说明value是字符类型，比如name：Boris
        //if(![key isEqualToString:@"pic"]) {
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //[body appendString:@"Content-Transfer-Encoding: 8bit"];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[params objectForKey:key]];
        //}
    }
    ////添加分界线，换行
    //[body appendFormat:@"%@\r\n",MPboundary];
    
    //声明myRequestData，用来放入http body
  
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
      if(images){
    //循环加入上传图片
    keys = [images allKeys];
    for(int i = 0; i< [keys count] ; i++){
        //要上传的图片
        image = [images objectForKey:[keys objectAtIndex:i ]];
        //得到图片的data
        NSData* data =  UIImageJPEGRepresentation(image, 0.0);
        NSMutableString *imgbody = [[NSMutableString alloc] init];
        //此处循环添加图片文件
        //添加图片信息字段
        //声明pic字段，文件名为boris.png
        //[body appendFormat:[NSString stringWithFormat: @"Content-Disposition: form-data; name=\"File\"; filename=\"%@\"\r\n", [keys objectAtIndex:i]]];
        
        ////添加分界线，换行
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        [imgbody appendFormat:@"Content-Disposition: form-data; name=\"File%d\"; filename=\"%@.jpg\"\r\n", i, [keys objectAtIndex:i]];
        //声明上传文件的格式
        [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
        
        NSLog(@"上传的图片：%d  %@", i, [keys objectAtIndex:i]);
        
        //将body字符串转化为UTF8格式的二进制
        //[myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
      }
    //[request setValue:@"keep-alive" forHTTPHeaderField:@"connection"];
    //[request setValue:@"UTF-8" forHTTPHeaderField:@"Charsert"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    
    //http method
    NSString* method;
    switch (mode) {
        case AJAXModeDelete:
            method = @"DELETE";
            break;
        case AJAXModeGet:
            method = @"GET";
            break;
        case AJAXModePost:
            method = @"POST";
            break;
        case AJAXModePut:
            method = @"PUT";
            break;
        default:
            method = nil;
            break;
    }
    request.HTTPMethod = method;
    
    //[NSURLConnection sendAsynchronousRequest:request
    //                                  queue:[NSOperationQueue mainQueue]
    //                      completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  connectionError)
                                  {
                                      //成功返回取消loading
                                      NSString* message = nil;
                                      if(connectionError){
                                          message = @"服务器连接错误";
                                      }else{
                                          NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                                          int statusCode = -1;
                                          if(httpResponse){
                                              statusCode = (int)httpResponse.statusCode;
                                          }
                                          if(statusCode!=200){
                                              if(statusCode==401){
                                                 // [MESSAGE sendMessage:MSG_LOGIN data:nil];
                                                  return;
                                              }
                                              switch (statusCode) {
                                                  case -1:
                                                  case 0:
                                                      message = @"网络无法连接，请检查网络设置。";
                                                      break;
                                                  default:{
                                                      NSError* error;
                                                      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                      message = json[@"error_msg"];
                                                      break;}
                                              }
                                          }
                                      }
                                      if(message){
                                          dispatch_async(dispatch_get_main_queue(),^ {
                                              [DIALOG alert:message callback:^{
                                                  
                                                  callback(TRUE, nil);
                                              }];
                                          });
                                          return;
                                      };
                                      dispatch_async(dispatch_get_main_queue(),^ {
                                          NSError* error;
                                          callback(FALSE,[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]);
                                      });
                                      
                                  }];
    [task resume];
}
@end
