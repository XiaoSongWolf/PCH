//
//  UIButton+Common.h
//  Onlinecourt
//
//  Created by 张兆卿 on 2017/3/9.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ButtonEdgeInsetsStyle){
    
    ButtonEdgeInsetsStyleTop = 0,   // image在上 lable 在下
    ButtonEdgeInsetsStyleBottom,    // image在下 lable 在上
    ButtonEdgeInsetsStyleLeft,      // image在左 lable 在右
    ButtonEdgeInsetsStyleRight,     // image在右 lable 在左
    
};

@interface UIButton (Common)

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    倒计时结束后显示的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的字体颜色
 *  @param color    倒计时中的字体颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 *  设置button中ImageView，lable 的布局
 *
 *  @param style 类型
 *  @param space 间距
 */
- (void)layoutButtonWithButtonEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style WithImageAndTitleSpace:(CGFloat)space;

/**
 *  标题大小
 */
@property (strong, nonatomic) NSNumber *titleFont;

@end
