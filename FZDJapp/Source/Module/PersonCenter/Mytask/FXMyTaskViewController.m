//
//  FXMyTaskViewController.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/21.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXMyTaskViewController.h"
#import "FXMyTaskListCell.h"
#import "FXMyTaskModel.h"

const NSString *FXTaskCompleted = @"taskCompleted";
const NSString *FXTaskNoCompleted = @"taskNoCompleted";

@interface FXMyTaskViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FXMyTaskViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FXMyTaskModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (self.pageIdetify = ) {
//        <#statements#>
//    }
    NSLog(@"%@",self.pageIdetify);
    
    FXMyTaskModel *model = (FXMyTaskModel *)self.model;
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
    FXMyTaskModel *model = (FXMyTaskModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - ================ TableView Delegate ================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FXMyTaskListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FXMyTaskListCell"];
    FXMyTaskItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}


@end
