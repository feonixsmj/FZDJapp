//
//  FZDJMyWalletVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMyWalletVCL.h"
#import "FZDJMyWalletCashCell.h"
#import "FZDJMyWalletModel.h"
#import "FXImageView.h"
#import "FZDJAmountDetailsVCL.h"
#import "FZDJCashAdvanceVCL.h"
#import "FZDJSelectBankCardView.h"

@class FZDJDescribeCell;

@interface FZDJDescribeCell : UITableViewCell
@property (nonatomic, strong) FXImageView *lineImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

- (CGFloat)getHeight;
@end

@implementation FZDJDescribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customInit];
    }
    return self;
}

- (void) customInit{
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor fx_colorWithHexString:@"#333333"];
        label.text = @"提现说明";
        label;
    });
    
    self.descLabel = ({
        UILabel *label = [[UILabel alloc] init];
//        label.backgroundColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor fx_colorWithHexString:@"#333333"];
        label.text = @"";
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label;
    });

    self.lineImageView = ({
        FXImageView *view = [[FXImageView alloc] init];
        view.image = [UIImage imageNamed:@"wallet_xuxian"];
        view;
    });
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.lineImageView];
    
    [self layoutUI];
}

- (void)layoutUI{
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(30);
        make.height.mas_equalTo(1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView).offset(24);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(24);
        make.left.mas_equalTo(self.contentView.mas_left).offset(17);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-17);
    }];
    
}

- (CGFloat)getHeight{
    UILabel *label = self.descLabel;
    CGFloat padding = 17.0f;
    CGSize size = [label sizeThatFits:CGSizeMake(FX_SCREEN_WIDTH - padding*2,
                                                 CGFLOAT_MAX)];
    CGFloat blankHeight = 40.0f;
    CGFloat height = ceil(size.height + 63.0f + blankHeight);
    return height;
}


@end

@class FZDJPriceCell;

@interface FZDJPriceCell : UITableViewCell

@property (nonatomic, strong) UILabel *pricelabel1;
@property (nonatomic, strong) UILabel *pricelabel2;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIImageView *lineView;
@end

@implementation FZDJPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self customInit];
    }
    return self;
}

- (void) customInit{
    self.pricelabel1 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:22];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor fx_colorWithHexString:@"#FD7C31"];
        
        label;
    });
    
    self.pricelabel2 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:22];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor fx_colorWithHexString:@"#FD7C31"];
        
        label;
    });
    
    
    self.label1 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor fx_colorWithHexString:@"#666666"];
        label.text = @"未结算";
        label;
    });
    
    self.label2 = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor fx_colorWithHexString:@"#666666"];
        label.text = @"已结算";
        label;
    });
    
    self.lineView = ({
        UIImageView *view = [[UIImageView alloc] init];
        view.image = [UIImage imageNamed:@"dj_line_image"];
        view;
    });
    
    [self.contentView addSubview:self.pricelabel1];
    [self.contentView addSubview:self.pricelabel2];
    [self.contentView addSubview:self.label1];
    [self.contentView addSubview:self.label2];
    [self.contentView addSubview:self.lineView];
    
    [self layoutUI];
}

- (void)layoutUI{
    [self.pricelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(14);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(FX_SCREEN_WIDTH / 2);
    }];
    
    [self.pricelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(14);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(FX_SCREEN_WIDTH / 2);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.mas_equalTo(self.pricelabel1.mas_bottom).offset(11);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(FX_SCREEN_WIDTH / 2);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.mas_equalTo(self.pricelabel2.mas_bottom).offset(11);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(FX_SCREEN_WIDTH / 2);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

@end


@interface FZDJMyWalletVCL ()<UITableViewDelegate,
UITableViewDataSource,
FZDJMyWalletCashCellDelegate,
FZDJSelectBankCardViewDelegate>

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@property (nonatomic, strong) FZDJSelectBankCardView *selectBankCardView;
@end

@implementation FZDJMyWalletVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isTransparentBar = YES;
        self.model = [[FZDJMyWalletModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的钱包";
    self.dontNeedRefresh = YES;
    [self setupView];
    [self loadItem];
}

- (void)loadItem{
    FZDJMyWalletModel *model = (FZDJMyWalletModel *)self.model;
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
        weak_self.headerLabel.text = model.totalAmount;
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    [model loadCashAdvanceDesc:nil success:^(NSDictionary *dict) {
        [weak_self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)setupView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    CGRect rect = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCALE_ZOOM(195));
    self.headerImageView = [[UIImageView alloc] initWithFrame:rect];
    self.headerImageView.image = [UIImage imageNamed:@"wallet_bg"];
    [self.view addSubview:self.headerImageView];
    
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    [self.tableView registerClass:[FZDJPriceCell class]
                                forCellReuseIdentifier:@"FZDJPriceCell"];
    
    [self.tableView registerClass:[FZDJDescribeCell class]
                                forCellReuseIdentifier:@"FZDJDescribeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJMyWalletCashCell" bundle:nil]
            forCellReuseIdentifier:@"FZDJMyWalletCashCell"];
    
}

- (FZDJSelectBankCardView *)selectBankCardView{
    if (!_selectBankCardView) {
        FZDJSelectBankCardView *selectBankCardView = [[FZDJSelectBankCardView alloc] init];
        selectBankCardView.delegate = self;
        selectBankCardView.type = FZDJSelectTypeWeixin;
        _selectBankCardView = selectBankCardView;
    }
    return _selectBankCardView;
}

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
//        _tableHeaderView.alpha = 0.8;
        _tableHeaderView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH,
                                            FX_SCALE_ZOOM(195)-FX_NAVIGATIONBAR_TOTAL_SPAGE);
        
        CGFloat y = FX_SCREEN_WIDTH == 320 ? 10 : 30;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, FX_SCREEN_WIDTH, 30)];
        label.textColor = [UIColor whiteColor];
        label.text = @"";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:35];
        [_tableHeaderView addSubview:label];
        
        self.headerLabel = label;
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom + 10,
                                                                   FX_SCREEN_WIDTH, 20)];
        descLabel.textColor = [UIColor whiteColor];
        descLabel.text = @"总金额(元)";
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.font = [UIFont systemFontOfSize:15];
        [_tableHeaderView addSubview:descLabel];
        
    }
    return _tableHeaderView;
}

