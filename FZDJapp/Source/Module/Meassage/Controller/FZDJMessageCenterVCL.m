//
//  FZDJMessageCenterVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/3.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMessageCenterVCL.h"
#import "FZDJMessageCenterModel.h"
#import "FZDJMessageCenterCell.h"
#import "FZDJMessageCenterItem.h"
#import "FZDJTabBarController.h"
#import "UITabBar+FXBadge.h"

NSString *const FZDJMessageCenterCellIBName = @"FZDJMessageCenterCell";

@interface FZDJMessageCenterVCL ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
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
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    self.title =  @"消息";
    
    self.tableView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_TABLE_HEIGHT-FX_TABBAR_HEIGHT-FX_BOTTOM_SPAGE);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 101;
    
    [self.tableView registerNib:[UINib nibWithNibName:FZDJMessageCenterCellIBName
                                               bundle:[NSBundle mainBundle]]
                            forCellReuseIdentifier:FZDJMessageCenterCellIBName];
    [self loadItem];
    [self refreshUnreadMessageCount];
}

- (void)refreshUnreadMessageCount{
    FZDJTabBarController *rooterController = (FZDJTabBarController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    
    [rooterController requestMessageCount];
}


- (void)loadItem{
    FZDJMessageCenterModel *model = (FZDJMessageCenterModel *)self.model;
    
    __weak typeof(self) weak_self = self;
    
    [model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self endRefreshing];
        if (model.items.count > 0) {
            [weak_self.tableView reloadData];
        } else {
            weak_self.dontNeedRefresh = YES;
        }
        
    } failure:^(NSError *error) {
        [weak_self endRefreshing];
    }];
}


- (UIBarButtonItem *)rightBarItem{
    if (!_rightBarItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"全部已读" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        
        [btn addTarget:self action:@selector(rightBarButtonDidCliked)
        forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(60, 44);
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 00);
        _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBarItem;
}

- (void)rightBarButtonDidCliked{
    //全部已读
    FZDJMessageCenterModel *model = (FZDJMessageCenterModel *)self.model;
    __weak typeof(self) weak_self = self;
    
    [model readAllSuccess:^{
        for (FZDJMessageCenterItem *item in model.items) {
            item.isRead = YES;
        }
        [weak_self.tableView reloadData];
        
        FZDJTabBarController *rooterController = (FZDJTabBarController *)[[UIApplication sharedApplication].keyWindow rootViewController];
        [rooterController.tabBar hideBageOnItemIndex:2];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FZDJMessageCenterItem *item = self.model.items[indexPath.row];
    if (!item.isRead) {
        FZDJMessageCenterModel *model = (FZDJMessageCenterModel *)self.model;

        __weak typeof(self) weak_self = self;
        [model setMsgRead:item success:^(FZDJMessageCenterItem *tempItem) {
            tempItem.isRead = YES;
            [weak_self.tableView reloadData];
            
            FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
            FZDJTabBarController *rooterController = (FZDJTabBarController *)[[UIApplication sharedApplication].keyWindow rootViewController];
            
            [rooterController.tabBar showBageOnItemIndex:2 number:--dm.userInfo.messageCount];
        } failure:^(NSError *error) {
            
        }];
    }
}


@end
