//
//  FXBaseTableViewController.h
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseViewController.h"

@interface FXBaseTableViewController : FXBaseViewController

@property (nonatomic, strong) UITableView *tableView;

- (CGRect)tableRect;
@end
