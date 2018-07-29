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
        label.text = @"        如果圣诞节方式东方三等奖速度快放假洛杉矶快分手快乐飞机类似定金开发商两地分居深刻的积分了斯柯达尖峰时刻加时都福克斯京东方深刻的积分隆盛科技地方上岛咖啡连锁店发生了\n\n\n      世纪东方是地方是是是否水电费费地方的房贷发地方的房贷防守打法两三点积分上来的会计法螺蛳粉是发送到";
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
    CGFloat height = ceil(size.height + 63.0f);
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
FZDJMyWalletCashCellDelegate>

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
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
    
    [self setupView];
    [self loadItem];
}

- (void)loadItem{
    FZDJMyWalletModel *model = (FZDJMyWalletModel *)self.model;
    __weak typeof(self) weak_self = self;
    [model loadItem:nil success:^(NSDictionary *dict) {
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

- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
//        _tableHeaderView.alpha = 0.8;
        _tableHeaderView.frame = CGRectMake(0, 0, FX_SCREEN_WIDTH, FX_SCALE_ZOOM(195)-FX_NAVIGATIONBAR_TOTAL_SPAGE);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, FX_SCREEN_WIDTH, 20)];
        label.textColor = [UIColor whiteColor];
        label.text = @"18.50";
        label.textAlignment = NSTextAlignmentCenter;
        [_tableHeaderView addSubview:label];
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
    
    NSObject *item = self.model.items[indexPath.row];
    
    if ([item isKindOfClass:[FZDJPriceItem class]]) {
        FZDJPriceCell *priceCell = [tableView
                        dequeueReusableCellWithIdentifier:@"FZDJPriceCell"];
        priceCell.pricelabel1.text = @"238.30";
        priceCell.pricelabel2.text = @"413.10";
        return priceCell;
    } else if ([item isKindOfClass:[FZDJCashItem class]]){
        
        FZDJMyWalletCashCell *cashCell = [tableView
                        dequeueReusableCellWithIdentifier:@"FZDJMyWalletCashCell"];
        cashCell.delegate = self;
        return cashCell;
    } else{
        
        FZDJDescribeCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:@"FZDJDescribeCell"];
        
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
        CGFloat height =  [cell getHeight];
        return height;
    }
}

#pragma mark - ================ CashDelegate ================

- (void)withdrawMoney{
    NSLog(@"我要提现");
}
@end

