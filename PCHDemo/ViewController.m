//
//  ViewController.m
//  PCHDemo
//
//  Created by 张兆卿 on 2017/7/5.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "ViewController.h"
#import "ListTableView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"PCHDemo";
    
    [self xs_creatSubView];
}

#pragma mark -创建并添加子视图
- (void)xs_creatSubView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    ListTableView *listTablView = [[ListTableView alloc]initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    listTablView.dataArr = @[@"第一个控制器", @"第二个控制器"];
    [self.view addSubview:listTablView];
    
    listTablView.pushBlock = ^(NSInteger row) {
        if (row == 0) {
            FirstViewController *firstCtrl = [[FirstViewController alloc]init];
            [self.navigationController pushViewController:firstCtrl animated:YES];
        } else {
            SecondViewController *secondCtrl = [[SecondViewController alloc]init];
            [self.navigationController pushViewController:secondCtrl animated:YES];
        }
    };
}

@end
