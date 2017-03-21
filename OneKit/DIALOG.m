//
//  DIALOG.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//
#import "LOADING.h"
#import "UIViewController+OneKit.h"
#import "DIALOG.h"
#import "Macro.h"
#define DEFAULT_DISPLAY_DURATION 2.0f
static DIALOG *m_Instance = nil;
/**
 *  该结构用于标识当前弹出视图的类型
 */
typedef NS_ENUM(NSUInteger, AlertViewType){
    /**
     * Alert视图
     */
    AlertViewTypeAlert,
    /**
     * Confirm视图
     */
    AlertViewTypeConfirm,
    /**
     * Input视图
     */
    AlertViewTypeInput
};

typedef void (^AlertViewCallback)(BOOL ok);
typedef void (^ActionSheetCallback)(int);
typedef void (^InputCallback)(BOOL isOk, NSString *);

@interface DIALOG ()

/**
 * AlertViewType类型用于标识当前弹出视图的类型
 * 因为Alert视图和Confirm视图两种视图实质都是用UIAlertView实现，所以代理响应函数都是一个，该属性用于区分该应该调用那个callback
 */
@property AlertViewType alertViewType;
//Alert视图回调
@property (nonatomic, copy) AlertViewCallback alertViewCallback;
@property (nonatomic, copy) InputCallback inputCallback;
//ActionSheet视图回调
@property (nonatomic, copy) ActionSheetCallback actionSheetCallback;
@property (nonatomic, copy) DatePickerCallback datePickerCallback;
@property (nonatomic, copy) PickerCallback pickerCallback;
@property (nonatomic,strong) DatePicker*datePicker;
@property (nonatomic,strong) SimplePickerView*simplePickerView;
@end

@implementation DIALOG
+ (void)init
{
    //[OneKit init];
}
+ (id)shareInstance{
    if (isNull(m_Instance)) {
        m_Instance = [[DIALOG alloc] init];
    }
    return m_Instance;
}
+ (void)loading
{
    [LOADING show];
}
+ (void)done
{
    [LOADING hide];
}
+(void)showAlert:(NSString *)title message:(NSString *)message leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton DIALOG:(DIALOG *)DIALOG
{
    
    /*if ([self getIOSVersion]>=8.0) {
        UIAlertController *alear = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (leftButton==Nil && rightButton!=Nil) {
            UIAlertAction *rightButtonAction = [UIAlertAction actionWithTitle:rightButton style:UIAlertActionStyleCancel handler:nil];
          [alear addAction:rightButtonAction];
        }
        else if(leftButton!=Nil && rightButton==Nil)
        {
            UIAlertAction *leftButtonAction = [UIAlertAction actionWithTitle:leftButton style:UIAlertActionStyleCancel handler:nil];
            [alear addAction:leftButtonAction];
        }
        else if(leftButton!=Nil && rightButton!=Nil)
        {
            UIAlertAction *leftButtonAction = [UIAlertAction actionWithTitle:leftButton style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *rightButtonAction = [UIAlertAction actionWithTitle:rightButton style:UIAlertActionStyleDefault handler:nil];
            [alear addAction:leftButtonAction];
            [alear addAction:rightButtonAction];
        }
         //NSLog(@"IOSVersion==%f",[self getIOSVersion]);
        [[UIViewController current] presentViewController:alear animated:YES completion:nil];
    }
    else{*/
            [[[UIAlertView alloc] initWithTitle:title
                                        message:message
                                       delegate:DIALOG
                              cancelButtonTitle:leftButton
                              otherButtonTitles:rightButton,Nil]
             show];
  //  }
}
+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void)warning:(NSString *)message
                 isSilence:(BOOL)isSilence
                  callback:(void (^)(void))callback
{
    NSLog(@"%@",message);
    if(isSilence){
        return;
    }
    DIALOG* DIALOG = [self shareInstance];
    DIALOG.alertViewCallback = ^(BOOL ok){
        if (notNull(callback)) {
            callback();
        }
    };
    [self showAlert:Nil message:message leftButton:@"我知道了" rightButton:Nil DIALOG:DIALOG];
    /*[[[UIAlertView alloc] initWithTitle:nil
                                message:message
                               delegate:DIALOG
                      cancelButtonTitle:@"我知道了"
                      otherButtonTitles:nil]
     show];*/
}

