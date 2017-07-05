//
//  ListTableView.m
//  PCHDemo
//
//  Created by 张兆卿 on 2017/7/5.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import "ListTableView.h"

@implementation ListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
    }
    return self;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ctrlCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ListTableView class])];
    if (ctrlCell == nil) {
        ctrlCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ListTableView class])];
    }
    
    ctrlCell.textLabel.text = self.dataArr[indexPath.row];
    
    return ctrlCell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.pushBlock) {
        self.pushBlock(indexPath.row);
    }
}

@end
