//
//  StatusBarMessage.m
//  状态栏
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 liujia. All rights reserved.
//

#import "StatusBarMessage.h"

@interface StatusBarMessage()
{
    UIWindow* _window;
}
+(id)sharedInstance;
@end


@implementation StatusBarMessage
+(void)show:(NSString*)message
{
    [self show:message textColor:[UIColor blackColor] backColor:[UIColor whiteColor]];
}
+(void)show:(NSString *)message textColor:(UIColor*)color
{
    [self show:message textColor:color backColor:[UIColor whiteColor]];
}

+(void)show:(NSString *)message textColor:(UIColor *)color backColor:(UIColor*)backColor
{
    [[StatusBarMessage sharedInstance] show:message textColor:color backColor:backColor];
}

-(void)show:(NSString*)message textColor:(UIColor*)color backColor:(UIColor*)backColor
{
    _window.hidden=NO;
    _window.backgroundColor=backColor;
    [UIView animateWithDuration:1 animations:^{
        _window.alpha=1;
    }];
    
    CGRect frame=[[UIScreen mainScreen] bounds];
    frame.size.height=20;
    UILabel* label=[[UILabel alloc] initWithFrame:frame];
    label.text=message;
    label.textColor=color;
    [_window addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            _window.alpha=0;
        }
                         completion:^(BOOL finished) {
                             _window.hidden=YES;
                         }];
        
        
    });
}


//-(void)show:(NSString*)message
//{
//    _window.hidden=NO;
//    [UIView animateWithDuration:1 animations:^{
//        _window.alpha=1;
//    }];
//    
//    CGRect frame=[[UIScreen mainScreen] bounds];
//    frame.size.height=20;
//    UILabel* label=[[UILabel alloc] initWithFrame:frame];
//    label.text=message;
//    label.textColor=[UIColor whiteColor];
//    
//    [_window addSubview:label];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [UIView animateWithDuration:1 animations:^{
//             _window.alpha=0;
//        }
//         completion:^(BOOL finished) {
//             _window.hidden=YES;
//         }];
//       
//        
//    });
//}
+(id)sharedInstance
{
    static StatusBarMessage* _t=nil;
    if (!_t) {
        _t=[[StatusBarMessage alloc] init];
    }
    return _t;
}

-(id)init
{
    self=[super init];
    if (self) {
        CGRect frame=[[UIScreen mainScreen] bounds];
        frame.size.height=20;
        _window=[[UIWindow alloc] initWithFrame:frame];
        _window.backgroundColor=[UIColor redColor];
        [_window makeKeyAndVisible];
        _window.windowLevel=UIWindowLevelStatusBar+1;
    }
    return self;
}




@end
