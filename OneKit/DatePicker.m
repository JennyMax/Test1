//
//  DatePicker.m
//  DatePicker
//
//  Created by MAC on 15/3/30.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import "DatePicker.h"
//#import "OneKit.h"
#import "COLOR.h"
@implementation DatePicker

-(id)initWithSelectTitle:(NSString *)title viewOfDelegate:(UIView *)view delegate:(id<DatePickerDelegate>)delegate{
    if (self=[super init]) {
        _view=view;
        _delegate=delegate;
        _isBeforeTime=YES;
        _theTypeOfDatePicker=3;
        //生成日期选择器
        _backgroundview = [[UIView alloc]initWithFrame:CGRectMake(0, _view.bounds.size.height, _view.bounds.size.width, _view.bounds.size.height)];
        _backgroundview.backgroundColor = [UIColor clearColor];
        _datePickerView=[[UIView alloc] initWithFrame:CGRectMake(0,_view.bounds.size.height-_view.bounds.size.height*0.42243,_view.bounds.size.width,_view.bounds.size.height*0.42243)];
        //_datePickerView.backgroundColor=[UIColor grayColor];
        [_view addSubview:_backgroundview];
        
        _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,_view.bounds.size.height*0.07042,_view.bounds.size.width,_datePickerView.bounds.size.height-_view.bounds.size.height*0.07042)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        _datePicker.date =[NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        [_datePickerView addSubview:_datePicker];
        _navagationbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0,_view.bounds.size.width,_view.bounds.size.height*0.07042)];
        _dateCancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,_view.bounds.size.height*0.07042,_view.bounds.size.height*0.07042)];
        [_dateCancelButton setTitle:@"取消" forState:UIControlStateNormal];
        //_dateCancelButton.backgroundColor=[UIColor grayColor];
        _dateCancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_dateCancelButton addTarget:self action:@selector(poDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [_dateCancelButton setTitleColor:[COLOR parse:@"#3083FB"]forState:UIControlStateNormal];
        _dateCancelButton.center = _navagationbar.center;
        _dateConfirmButton=[[UIButton alloc] initWithFrame:CGRectMake(0,0,_view.bounds.size.height*0.07042,_view.bounds.size.height*0.07042)];
        _dateConfirmButton.center = _navagationbar.center;
        [_dateConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _dateConfirmButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_dateConfirmButton setTitleColor:[COLOR parse:@"#3083FB"]forState:UIControlStateNormal];
        //_dateConfirmButton.userInteractionEnabled=YES;
        [_dateConfirmButton addTarget:self action:@selector(dateConfirmClick) forControlEvents:UIControlEventTouchUpInside];
        //[_dateConfirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       // _dateConfirmButton.backgroundColor=[UIColor grayColor];
        [_datePickerView addSubview:_dateConfirmButton];
        //[_navagationbar setBackgroundColor:[UIColor redColor]];
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:_dateCancelButton];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:_dateConfirmButton];
        UINavigationItem *item = [[UINavigationItem alloc]init];
        item.leftBarButtonItem = left;
        item.rightBarButtonItem = right;
        _navagationbar.items = [[NSArray alloc]initWithObjects:item, nil];
        [_datePickerView addSubview:_navagationbar];
        [_backgroundview addSubview:_datePickerView];
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height-_datePickerView.frame.size.height)];
        _button.alpha = 0.1;
        _button.backgroundColor = [UIColor blackColor];
        [_button addTarget:self action:@selector(poDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundview addSubview:_button];
    }
    
    return self;
}
//确定选择
-(void)dateConfirmClick{
    NSString *string;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (_theTypeOfDatePicker==1) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        string = [dateFormatter stringFromDate:[_datePicker date]];
    }
    else if (_theTypeOfDatePicker==2){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        string = [dateFormatter stringFromDate:[_datePicker date]];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        string = [dateFormatter stringFromDate:[_datePicker date]];
    }
    [self.delegate DatePickerDidConfirm:string];
    [self poDatePicker];
    _datePicker.date =[NSDate date];
}
//是否可选择以前的时间
-(void)setIsBeforeTime:(BOOL)isBeforeTime{
    if (isBeforeTime==NO) {
        [_datePicker setMinimumDate:[NSDate date]];
    }
    else{
        [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
    }
}
//datePicker显示类别
-(void)setTheTypeOfDatePicker:(NSInteger)theTypeOfDatePicker{
    _theTypeOfDatePicker = theTypeOfDatePicker;
    if (theTypeOfDatePicker==1) {
        //只显示时间
        _datePicker.datePickerMode = UIDatePickerModeTime;
    }
    else if(theTypeOfDatePicker==2){
        //只显示日期
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    else if(theTypeOfDatePicker==3){
        //时间与日期都显示
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    else{
        NSLog(@"时间类别选择错误");
    }
}
#pragma mark pickerView动画效果
//出现
-(void)pushDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
//        _datePickerView.frame=CGRectMake(0,_view.bounds.size.height-_view.bounds.size.height*0.42243,_view.bounds.size.width,_view.bounds.size.height*0.42243);
        _backgroundview.frame = CGRectMake(0, 0, _view.bounds.size.width, _view.bounds.size.height);
    }];
}
//消失
-(void)poDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
//        _datePickerView.frame=CGRectMake(0,_view.bounds.size.height,_view.bounds.size.width,_view.bounds.size.height*0.42243);
        _backgroundview.frame = CGRectMake(0, _view.bounds.size.height, _view.bounds.size.width, _view.bounds.size.height);
    }];
}




-(void)dealloc{
    self.delegate=nil;
}



@end
