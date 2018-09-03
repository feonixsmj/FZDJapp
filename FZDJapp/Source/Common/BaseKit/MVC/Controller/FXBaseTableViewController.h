//
//  FXBaseTableViewController.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseViewController.h"

@interface FXBaseTableViewController : FXBaseViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL dontNeedRefresh;

- (CGRect)tableRect;

- (void)endRefreshing;
@end
