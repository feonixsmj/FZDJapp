//
//  FZDJAmountDetailsVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/11.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAmountDetailsVCL.h"
#import "FZDJAmountDetailsModel.h"
#import "FZDJAmountDetailsCell.h"

@interface FZDJAmountDetailsVCL ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FZDJAmountDetailsVCL


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJAmountDetailsModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"金额明细";
    [self initUI];
    [self loadItem];
}

- (void)loadItem{
    FZDJAmountDetailsModel *model = (FZDJAmountDetailsModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
        if (model.items.count > 0) {
            [weak_self.tableView reloadData];
        } else {
            weak_self.dontNeedRefresh = YES;
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)initUI{
    
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJAmountDetailsCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJAmountDetailsCell"];
}

#pragma mark - ================ UITableViewDelegate ================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FZDJAmountDetailsCell *cell = [tableView
                    dequeueReusableCellWithIdentifier:@"FZDJAmountDetailsCell"];
    
    FZDJAmountDetailsItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}

@end
