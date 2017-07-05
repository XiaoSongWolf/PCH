//
//  XSAlertViewController.h
//  Onlinecourt
//
//  Created by 张兆卿 on 2017/3/7.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(NSInteger)titleColor handler:(void (^)(XSAlertAction *action))handler;

/** 按钮文字 */
@property (nonatomic, readonly) NSString *title;
/** 按钮文字颜色 */
@property (assign, nonatomic) NSInteger titleColor;

@end

@interface XSAlertViewController : UIViewController

/** 按钮 */
@property (nonatomic, readonly) NSArray<XSAlertAction *> *actions;
/** 标题 */
@property (copy, nonatomic) NSString *title;
/** 展示内容 */
@property (copy, nonatomic) NSString *message;
/** 展示内容的对齐方式 */
@property (assign, nonatomic) NSTextAlignment messageAlignment;

/**
 创建一个自定义AlertView

 @param title 标题
 @param message 展示内容
 @return return value description
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

/**
 添加一个自定义按钮到自定义的AlertView上面

 @param action 需要添加的自定义按钮
 */
- (void)addAction:(XSAlertAction *)action;

@end
