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
#import "FZDJIDCardCell.h"
#import "FZDJAppealSelectPhotoStrategy.h"
#import "FZDJUploadImageModel.h"

@interface FZDJBankCardVCL ()<UITableViewDelegate,
UITableViewDataSource,
PickerCityViewDelegate,
CustomPickViewDelegate>

@property (nonatomic, strong) WXZPickCityView *pickCityView;
@property (nonatomic, strong) WXZCustomPickView *pickBankView;
@property (nonatomic, strong) WXZCustomPickView *pickOrgBankView;
@property (nonatomic, strong) FZDJAppealSelectPhotoStrategy *photoStrategy;
@property (nonatomic, strong) FZDJUploadImageModel *uploadImageModel;
@property (nonatomic, copy) NSString *provinceStr;
@property (nonatomic, copy) NSString *cityStr;
@property (nonatomic, copy) NSString *bankOrgName;
@property (nonatomic, copy) NSString *bankAddress;
@property (nonatomic, copy) NSString *selectBankCodeStr;

@property (nonatomic, copy) NSString *bandCardNumber;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *idCard;

@property (nonatomic, strong) UIButton *statusButton;
@property (nonatomic, weak) UIButton *IDCardCellBtn;

@property (nonatomic, copy) NSString *idCardFront;
@property (nonatomic, copy) NSString *idCardBack;
@property (nonatomic, copy) NSString *personPhoto;
@property (nonatomic, copy) NSString *bankCardFront;
@end

@implementation FZDJBankCardVCL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[FZDJBankCardModel alloc] init];
        self.photoStrategy = [[FZDJAppealSelectPhotoStrategy alloc] initWithTarget:self];
        self.uploadImageModel = [[FZDJUploadImageModel alloc] init];
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

-(void)selectOrgBank{
    __weak typeof(self) weak_self = self;
    FZDJBankCardModel *model = (FZDJBankCardModel *)self.model;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.provinceStr.length > 0 && self.cityStr.length >0) {
        dict[@"province"] = self.provinceStr;
        dict[@"city"] = self.cityStr;
        
        [model loadOrgBankAddress:dict success:^(NSDictionary *dict) {
            
            [weak_self.pickOrgBankView setDataArray:model.bankOrgStrArr];
            [weak_self.pickOrgBankView setDefalutSelectRowStr:model.bankOrgStrArr.firstObject];
            [weak_self.pickOrgBankView show];
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

-(void)selectBank{
    __weak typeof(self) weak_self = self;
    FZDJBankCardModel *model = (FZDJBankCardModel *)self.model;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.provinceStr.length > 0 && self.cityStr.length >0) {
        dict[@"province"] = self.provinceStr;
        dict[@"city"] = self.cityStr;
        dict[@"bankOrgName"] = self.bankOrgName;
        
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FZDJIDCardCell" bundle:nil] forCellReuseIdentifier:@"FZDJIDCardCell"];
    
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
    
    if (fullInformation && self.provinceStr.length > 0 && self.cityStr.length >0
        && self.bankOrgName.length >0 && self.bankAddress.length > 0 ) {
        //调用绑定接口
        [self bindInfo];
    } else {
        [MBProgressHUD wb_showError:@"请填写完整信息"];
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
    muDict[@"idCardFront"] = self.idCardFront;
    muDict[@"idCardBack"] = self.idCardBack;
    muDict[@"personPhoto"] = self.personPhoto;
    muDict[@"bankCardFront"] = self.bankCardFront;
    
    __weak typeof(self) weak_self = self;
    [model bindInfo:muDict success:^(NSDictionary *dict) {
        [MBProgressHUD wb_showSuccess:@"银行卡添加成功"];
//        [weak_self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view resignFirstResponder];
}

#pragma mark - ================ 上传照片 ================
- (void)uploadImage:(UIImage *)image{
    
    NSData *data = UIImageJPEGRepresentation(image, 0.3f);
    
    NSInteger len = data.length / 1024;
    if (len > 512) {
        [MBProgressHUD wb_showError:@"单图不能大于512KB"];
        return ;
    }
    NSString *base64ImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    base64ImageStr = [base64ImageStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    base64ImageStr = [NSString stringWithFormat:@"data:image/jpg;base64,%@",base64ImageStr];
    [self.IDCardCellBtn setImage:image forState:UIControlStateNormal];
    
    switch (self.IDCardCellBtn.tag) {
        case 1:
            self.idCardFront = base64ImageStr;
            break;
        case 2:
            self.idCardBack = base64ImageStr;
            break;
        case 3:
            self.personPhoto = base64ImageStr;
            break;
        case 4:
            self.bankCardFront = base64ImageStr;
            break;
            
        default:
            break;
    }

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
        
        CGRect rect = CGRectMake(10, FX_SCREEN_HEIGHT - FX_NAVIGATIONBAR_TOTAL_SPAGE-57,
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

- (WXZCustomPickView *)pickOrgBankView{
    if (!_pickOrgBankView) {
        WXZCustomPickView *pickerSingle = [[WXZCustomPickView alloc]init];
        [pickerSingle setDelegate:self];
        _pickOrgBankView = pickerSingle;
    }
    return _pickOrgBankView;
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
        
    } else if ([obj isKindOfClass:[FZDJIDCardItem class]]){
        FZDJIDCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FZDJIDCardCell"];
        __weak typeof(self) weak_self = self;
        cell.takePhotoblock = ^(UIButton *btn) {
            [weak_self.photoStrategy presentSelectPhotoAlertView];
            weak_self.IDCardCellBtn = btn;
        };
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
    } else if ([obj isKindOfClass:[FZDJIDCardItem class]]){
        CGFloat height = 44 + FX_SCALE_ZOOM(140)*2 +16+25+215;
        return height;
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
        } else if (item.type == FZDJBankCardItemTypeOrgBankName) {
            if (self.provinceStr.length == 0 || self.cityStr.length == 0) {
                NSLog(@"请选择省市");
            } else {
                [self selectOrgBank];
            }
        }
        
        else {
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
    if (customPickView == self.pickOrgBankView) {
        self.bankOrgName = selectedTitle;
        
        [self.model.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[FZDJBankCardItem class]]) {
                FZDJBankCardItem *bankCardItem = (FZDJBankCardItem *)obj;
                if (bankCardItem.type == FZDJBankCardItemTypeOrgBankName) {
                    bankCardItem.contentText = selectedTitle;
                    [self.tableView reloadData];
                }
            }
        }];
        return;
    }
    
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
