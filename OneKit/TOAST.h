//
//  TOAST.h
//  OneKit
//
//  Created by HeYanTao on 15/9/23.
//  Copyright © 2015年 张瑾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TOAST : NSObject
{
    NSString *text;
    UIButton *contentView;
    CGFloat  duration;
}
//+ (void)showWithText:(NSString *) text_;
//+ (void)showWithText:(NSString *) text_
//            duration:(CGFloat)duration_;
//
//+ (void)showWithText:(NSString *) text_
//           topOffset:(CGFloat) topOffset_;
//+ (void)showWithText:(NSString *) text_
//           topOffset:(CGFloat) topOffset
//            duration:(CGFloat) duration_;

+ (void)showWithText:(NSString *) text_
        bottomOffset:(CGFloat) bottomOffset_;
//+ (void)showWithText:(NSString *) text_
//        bottomOffset:(CGFloat) bottomOffset_
//            duration:(CGFloat) duration_;

@end
