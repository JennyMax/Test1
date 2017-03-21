//
//  DIALOG.h
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

//#import "OneKit.h"
#import "DatePicker.h"
#import "SimplePickerView.h"
/**
 *  日期回调
 *
 *  @param date 结果
 */
typedef void (^DatePickerCallback)(NSString *date);
/**
 *  picker回调
 *
 *  @param index 结果
 */
typedef void (^PickerCallback)(NSInteger index);
/**
 *  对话框
 */
@interface DIALOG : NSObject <UIAlertViewDelegate, UIActionSheetDelegate,DatePickerDelegate,SimplePickerViewDelegate>
{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}
/**
 *  显示等待对话框
 */
+ (void)loading;
/**
 *  隐藏等待对话框
 */
+ (void)done;
/**
 *  警告框
 *
 *  @param message   消息
 *  @param isSilence 是否显示提示框
 *  @param callback  回调函数
 */
+ (void)warning:(NSString*)message
                 isSilence:(BOOL)isSilence
                  callback:(void (^)(void))callback;
/**
 *  消息框
 *
 *  @param message 消息
 */
+ (void)alert:(NSString*)message;
/**
 *  消息框
 *
 *  @param message  消息
 *  @param callback 回调函数
 */
+ (void)alert:(NSString*)message
                callback:(void (^)(void))callback;
/**
 *  确认框
 *
 *  @param message  消息
 *  @param callback 回调函数
 */
+ (void)confirm:(NSString*)message
                  callback:(void (^)(BOOL ok))callback;
/**
 *  自定义按钮文字的消息框
 *
 *  @param message  消息
 *  @param yesTitle 确认文字
 *  @param noTitle  取消文字
 *  @param callback 回调函数
 */
+ (void)confirm:(NSString*)message
                  yesTitle:(NSString*)yesTitle
                   noTitle:(NSString*)noTitle
                  callback:(void (^)(BOOL ok))callback;
/**
 *  列表选择框
 *
 *  @param titles   列表数组
 *  @param callback 选择结果
 */
+ (void)chooseWithTitles:(NSArray*)titles
                callback:(void (^)(int index))callback;

/**
 *  输入框
 *
 *  @param title        title
 *  @param keyboardType 键盘类型
 *  @param callback     回调函数
 */
+ (void)input:(NSString *)title
                  type:(UIKeyboardType)keyboardType
              callback:(void (^) (BOOL isOk,NSString * string))callback;
/**
 *  提示框
 *
 *  @param message 消息
 */
+ (void)toast:(NSString*)message;
/**
 *  日期选择器
 *
 *  @param callback 选择结果
 */
+(void)datePickerView:(void (^) (NSString * string))callback;
/**
 *  时间选择器
 *
 *  @param callback 选择结果
 */
+(void)timePickerView:(void (^) (NSString * string))callback;
/**
 *  日期和时间选择器
 *
 *  @param callback 选择结果
 */
+(void)dateTimePickerView:(void (^) (NSString * string))callback;
/**
 *  滚筒选择器
 *
 *  @param array    数组
 *  @param callback 选择结果
 */
+(void)pickerView:(NSArray*)array callback:(void (^) (NSInteger  index))callback;
@end
