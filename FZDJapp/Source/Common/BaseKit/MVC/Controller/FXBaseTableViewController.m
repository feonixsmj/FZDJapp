//
//  FXBaseTableViewController.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseTableViewController.h"

@interface FXBaseTableViewController ()

@end

@implementation FXBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
}


- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:[self tableRect] style:UITableViewStylePlain];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    
    self.tableView = tableView;
    self.dontNeedRefresh = NO;
    
    [self.view addSubview:self.tableView];
}

- (void)setDontNeedRefresh:(BOOL)dontNeedRefresh{
    _dontNeedRefresh = dontNeedRefresh;
    
    if (dontNeedRefresh) {
        self.tableView.mj_header.hidden = YES;
        self.tableView.mj_footer.hidden = YES;
    } else {
        __weak typeof(self) weak_self = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak_self.model clean];
            [weak_self loadItem];
        }];
        
        self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weak_self loadItem];
        }];
    }
}


-(void)endRefreshing {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (CGRect)tableRect{
    if (self.isTransparentBar) {
       return CGRectMake(0, FX_NAVIGATIONBAR_TOTAL_SPAGE, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
    }
    return CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
