//
//  StatusBarMessage.h
//  状态栏
//
//  Created by qianfeng on 15/7/3.
//  Copyright (c) 2015年 liujia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface StatusBarMessage : NSObject
+(void)show:(NSString*)message;
+(void)show:(NSString *)message textColor:(UIColor*)color;
+(void)show:(NSString *)message textColor:(UIColor *)color backColor:(UIColor*)backColor;

@end
