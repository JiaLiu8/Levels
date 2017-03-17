//
//  StatusBarMessage.m
//  状态栏
//
//  Created by liujia on 15/7/3.
//  Copyright (c) 2015年 liujia. All rights reserved.
//

#import "StatusBarMessage.h"

#define ScreenHight  [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define image_W_H (50*[[UIScreen mainScreen] bounds].size.height/568.0)

#define StautusBarHeight 100

@interface showMessageModel : NSObject
@property (copy, nonatomic) NSString *message;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *alertImage;
@end

@implementation showMessageModel

@end

@interface StatusBarMessage()
{
    UIWindow* _window;
    NSMutableArray *showQueue;
    UILabel *messageLabel;
    UIImageView *imageView;
}
@end

@implementation StatusBarMessage
+(void)show:(NSString*)message
{
    
    [self show:message textColor:[UIColor blackColor] backColor:[UIColor redColor] WithImage:nil];
    
}
+(void)show:(NSString *)message textColor:(UIColor*)color
{
    [self show:message textColor:color backColor:[UIColor redColor] WithImage:nil];
}

+(void)show:(NSString *)message textColor:(UIColor *)color backColor:(UIColor*)backColor
{
    [self show:message textColor:color backColor:[UIColor redColor] WithImage:nil];
}

+(void)show:(NSString *)message textColor:(UIColor *)color backColor:(UIColor*)backColor WithImage:(UIImage*)image
{
    [[StatusBarMessage sharedInstance] show:message textColor:color backColor:backColor WithImage:image];
}

-(void)show:(NSString*)message textColor:(UIColor*)color backColor:(UIColor*)backColor WithImage:(UIImage*)image
{
    showMessageModel *model = [showMessageModel new];
    model.message = message;
    model.alertImage = image;
    model.messageColor = color;
    model.backgroundColor = backColor;
    [showQueue addObject:model];
    if (showQueue.count == 1) {
        [[StatusBarMessage sharedInstance] showAlert];
    }
}

-(void)show:(showMessageModel*)messageModel
{
    BOOL hasImage = NO;
    [_window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [[[UIApplication sharedApplication].windows lastObject] addSubview:_window];
    _window.hidden = NO;
    _window.alpha = 1;
    _window.backgroundColor = messageModel.backgroundColor;
    
    if (messageModel.alertImage) {
        imageView.frame = CGRectMake(ScreenWidth*0.15,(StautusBarHeight-image_W_H)/2.0, image_W_H, image_W_H);
        imageView.image = messageModel.alertImage;
        hasImage = YES;
        [_window addSubview:imageView];
    }
    
    CGFloat messageLabelWidth = hasImage?(ScreenWidth-image_W_H-ScreenWidth*0.15)*0.8:ScreenWidth*0.7;
    CGFloat messageLabelX = hasImage?CGRectGetMaxX(imageView.frame)+10:ScreenWidth*0.15;
//  根据label的宽度和文字的长度 获取 label的高度
    CGFloat height = [self getLabelHeightWithMessage:messageModel.message WithFont:15.0f WithWidth:messageLabelWidth];
    
    CGFloat messageLabelY = 0.5*(StautusBarHeight-height);
    
    messageLabel.frame = CGRectMake(messageLabelX, messageLabelY, messageLabelWidth, height);
    [_window addSubview:messageLabel];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            _window.alpha=0;
        }
     completion:^(BOOL finished) {
         _window.hidden=YES;
         [showQueue removeObjectAtIndex:0];
         [[StatusBarMessage sharedInstance] showAlert];

     }];
    });
    
    
}

//  根据label的宽度和文字的长度 获取 label的高度
-(CGFloat)getLabelHeightWithMessage:(NSString*)message WithFont:(CGFloat)font WithWidth:(CGFloat)width
{
     CGRect frame = [message boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return frame.size.height;
}

-(void)showAlert
{
    if (showQueue.count>0) {
        [[StatusBarMessage sharedInstance] show:showQueue[0]];
    }
}

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
        frame.size.height=50;
        _window=[[UIWindow alloc] initWithFrame:frame];
        _window.backgroundColor=[UIColor redColor];
        [_window makeKeyAndVisible];
        showQueue = [NSMutableArray new];
        
        messageLabel = [[UILabel alloc] init];
        
        imageView = [[UIImageView alloc] init];
    }
    return self;
}



@end