+ (void)alert:(NSString *)message{
    [self alert:message callback:nil];
}

+ (void)alert:(NSString *)message callback:(void (^)(void))callback
{
    DIALOG* DIALOG = [self shareInstance];
    DIALOG.alertViewCallback = ^(BOOL ok){
        if(notNull(callback)){
            callback();
        }
    };
    DIALOG.alertViewType = AlertViewTypeAlert;
     [self showAlert:Nil message:message leftButton:@"关闭" rightButton:Nil DIALOG:DIALOG];
   /* [[[UIAlertView alloc] initWithTitle:nil
                                message:message
                               delegate:DIALOG
                      cancelButtonTitle:@"关闭"
                      otherButtonTitles:nil]
     show];*/
}

+ (void)confirm:(NSString *)message callback:(void (^)(BOOL))callback
{
    [self init];
    [self confirm:message
         yesTitle:@"是"
          noTitle:@"否"
         callback:callback];
}

+ (void)confirm:(NSString *)message
                  yesTitle:(NSString *)yesTitle
                   noTitle:(NSString *)noTitle
                  callback:(void (^)(BOOL))callback
{
    [self init];
    DIALOG* DIALOG = [self shareInstance];
    DIALOG.alertViewCallback = callback;
    DIALOG.alertViewType = AlertViewTypeConfirm;
     [self showAlert:Nil message:message leftButton:noTitle rightButton:yesTitle DIALOG:DIALOG];
    /*[[[UIAlertView alloc] initWithTitle:nil
                                message:message
                               delegate:DIALOG
                      cancelButtonTitle:noTitle
                      otherButtonTitles:yesTitle, nil]
     show];*/
}

+ (void)input:(NSString *)title type:(UIKeyboardType)keyboardType callback:(void (^)(BOOL isOk,NSString *))callback
{
    [self init];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil
                                                       delegate:[DIALOG shareInstance]
                                              cancelButtonTitle:@"取消"
                              
                                              otherButtonTitles:@"确定", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    ((DIALOG *)[DIALOG shareInstance]).alertViewType = AlertViewTypeInput;
    ((DIALOG *)[DIALOG shareInstance]).inputCallback = callback;
    [alertView textFieldAtIndex:0].keyboardType = keyboardType;
    [alertView show];
}

// UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [DIALOG init];
    switch (_alertViewType) {
        case AlertViewTypeAlert:
            if(_alertViewCallback != nil){
                _alertViewCallback(TRUE);
            }
            break;
        case AlertViewTypeConfirm:
            if(_alertViewCallback != nil){
                _alertViewCallback(buttonIndex == 1);
            }
            break;
        case AlertViewTypeInput:
            if(_inputCallback != nil){
                if (buttonIndex==0) {
                    _inputCallback(NO, nil);
                }else{
                    _inputCallback(YES,[alertView textFieldAtIndex:0].text);
                }
            }
            break;
        default:
            break;
    }
}

#pragma -mark choose
+ (void)chooseWithTitles:(NSArray*)titles
                callback:(void (^)(int index))callback
{
    [self init];
    UIViewController* viewController = [UIViewController current];
    DIALOG* DIALOG = [self shareInstance];
    DIALOG.actionSheetCallback = callback;
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:DIALOG
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:nil];
    
    for (NSString* title in titles) {
        [actionSheet addButtonWithTitle:title];
    }
    //[actionSheet showInView:viewController.navigationController.navigationBar];
    [actionSheet showInView:viewController.view];
}

