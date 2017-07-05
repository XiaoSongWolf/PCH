//
//  UIButton+Common.m
//  Onlinecourt
//
//  Created by 张兆卿 on 2017/3/9.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "UIButton+Common.h"
#import <objc/runtime.h>

@implementation UIButton (Common)

#pragma mark -设置按钮下划线是否显示 ---去掉ios8.1系统按钮样式下的button下划线
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark -倒计时按钮设置
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitleColor:mColor forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"重新获取（%@%@）",timeStr,subTitle] forState:UIControlStateNormal];
                [self setTitleColor:color forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -设置按钮的文字和图片的样式
- (void)layoutButtonWithButtonEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style WithImageAndTitleSpace:(CGFloat)space {
    // 1.获取image的宽高
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    // 2.获取lable的宽高
    CGFloat lableWidth = 0;
    CGFloat lableHeght = 0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        lableWidth = self.titleLabel.intrinsicContentSize.width;
        lableHeght = self.titleLabel.intrinsicContentSize.height;
        
    } else {
        lableWidth = self.titleLabel.frame.size.width;
        lableHeght = self.titleLabel.frame.size.height;
    }
    
    // 3.初始化标题和图片的边际
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case ButtonEdgeInsetsStyleTop:
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight - space / 2.0, 0);
            imageEdgeInsets = UIEdgeInsetsMake(-lableHeght - space / 2.0, 0, 0, -lableWidth);
            
            break;
        case ButtonEdgeInsetsStyleBottom:
            titleEdgeInsets = UIEdgeInsetsMake(-imageHeight - space / 2.0, -imageWidth, 0, 0);
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -lableHeght - space / 2.0, -lableWidth);
            
            break;
        case ButtonEdgeInsetsStyleLeft:
            titleEdgeInsets = UIEdgeInsetsMake(0,space / 2.0, 0,-space / 2.0);
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            
            break;
        case ButtonEdgeInsetsStyleRight:
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - space / 2.0, 0, imageWidth + space / 2.0);
            imageEdgeInsets = UIEdgeInsetsMake(0, lableWidth + space / 2.0,0, -lableWidth - space / 2.0);
            
            break;
            
        default:
            break;
    }
    
    self.titleEdgeInsets = titleEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

static char overviewKey;

- (NSNumber *)titleFont {
    return objc_getAssociatedObject(self, &overviewKey);
}

- (void)setTitleFont:(NSNumber *)titleFont {
    objc_setAssociatedObject(self, &overviewKey, titleFont, OBJC_ASSOCIATION_RETAIN);
    self.titleLabel.font = [UIFont systemFontOfSize:[titleFont intValue]];
}

@end
