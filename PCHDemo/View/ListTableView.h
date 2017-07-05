//
//  ListTableView.h
//  PCHDemo
//
//  Created by 张兆卿 on 2017/7/5.
//  Copyright © 2017年 xiaoSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

/** 展示的数据 */
@property (strong, nonatomic) NSArray *dataArr;

@property (copy, nonatomic) void(^pushBlock)(NSInteger row);

@end