//  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [DIALOG init];
    if(_actionSheetCallback){
        _actionSheetCallback((int)buttonIndex);
    }
}
+ (void)choosePickerWithTitles:(NSArray*)titles
                callback:(void (^)(int index))callback
{
    [self init];
    UIViewController* viewController = [UIViewController current];
    DIALOG* DIALOG = [self shareInstance];
    DIALOG.actionSheetCallback = callback;
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:DIALOG
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:nil];
    
    for (NSString* title in titles) {
        [actionSheet addButtonWithTitle:title];
    }
    [actionSheet showInView:viewController.navigationController.navigationBar];
}
+(void)toast:(NSString*)message
{
    [self init];
    [self showWithText:message bottomOffset:70.0f];
}
- (id)initWithText:(NSString *)text_{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
    if (self = [super init]) {
        
        text = [text_ copy];
        
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        CGSize textSize = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
        //CGSize textSize = [text sizeWithFont:font
        //                           constrainedToSize:CGSizeMake(280, MAXFLOAT)
        //                               lineBreakMode:NSLineBreakByClipping];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 12, textSize.height + 12)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.2f
                                                      green:0.2f
                                                       blue:0.2f
                                                      alpha:0.75f];
        [contentView addSubview:textLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;
        //[textLabel release];
        
        duration = DEFAULT_DISPLAY_DURATION;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self hideAnimation];
}

-(void)dismissToast{
    [contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat) duration_{
    duration = duration_;
}
//
-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}
//
-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 0.0f;
    [UIView commitAnimations];
}
- (void)showFromBottomOffset:(CGFloat) bottom_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom_ + contentView.frame.size.height/2));
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}
+ (void)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_{
    [DIALOG showWithText:text_  bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
}

+(void)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_
            duration:(CGFloat)duration_{
    DIALOG *toast = [[DIALOG alloc] initWithText:text_];
    [toast setDuration:duration_];
    [toast showFromBottomOffset:bottomOffset_];
}
+(void)datePickerView:(void (^) (NSString * string))callback
{
    [self init];
    if (m_Instance==nil) {
        [DIALOG shareInstance];
    }
    m_Instance.datePickerCallback = callback;
    m_Instance.datePicker = [[DatePicker alloc]initWithSelectTitle:Nil viewOfDelegate:[[UIApplication sharedApplication].delegate window] delegate:m_Instance];
    m_Instance.datePicker.theTypeOfDatePicker = 2;
    [m_Instance.datePicker pushDatePicker];
}
+(void)timePickerView:(void (^) (NSString * string))callback
{
    [self init];
    if (m_Instance==nil) {
        [DIALOG shareInstance];
    }
    m_Instance.datePickerCallback = callback;
    m_Instance.datePicker = [[DatePicker alloc]initWithSelectTitle:Nil viewOfDelegate:[[UIApplication sharedApplication].delegate window] delegate:m_Instance];
    m_Instance.datePicker.theTypeOfDatePicker = 1;
    [m_Instance.datePicker pushDatePicker];
}
+(void)dateTimePickerView:(void (^) (NSString * string))callback
{
    [self init];
    if (m_Instance==nil) {
        [DIALOG shareInstance];
    }
    m_Instance.datePickerCallback = callback;
    m_Instance.datePicker = [[DatePicker alloc]initWithSelectTitle:Nil viewOfDelegate:[[UIApplication sharedApplication].delegate window] delegate:m_Instance];
    m_Instance.datePicker.theTypeOfDatePicker = 3;
    [m_Instance.datePicker pushDatePicker];
}
-(void)DatePickerDidConfirm:(NSString *)confirmString
{
    _datePickerCallback(confirmString);
    //NSLog(@"%@",confirmString);
}
+(void)pickerView:(NSArray*)array callback:(void (^) (NSInteger  index))callback
{
    [self init];
    if (m_Instance==nil) {
        [DIALOG shareInstance];
    }
    m_Instance.pickerCallback = callback;
    //NSArray *arrAy = [[NSArray alloc]initWithObjects:@"11",@"22",@"33",@"44",@"55", nil];
    m_Instance.simplePickerView = [[SimplePickerView alloc]initWithOwner:[[UIApplication sharedApplication].delegate window] array:array delegate:m_Instance];
    [m_Instance.simplePickerView pushDatePicker];
}
-(void)PickerDidConfirm:(NSInteger)index
{
    _pickerCallback(index);
}
@end
