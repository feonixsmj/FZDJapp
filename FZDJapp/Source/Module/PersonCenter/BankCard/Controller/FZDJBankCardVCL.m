//
//  FZDJBankCardVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankCardVCL.h"
#import "FZDJBankCardModel.h"
#import "FZDJPersonalBlankCell.h"
#import "FZDJBankCardCell.h"
#import "FZDJBankCardIdentityCell.h"
#import "WXZPickCityView.h"
#import "WXZCustomPickView.h"

@interface FZDJBankCardVCL ()<UITableViewDelegate,
UITableViewDataSource,
PickerCityViewDelegate,
CustomPickViewDelegate>

@property (nonatomic, strong) WXZPickCityView *pickCityView;
@property (nonatomic, strong) WXZCustomPickView *pickBankView;
@property (nonatomic, copy) NSString *provinceStr;
@property (nonatomic, copy) NSString *cityStr;
@property (nonatomic, copy) NSString *bankAddress;
@property (nonatomic, copy) NSString *selectBankCodeStr;

@property (nonatomic, copy) NSString *bandCardNumber;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *idCard;

@property (nonatomic, strong) UIButton *statusButton;
@end

@implementation FZDJBankCardVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJBankCardModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dontNeedRefresh = YES;
    self.title = @"添加银行卡";
    self.view.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
    
    [self setupView];
    [self.view addSubview:self.statusButton];
    [self.view bringSubviewToFront:self.statusButton];
    [self loadItem];
}

- (void)loadItem{
    __weak typeof(self) weak_self = self;
    FZDJBankCardModel *model = (FZDJBankCardModel *)self.model;
    
    [model requestProvinceAndCity:^(NSArray *proviceArr, NSArray *cityArr) {
        weak_self.pickCityView.provinceArray = [NSMutableArray arrayWithArray:proviceArr];
        weak_self.pickCityView.cityArray = [NSMutableArray arrayWithArray:cityArr];;
        [weak_self.pickCityView reloadData];
    }];

}

-(void)selectBank{
    __weak typeof(self) weak_self = self;
    FZDJBankCardModel *model = (FZDJBankCardModel *)self.model;
    
    NSDictionary *dict = @{};
    if (self.provinceStr.length > 0 && self.cityStr.length >0) {
        dict = @{@"province":self.provinceStr,
                 @"city":self.cityStr
                 };
        
        [model loadBankAddress:dict success:^(NSDictionary *dict) {
            
            [weak_self.pickBankView setDataArray:[NSMutableArray arrayWithArray:model.bandAddressStrArr]];
            [weak_self.pickBankView setDefalutSelectRowStr:model.bandAddressStrArr.firstObject];
            [weak_self.pickBankView show];
        } failure:^(NSError *error) {
            
        }];
        
    }

}

- (void)setupView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor fx_colorWithHexString:@"F5F5F5"];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView registerClass:[FZDJPersonalBlankCell class] forCellReuseIdentifier:@"FZDJPersonalBlankCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJBankCardCell" bundle:nil] forCellReuseIdentifier:@"FZDJBankCardCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJBankCardIdentityCell" bundle:nil] forCellReuseIdentifier:@"FZDJBankCardIdentityCell"];
    
    [self.tableView reloadData];
}

- (void)buttonAction{
    //立即绑定
    BOOL fullInformation = YES;
    for (NSObject *obj in self.model.items) {
        if ([obj isKindOfClass:[FZDJBankCardIdentityItem class]]) {
            FZDJBankCardIdentityItem *item = (FZDJBankCardIdentityItem *)obj;
            if (item.content.length == 0) {
                fullInformation = NO;
                break;
            }
            if (item.type == FZDJBankCardIdentityItemTypeCardNumber) {
                self.bandCardNumber = item.content;
            }
            if (item.type == FZDJBankCardIdentityItemTypePhoneNumber) {
                self.phoneNumber = item.content;
            }
            if (item.type == FZDJBankCardIdentityItemTypeName) {
                self.userName = item.content;
            }
            if (item.type == FZDJBankCardIdentityItemTypeID) {
                self.idCard = item.content;
            }
        }
    }
    
    if (self.provinceStr.length > 0 && self.cityStr.length >0 &&
        fullInformation) {
        //调用绑定接口
        [self bindInfo];
    }
}

