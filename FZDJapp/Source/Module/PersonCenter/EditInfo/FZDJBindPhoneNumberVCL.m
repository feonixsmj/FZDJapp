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
#import "UIViewController+BackButtonHandler.h"

@interface FZDJBindPhoneNumberVCL ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

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


- (void)backButtonAction{
    [self invalidateTimer];
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
    if (self.phoneNumTextField.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入手机号"];
        return;
    }
    
    [self.getCodeButton setTitle:@"(60s)后重发" forState:UIControlStateNormal];
    self.getCodeButton.alpha = 0.5;
    //    self.getCodeButton.backgroundColor = [UIColor grayColor];
    self.getCodeButton.userInteractionEnabled = NO;
    
    if (!self.timer) {
        self.time = 60;
        self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    NSString *phoneNumber = self.phoneNumTextField.text;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = phoneNumber;
    
    __weak typeof(self) weak_self = self;
    FZDJBindPhoneNumberModel *model = (FZDJBindPhoneNumberModel *)self.model;
    
    [model getCodeNumber:parameter success:^(NSDictionary *dict) {
        [MBProgressHUD wb_showMessage:@"发送成功，请等待"];
    } failure:^(NSError *error) {
        [weak_self invalidateTimer];
        [weak_self.getCodeButton setTitle:@"获取验证码"
                                 forState:UIControlStateNormal];
    }];
}

- (void)timerAction{
    self.time --;
    if (self.time < 0) {
        [self.getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self invalidateTimer];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"(%lds)后重发",self.time];
    [self.getCodeButton setTitle:title forState:UIControlStateNormal];
}

- (void)invalidateTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        self.getCodeButton.alpha = 1;
        //        self.getCodeButton.backgroundColor = [UIColor whiteColor];
        self.getCodeButton.userInteractionEnabled = YES;
    }
}


#pragma mark - ================ 绑定手机号 ================
- (void)bindPhoneNumber{
    [self.view endEditing:YES];
    
    if (self.phoneNumTextField.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入手机号"];
        return;
    } else if (self.codeTextField.text.length == 0){
        [MBProgressHUD wb_showError:@"请输入验证码"];
        return;
    }
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    dm.userInfo.loginType = FZDJUserInfoLoginTypePhone;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"code"] = self.codeTextField.text;
    parameter[@"userNo"] = dm.userInfo.userNo;
    parameter[@"phone"] = self.phoneNumTextField.text;
    
    __weak typeof(self) weak_self = self;
    FZDJBindPhoneNumberModel *model = (FZDJBindPhoneNumberModel *)self.model;
    [model bindPhoneNumber:parameter success:^(NSDictionary *dict) {
        [weak_self invalidateTimer];
        [weak_self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        if (!error) {
            [MBProgressHUD wb_showError:@"绑定失败"];
        }
        [weak_self invalidateTimer];
    }];
}

@end
