//
//  FXMyTaskViewController.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXMyTaskViewController.h"
#import "FXMyTaskListCell.h"
#import "FZDJMyTaskModel.h"
#import "FZDJAppealViewController.h"

const NSString *FXTaskCompleted = @"YWC";
const NSString *FXTaskNoCompleted = @"WWC";

@interface FXMyTaskViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FXMyTaskViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJMyTaskModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FZDJMyTaskModel *model = (FZDJMyTaskModel *)self.model;
    model.pageIdentify = self.pageIdetify;
    
    [self initUI];
    [self loadItem];
}


- (void)initUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 116;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FXMyTaskListCell" bundle:nil]
         forCellReuseIdentifier:@"FXMyTaskListCell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadItem{
    FZDJMyTaskModel *model = (FZDJMyTaskModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
        [weak_self endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - ================ TableView Delegate ================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FXMyTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FXMyTaskListCell"];
    FZDJMyTaskItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FZDJMyTaskItem *item = self.model.items[indexPath.row];
    FZDJAppealViewController *appealVCL = [[FZDJAppealViewController alloc] init];
    appealVCL.taskItem = item;
    
    [self.navigationController pushViewController:appealVCL animated:YES];
    
}

@end
