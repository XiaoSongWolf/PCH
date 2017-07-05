//
//  FirstViewController.m
//  PCHDemo
//
//  Created by 张兆卿 on 2017/7/5.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *inputTextField;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"第一个控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self xs_creatSubViews];
}

#pragma amrk -创建并添加子视图
- (void)xs_creatSubViews {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 130, width - 50*2, 45)];
    _inputTextField.delegate = self;
    _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    _inputTextField.placeholder = @"请输入手机号";
    _inputTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.view addSubview:_inputTextField];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(50, 260, width-50*2, 50);
    [testButton setTitle:@"验证" forState:UIControlStateNormal];
    testButton.layer.cornerRadius = 25;
    testButton.layer.masksToBounds = YES;
    testButton.backgroundColor = [UIColor redColor];
    [testButton addTarget:self action:@selector(xs_testAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:testButton];
}

#pragma mark -验证按钮方法
- (void)xs_testAction:(UIButton *)testButton {
    
    /**
        此处使用了在PCH文件中引入的两个类， 一个是UIButton+Common的按钮分类，一个是工具类；
        按钮分类让按钮不管当前系统中按钮状态是什么，都显示是一样的；
        工具类验证了手机号的合法性，并给予了提示。
     */
    
    if (_inputTextField.text.length <= 0) {
        [XSYUtils warningView:self.view withTitle:@"您未输入任何内容~" withTextField:nil];
    } else if ([XSYUtils isMobileNumber:_inputTextField.text]) {
        [XSYUtils warningView:self.view withTitle:@"您输入的手机号是合法的~" withTextField:nil];
    } else {
        [XSYUtils warningView:self.view withTitle:@"您输入的手机号不合法，请重新输入~" withTextField:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 退出键盘
    [_inputTextField resignFirstResponder];
}

@end
