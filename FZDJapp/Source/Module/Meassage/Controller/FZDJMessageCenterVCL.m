//
//  FZDJMessageCenterVCL.m
//  FZDJapp
//
//  Created by autoreleasepool@163.com on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterVCL.h"
#import "FZDJMessageCenterModel.h"
#import "FZDJMessageCenterCell.h"
#import "FZDJMessageCenterItem.h"

NSString *const FZDJMessageCenterCellIBName = @"FZDJMessageCenterCell";

@interface FZDJMessageCenterVCL ()<UITableViewDelegate,
UITableViewDataSource>

@end

@implementation FZDJMessageCenterVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJMessageCenterModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title =  @"消息中心";
    
    self.tableView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 101;
//    [self.tableView registerClass:[FZDJMessageCenterCell class]
//           forCellReuseIdentifier:FZDJMessageCenterCellIBName];
    
    [self.tableView registerNib:[UINib nibWithNibName:FZDJMessageCenterCellIBName
                                               bundle:[NSBundle mainBundle]]
                            forCellReuseIdentifier:FZDJMessageCenterCellIBName];
    
    [self loadItem];
}

- (void)loadItem{
    FZDJMessageCenterModel *model = (FZDJMessageCenterModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ================ UITableViewDelegate ================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FZDJMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:FZDJMessageCenterCellIBName];
    FZDJMessageCenterItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}



@end
