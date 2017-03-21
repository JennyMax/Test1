//
//  SimplePickerView.m
//  OneKitDome
//
//  Created by HeYanTao on 15/9/29.
//  Copyright © 2015年 vip_limited. All rights reserved.
//

#import "SimplePickerView.h"
//#import "OneKit.h"
#import "COLOR.h"
@interface SimplePickerView()
@property NSArray *array;
@end
@implementation SimplePickerView

-(id)initWithOwner:(UIView*)view array:(NSArray*)array delegate:(id<SimplePickerViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.array = array;
        _view = view;
        _delegate=delegate;
        _background = [[UIView alloc]initWithFrame:CGRectMake(0,_view.frame.size.height, _view.frame.size.width, _view.frame.size.height)];
        _background.backgroundColor = [UIColor clearColor];
        [_view addSubview:_background];
        _pickerview = [[UIView alloc]initWithFrame:CGRectMake(0,_view.bounds.size.height-_view.bounds.size.height*0.42243,_view.bounds.size.width,_view.bounds.size.height*0.42243)];
        //_pickerview.backgroundColor = [UIColor grayColor];
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,_view.bounds.size.height*0.07042+1,_view.bounds.size.width,_pickerview.frame.size.height-_view.bounds.size.height*0.07042)];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.backgroundColor = [UIColor whiteColor];
        _navagationbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0,_view.bounds.size.width,_view.bounds.size.height*0.07042)];
         _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,_view.bounds.size.height*0.07042,_view.bounds.size.height*0.07042)];
         [_cancelButton setTitleColor:[COLOR parse:@"#3083FB"]forState:UIControlStateNormal];
        //_cancelButton.backgroundColor=[UIColor grayColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
         [_cancelButton addTarget:self action:@selector(poDatePicker) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton=[[UIButton alloc] initWithFrame:CGRectMake(0,0,_view.bounds.size.height*0.07042,_view.bounds.size.height*0.07042)];
         [_confirmButton setTitleColor:[COLOR parse:@"#3083FB"]forState:UIControlStateNormal];
        //_confirmButton.backgroundColor=[UIColor grayColor];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
         [_confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:_cancelButton];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:_confirmButton];
        UINavigationItem *item = [[UINavigationItem alloc]init];
        item.leftBarButtonItem = left;
        item.rightBarButtonItem = right;
        _navagationbar.items = [[NSArray alloc]initWithObjects:item, nil];
        [_pickerview addSubview:_navagationbar];
        _headButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height-_pickerview.frame.size.height)];
        _headButton.alpha = 0.1;
        _headButton.backgroundColor = [UIColor blackColor];
        [_headButton addTarget:self action:@selector(poDatePicker) forControlEvents:UIControlEventTouchUpInside];
        //[_pickerview addSubview:_cancelButton];
        //[_pickerview addSubview:_confirmButton];
        [_pickerview addSubview:_picker];
        [_background addSubview:_pickerview];
        [_background addSubview:_headButton];
    }
    return self;
}
-(void)pushDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
        //        _datePickerView.frame=CGRectMake(0,_view.bounds.size.height-_view.bounds.size.height*0.42243,_view.bounds.size.width,_view.bounds.size.height*0.42243);
        _background.frame = CGRectMake(0, 0, _view.bounds.size.width, _view.bounds.size.height);
    }];
}
//消失
-(void)poDatePicker{
    [UIView animateWithDuration:0.3 animations:^{
        //        _datePickerView.frame=CGRectMake(0,_view.bounds.size.height,_view.bounds.size.width,_view.bounds.size.height*0.42243);
        _background.frame = CGRectMake(0, _view.bounds.size.height, _view.bounds.size.width, _view.bounds.size.height);
    }];
}
-(void)confirmClick{
    [self.delegate PickerDidConfirm:[_picker selectedRowInComponent:0]];
    [self poDatePicker];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.array.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.array objectAtIndex:row];
}
@end
