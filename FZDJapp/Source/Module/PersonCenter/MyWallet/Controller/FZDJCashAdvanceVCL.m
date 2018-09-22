//
//  FZDJCashAdvanceVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//  提现

#import "FZDJCashAdvanceVCL.h"
#import "FZDJCashAdvanceAmountCell.h"
#import "FZDJCashAdvanceAddCardCell.h"
#import "FZDJCashAdvanceModel.h"
#import "FZDJSelectBankCardView.h"
#import "FZDJBankCardVCL.h"

@interface FZDJCashAdvanceVCL ()<UITableViewDelegate,
UITableViewDataSource,
FZDJSelectBankCardViewDelegate>
@property (nonatomic, strong) UIButton *statusButton;
@property (nonatomic, strong) FZDJSelectBankCardView *selectBankCardView;
@end

@implementation FZDJCashAdvanceVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [FZDJCashAdvanceModel new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    
    [self setupViews];
    [self loadItem];
}

- (void)setupViews{
    self.view.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJCashAdvanceAmountCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJCashAdvanceAmountCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJCashAdvanceAddCardCell" bundle:nil]
         forCellReuseIdentifier:@"FZDJCashAdvanceAddCardCell"];
    
     [self.view addSubview:self.statusButton];
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

- (UIButton *)statusButton{
    if (!_statusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"dj_advance_disable_btn"]
                forState:UIControlStateNormal];
        
        [button addTarget:self
                   action:@selector(advanceAction)
         forControlEvents:UIControlEventTouchUpInside];;
        
        CGRect rect = CGRectMake(10, 278,FX_SCREEN_WIDTH - 10 *2, 37);
        button.frame = rect;
        _statusButton = button;
    }
    return _statusButton;
}

- (FZDJSelectBankCardView *)selectBankCardView{
    if (!_selectBankCardView) {
        FZDJSelectBankCardView *selectBankCardView = [[FZDJSelectBankCardView alloc] init];
        selectBankCardView.delegate = self;
        _selectBankCardView = selectBankCardView;
    }
    return _selectBankCardView;
}

#pragma mark - ================ 提现 ================
- (void)advanceAction{
    //调用提现接口
//    [MBProgressHUD wb_showActivity];
    
    FZDJCashAdvanceModel *model = (FZDJCashAdvanceModel *)self.model;
    FZDJCashAdvanceAddCardItem *addCardItem = model.items[0];
    FZDJCashAdvanceAmountItem *amountItem = model.items[1];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userBankNo"] = addCardItem.vo.userBankNo;
    parameter[@"userNo"] = addCardItem.vo.userNo;
    parameter[@"amount"] = amountItem.advanceAmount;
    
//    __weak typeof(self) weak_self = self;
    [model addVance:parameter success:^(NSDictionary *dict) {
//        [weak_self endRefreshing];
        [MBProgressHUD wb_showSuccess:@"操作成功"];
    } failure:^(NSError *error) {
//        [weak_self endRefreshing];
        [MBProgressHUD wb_showError:error.errorMsg];
    }];
}

- (void)setEnableAdvance:(BOOL)enable{
    NSString *imageName = enable ? @"dj_advance_btn" :@"dj_advance_disable_btn";
    
    [self.statusButton setImage:[UIImage imageNamed:imageName]
                       forState:UIControlStateNormal];
    
    self.statusButton.userInteractionEnabled = enable;
}

#pragma mark - ================ UITableViewDelegate ================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FZDJCashAdvanceAddCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJCashAdvanceAddCardCell"];
        FZDJCashAdvanceAddCardItem *addCardItem = self.model.items[0];
        cell.item = addCardItem;
        return cell;
    } else{
        FZDJCashAdvanceAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJCashAdvanceAmountCell"];
        
        __weak typeof(self) weak_self = self;;
        cell.block = ^(BOOL isEnableAdvance) {
            [weak_self setEnableAdvance:isEnableAdvance];
        };
                       
        FZDJCashAdvanceAmountItem *item = self.model.items[1];
        item.totalAmount = self.totalAmount;
        cell.item = item;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 79;
    } else{
        return 155;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FZDJCashAdvanceModel *model = (FZDJCashAdvanceModel *)self.model;
        self.selectBankCardView.dataArray = model.bankList;
        [self.selectBankCardView show];
    }
}

#pragma mark - ================ FZDJSelectBankCardViewDelegate  ================

- (void)FZDJSelectBankCardViewDidSelectedIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //添加银行卡
        FZDJBankCardVCL *addBankCardVCL = [[FZDJBankCardVCL alloc] init];
        
        [self.navigationController pushViewController:addBankCardVCL animated:YES];
    } else {
        //选择银行
        FZDJCashAdvanceModel *model = (FZDJCashAdvanceModel *)self.model;
        FZDJBanklistItem *item = model.bankList[indexPath.row];
        
        FZDJCashAdvanceAddCardItem *addCardItem = self.model.items[0];
        addCardItem.iconUrl = item.iconUrl;
        addCardItem.bankName = item.bankName;
        addCardItem.bankDese = item.bankNumber;
        addCardItem.vo = item.vo;
        
        [self.tableView reloadData];
    }
}
@end
