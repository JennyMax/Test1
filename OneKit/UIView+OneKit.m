#import <QuartzCore/QuartzCore.h>
#import "UIView+OneKit.h"
#import "UIImage+OneKit.h"
@implementation UIView (OneKit)
- (UIImage*)blur:(UIView*)backgroundView
{
    if(&UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO,0.5);
    } else {
        //UIGraphicsBeginImageContext(self.frame.size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint offset = ([backgroundView isKindOfClass:[UIScrollView class]]?((UIScrollView*)backgroundView).contentOffset:CGPointZero);
    CGContextTranslateCTM(context, offset.x, -offset.y-self.frame.origin.y);
    [backgroundView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    image = [image blur];
    UIGraphicsEndImageContext();
    return image;
}
- (void)clear
{
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }
}
/*
- (UIViewController *)viewController
{
    UIViewController *result;
    
    UIWindow *topWindow =  self.window;
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
	
    return result;
}*/
@end
