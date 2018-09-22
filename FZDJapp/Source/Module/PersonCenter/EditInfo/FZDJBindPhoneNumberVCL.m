//
//  FZDJBindPhoneNumberVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJBindPhoneNumberVCL.h"
#import "FZDJBindPhoneNumberModel.h"
#import "FXSystemInfo.h"

@interface FZDJBindPhoneNumberVCL ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation FZDJBindPhoneNumberVCL

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = [[FZDJBindPhoneNumberModel alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定手机";
}


- (IBAction)buttonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    if (tag == 1) {
        //获取验证码
        [self getCode];
    } else {
        //立即绑定
        [self bindPhoneNumber];
    }
}

- (void)getCode{
    NSString *phoneNumber = self.phoneNumTextField.text;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = phoneNumber;
    
    FZDJBindPhoneNumberModel *model = (FZDJBindPhoneNumberModel *)self.model;
    
    [model getCodeNumber:parameter success:^(NSDictionary *dict) {
        
        [MBProgressHUD wb_showMessage:@"发送成功，请等待"];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - ================ 绑定手机号 ================
- (void)bindPhoneNumber{
    [self.view endEditing:YES];
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    dm.userInfo.loginType = FZDJUserInfoLoginTypePhone;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"code"] = self.codeTextField.text;
    parameter[@"userNo"] = dm.userInfo.userNo;
    parameter[@"phone"] = self.phoneNumTextField.text;
    
    __weak typeof(self) weak_self = self;
    FZDJBindPhoneNumberModel *model = (FZDJBindPhoneNumberModel *)self.model;
    [model bindPhoneNumber:parameter success:^(NSDictionary *dict) {
        [weak_self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

@end