- (UIBarButtonItem *)rightBarItem{
    if (!_rightBarItem) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"明细" forState:UIControlStateNormal];
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
    FZDJAmountDetailsVCL *vcl = [[FZDJAmountDetailsVCL alloc] init];
    
    [self.navigationController pushViewController:vcl animated:YES];
}
#pragma mark - ================ delegate ================

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *itemObj = self.model.items[indexPath.row];
    
    if ([itemObj isKindOfClass:[FZDJPriceItem class]]) {
        FZDJPriceItem *item = (FZDJPriceItem *)itemObj;
        FZDJPriceCell *priceCell = [tableView
                        dequeueReusableCellWithIdentifier:@"FZDJPriceCell"];
        priceCell.pricelabel1.text = item.validAmountStr;
        priceCell.pricelabel2.text = item.useAmountStr;
        return priceCell;
    } else if ([itemObj isKindOfClass:[FZDJCashItem class]]){
        
        FZDJMyWalletCashCell *cashCell = [tableView
                        dequeueReusableCellWithIdentifier:@"FZDJMyWalletCashCell"];
        cashCell.delegate = self;
        return cashCell;
    } else{
        
        FZDJDescribeCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:@"FZDJDescribeCell"];
        FZDJMyWalletModel *model = (FZDJMyWalletModel *)self.model;
        NSString *htmlStr = model.cashAdvanceDesc;
        NSData *htmlData = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
        NSAttributedString *attrStr =
        [[NSAttributedString alloc] initWithData:htmlData
                                         options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                              documentAttributes:nil error:nil];
        
//        weak_self.contentLabel.attributedText = attrStr;
        cell.descLabel.attributedText = attrStr;
        return cell;
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *item = self.model.items[indexPath.row];
    if ([item isKindOfClass:[FZDJPriceItem class]]) {
        return 72;
    } else if ([item isKindOfClass:[FZDJCashItem class]]){
        return 75;
    } else{
        FZDJDescribeCell *cell = (FZDJDescribeCell *)[self.tableView dequeueReusableCellWithIdentifier:@"FZDJDescribeCell"];
        FZDJMyWalletModel *model = (FZDJMyWalletModel *)self.model;
        NSString *htmlStr = model.cashAdvanceDesc;
        NSData *htmlData = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
        NSAttributedString *attrStr =
        [[NSAttributedString alloc] initWithData:htmlData
                                         options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                              documentAttributes:nil error:nil];
        cell.descLabel.attributedText = attrStr;
        CGFloat height = [cell getHeight];
        return height;
    }
}

#pragma mark - ================ CashDelegate ================

- (void)withdrawMoney{
//    NSLog(@"我要提现");
    FZDJMyWalletModel *model = (FZDJMyWalletModel *)self.model;
    
//    FZDJCashAdvanceVCL *vcl = [[FZDJCashAdvanceVCL alloc] init];
//    vcl.totalAmount = model.totalAmount;
//
//    [self.navigationController pushViewController:vcl animated:YES];
    
    self.selectBankCardView.dataArray = model.bankList;
    [self.selectBankCardView show];
}

#pragma mark - ================ FZDJSelectBankCardViewDelegate  ================

- (void)FZDJSelectBankCardViewDidSelectedIndexPath:(NSIndexPath *)indexPath{
    FZDJMyWalletModel *model = (FZDJMyWalletModel *)self.model;
    FZDJCashAdvanceVCL *vcl = [[FZDJCashAdvanceVCL alloc] init];
    vcl.totalAmount = model.totalAmount;
    vcl.isWeixin = indexPath.row != 0;

    [self.navigationController pushViewController:vcl animated:YES];
}
@end

