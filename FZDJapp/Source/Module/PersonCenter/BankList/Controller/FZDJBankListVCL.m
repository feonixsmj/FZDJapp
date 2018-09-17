//
//  FZDJBankListVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankListVCL.h"
#import "FZDJBankListCell.h"
#import "FZDJBankListModel.h"
#import "FZDJBankCardVCL.h"

@interface FZDJBankListVCL () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@end

@implementation FZDJBankListVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJBankListModel alloc] init];
        self.isTransparentBar = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"银行卡";
    self.view.backgroundColor = [UIColor fx_colorWithHexString:@"#394960"];
    [self loadSubView];
    
    [self loadItem];
}

- (void)loadSubView{
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 108;
    self.tableView.backgroundColor = [UIColor fx_colorWithHexString:@"#394960"];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.mj_footer = nil;
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJBankListCell" bundle:nil] forCellReuseIdentifier:@"FZDJBankListCell"];
}

- (void)loadItem{
    
    [MBProgressHUD wb_showActivity];
    __weak typeof(self) weak_self = self;
    [self.model loadItem:nil success:^(NSDictionary *dict) {
        [weak_self endRefreshing];
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)deleteBankItem:(NSIndexPath *)indexPath{
    FZDJBanklistItem *item = self.model.items[indexPath.row];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userBankNo"] = item.vo.userBankNo;
    parameter[@"userNo"] = item.vo.userNo;
    
    FZDJBankListModel *model = (FZDJBankListModel *)self.model;
    [model deleteBankCardItem:parameter success:^(NSDictionary *dict) {
        
    } failure:^(NSError *error) {
        
    }];
}

- (UIBarButtonItem *)rightBarItem{
    if (!_rightBarItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *rightImage = [UIImage imageNamed:@"dj_bank_card_right_btn"];
        [btn setImage:rightImage forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        
        [btn addTarget:self action:@selector(rightBarButtonDidCliked)
      forControlEvents:UIControlEventTouchUpInside];
        btn.size = CGSizeMake(44, 44);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 00);
        _rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightBarItem;
}

- (void)rightBarButtonDidCliked{
    FZDJBankCardVCL *addBankCardVCL = [[FZDJBankCardVCL alloc] init];
    
    [self.navigationController pushViewController:addBankCardVCL animated:YES];
}

#pragma mark - ================ UITableViewDelegate ================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FZDJBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJBankListCell"];
    FZDJBanklistItem *item = self.model.items[indexPath.row];
    cell.item = item;
    return cell;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    __weak typeof(self) weak_self = self;
    UITableViewRowAction *delete =
            [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                               title:@"解除绑定"
                                             handler:^(UITableViewRowAction *_Nonnull action,NSIndexPath * _Nonnull indexPath) {
        [weak_self deleteBankItem:indexPath];
        [weak_self.model.items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    
    delete.backgroundColor = [UIColor fx_colorWithHexString:@"#E11313"];
    return@[delete];
}
@end
