//
//  SecondViewController.m
//  PCHDemo
//
//  Created by 张兆卿 on 2017/7/5.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"第二个控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self xs_creatSubViews];
}

#pragma mark -创建并添加子视图
- (void)xs_creatSubViews {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
    alertButton.frame = CGRectMake(50, 300, width-50*2, 50);
    [alertButton setTitle:@"PCHAlert弹窗" forState:UIControlStateNormal];
    alertButton.layer.cornerRadius = 25;
    alertButton.layer.masksToBounds = YES;
    alertButton.backgroundColor = [UIColor redColor];
    [alertButton addTarget:self action:@selector(xs_alertAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:alertButton];
}

#pragma mark -弹窗按钮方法
- (void)xs_alertAction:(UIButton *)alertButton {
    
    /**
        此处使用了PCH文件中引入的全局很多地方都会用到的一个封装好的Alert弹窗
     */
    
    XSAlertViewController *alertCtrl = [XSAlertViewController alertControllerWithTitle:@"PCHAlert" message:@"这是一个PCH文件中引入的全项目很多地方都会用到的弹窗！"];
    alertCtrl.messageAlignment = NSTextAlignmentLeft;
    
    /** 
        该弹窗的按钮个数不做限制，想添加几个就按照下面的方式添加几个
     */
    
    XSAlertAction *update = [XSAlertAction actionWithTitle:@"确定" titleColor:0xF9694E handler:^(XSAlertAction *action) {
        // 让弹窗消失，不做任何处理
    }];
    [alertCtrl addAction:update];
    
    [self presentViewController:alertCtrl animated:NO completion:nil];
}

@end