- (void)bindInfo{
    FZDJBankCardModel *model = (FZDJBankCardModel *)self.model;
    
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    muDict[@"bankCardNumber"] = self.bandCardNumber;
    muDict[@"bankCode"] = self.selectBankCodeStr;
    muDict[@"phone"] = self.phoneNumber;
    muDict[@"userName"] = self.userName;
    muDict[@"userNo"] = [FZDJDataModelSingleton sharedInstance].userInfo.userNo;
    muDict[@"idcard"] = self.idCard;
    
    __weak typeof(self) weak_self = self;
    [model bindInfo:muDict success:^(NSDictionary *dict) {
        [weak_self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view resignFirstResponder];
}

#pragma mark - ================ LazyLoad ================

- (UIButton *)statusButton{
    if (!_statusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"dj_bind_btn2"]
                forState:UIControlStateNormal];
        
        [button addTarget:self
                   action:@selector(buttonAction)
         forControlEvents:UIControlEventTouchUpInside];;
        
        CGRect rect = CGRectMake(10, FX_SCREEN_HEIGHT - FX_NAVIGATIONBAR_TOTAL_SPAGE-100,
                                 FX_SCREEN_WIDTH - 10 *2, 37);
        button.frame = rect;
        _statusButton = button;
    }
    return _statusButton;
}

- (WXZPickCityView *)pickCityView{
    if (!_pickCityView) {
        WXZPickCityView *pickerArea = [[WXZPickCityView alloc]init];
        pickerArea.delegate = self;
        
        _pickCityView = pickerArea;
    }
    return _pickCityView;
}

- (WXZCustomPickView *)pickBankView{
    if (!_pickBankView) {
        WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
        [pickerSingle setDelegate:self];
        _pickBankView = pickerSingle;
    }
    return _pickBankView;
}

#pragma mark - ================ tableDelegate ================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *obj = self.model.items[indexPath.row];
    
    if ([obj isKindOfClass:[FZDJBankCardIdentityItem class]]) {
        FZDJBankCardIdentityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJBankCardIdentityCell"];
        FZDJBankCardIdentityItem *item = (FZDJBankCardIdentityItem *)obj;
        cell.item = item;
        return cell;
        
    } else if ([obj isKindOfClass:[FZDJBankCardItem class]]){
        FZDJBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJBankCardCell"];
        FZDJBankCardItem *item = (FZDJBankCardItem *)obj;
        cell.item = item;
        return cell;
        
    } else {
        FZDJPersonalBlankCell *cell = [[FZDJPersonalBlankCell alloc] init];
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *obj = self.model.items[indexPath.row];
    if ([obj isKindOfClass:[FZDJPersonalBlankItem class]]) {
        return 20;
    } else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *obj = self.model.items[indexPath.row];
    if ([obj isKindOfClass:[FZDJBankCardItem class]]) {
        FZDJBankCardItem *item = (FZDJBankCardItem *)obj;
        if (item.type == FZDJBankCardItemTypeProvince) {
            [self.pickCityView show];
        } else {
            if (self.provinceStr.length == 0 || self.cityStr.length == 0) {
                NSLog(@"请选择省市");
            } else {
                [self selectBank];
            }
        }

        [self.view endEditing:YES];
    } else {
        return;
    }
}

#pragma mark - ================ PickerCityViewDelegate ================

-(void)pickerArea:(WXZPickCityView *)pickerArea selectProvince:(NSString *)province selectCity:(NSString *)city{
    self.provinceStr = province;
    self.cityStr = city;
    
    [self.model.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[FZDJBankCardItem class]]) {
            FZDJBankCardItem *bankCardItem = (FZDJBankCardItem *)obj;
            if (bankCardItem.type == FZDJBankCardItemTypeProvince) {
                bankCardItem.contentText = [NSString stringWithFormat:@"%@ %@",province,city];
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - ================ CustomPickViewDelegate ================
-(void)customPickView:(WXZCustomPickView *)customPickView selectedTitle:(NSString *)selectedTitle{
    self.bankAddress = selectedTitle;
    
    FZDJBankCardModel *model = (FZDJBankCardModel *)self.model;
    for (FZDJBankInfoVO *vo in model.bandInfoArr) {
        if ([vo.bankName isEqualToString:selectedTitle]) {
            self.selectBankCodeStr = vo.bankCode;
            break;
        }
    }
    
    [self.model.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[FZDJBankCardItem class]]) {
            FZDJBankCardItem *bankCardItem = (FZDJBankCardItem *)obj;
            if (bankCardItem.type == FZDJBankCardItemTypeBankAddress) {
                bankCardItem.contentText = selectedTitle;
                [self.tableView reloadData];
            }
        }
    }];
}
@end
