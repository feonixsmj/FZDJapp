//
//  FZDJLoginVCL.m
//  FZDJapp
//
//  Created by FZYG on 2018/6/25.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJLoginVCL.h"
#import "FXGuideView.h"
#import "FXImageView.h"
#import "FZDJDataModelSingleton.h"
#import <ShareSDK/ShareSDK.h>
#import "FZDJDataModelSingleton.h"
#import "FZDJMainRequest.h"
#import "FXSystemInfo.h"
#import "FZDJLoginModel.h"
#import "NSString+FXCategory.h"
#import "FZDJUserProtocolWindow.h"

@interface FZDJLoginVCL ()

@property (weak, nonatomic) IBOutlet FXImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet FXImageView *phoneNumberIcon;
@property (weak, nonatomic) IBOutlet FXImageView *codeIcon;
@property (weak, nonatomic) IBOutlet FXImageView *loginAvatarIcon;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *thirdPartLoginView;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *userProtocol;

@property (nonatomic, strong) FZDJMainRequest *request;
@property (nonatomic, strong) FZDJLoginModel *model;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) FZDJUserProtocolWindow *protocolWindow;
@end

@implementation FZDJLoginVCL


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
        self.model = [[FZDJLoginModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是否是第一安装 或者覆盖安装
    if ([[FZDJDataModelSingleton sharedInstance] isNewIntall]) {
        [self setGuidePage];
    }
    [self initUI];
}

- (void)initUI{
    self.backgroundImageView.image = [UIImage imageNamed:@"dj_guide_backgroud_image"];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerKeyBoard)];
    [self.backgroundImageView addGestureRecognizer:gesture];
    
    self.phoneNumberIcon.image = [UIImage imageNamed:@"phone_icon"];
    self.codeIcon.image = [UIImage imageNamed:@"yanzhen_icon"];
    
    self.loginAvatarIcon.image = [UIImage imageNamed:@"login_icon"];
    self.loginAvatarIcon.backgroundColor = [UIColor clearColor];
    
    self.getCodeButton.layer.cornerRadius = self.getCodeButton.height / 2;
    self.loginButton.layer.cornerRadius = self.loginButton.height / 2;
    
    self.phoneNumberTextField.text = @"";
    self.codeTextField.text = @"";
    
    self.phoneNumberTextField.attributedPlaceholder =
                        [self getCustomPlaceholderWithStr:@"请输入手机号"];
    self.codeTextField.attributedPlaceholder =
                        [self getCustomPlaceholderWithStr:@"请输入验证码"];
    
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.selectedBtn.adjustsImageWhenHighlighted = NO;
    self.userProtocol.adjustsImageWhenHighlighted = NO;
}

- (NSMutableAttributedString *)getCustomPlaceholderWithStr:(NSString *)holderText{
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor whiteColor]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    return placeholder;
}

- (void)setGuidePage{
    NSArray *imageNameArray = @[@"guide_page1",
                                @"guide_page2",
                                @"guide_page3",
                                @"guide_page4"];
    
    FXGuideView *guideView = [[FXGuideView alloc] initWithFrame:self.view.frame
                                                 imageNameArray:imageNameArray
                                                 buttonIsHidden:NO];
    
    [self.view addSubview:guideView];
}

- (void)registerKeyBoard{
    [self.phoneNumberTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
}

- (FZDJUserProtocolWindow *)protocolWindow{
    if (!_protocolWindow) {
        _protocolWindow = [[FZDJUserProtocolWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        __block FZDJUserProtocolWindow *blockWindow = _protocolWindow;
        _protocolWindow.closeblock = ^(){
            blockWindow = nil;
        };
    }
    return _protocolWindow;
}

#pragma mark ================ ButtonClicked ================

- (IBAction)selectedBtnClicked:(id)sender {
    self.selected = !self.selected;
    
    NSString *imageName = self.selected ? @"icon_check" : @"icon_uncheck";
    [self.selectedBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (IBAction)userProtocolClicked:(id)sender {
//    NSLog(@"弹出用户协议");
    [self.protocolWindow show];
    [self.protocolWindow makeKeyWindow];
}

- (IBAction)loginBtnDidClicked:(id)sender {
    [self phoneNumberLogin];
}

- (IBAction)getCodeButtonDidClicked:(id)sender {
    
    if (self.phoneNumberTextField.text.length == 0) {
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
    
    NSString *phoneNumber = self.phoneNumberTextField.text;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"phone"] = phoneNumber;
    
    __weak typeof(self) weak_self = self;
    [self.model getCodeNumber:parameter success:^(NSDictionary *dict) {
        
        [MBProgressHUD wb_showMessage:@"发送成功，请等待"];
        
    } failure:^(NSError *error) {
        
        [weak_self invalidateTimer];
        [weak_self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
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

- (IBAction)thirdPartLoginDidClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger tag = btn.tag;
    
    SSDKPlatformType platformType;
    if(tag == 88){
        //微信
        platformType = SSDKPlatformTypeWechat;
    } else if (tag == 77) {
        platformType = SSDKPlatformTypeQQ;
    } else {
        platformType = SSDKPlatformTypeSinaWeibo;
    }
    
    __weak typeof(self) weak_self = self;
    [self.model thirdLoginWithType:platformType success:^(NSDictionary *dict) {
        [weak_self thirdPartLogin];
    } failure:^(NSError *error) {
        NSLog(@"登录失败");
    }];
}

#pragma mark - ================ 手机号登录 ================
- (void)phoneNumberLogin{
    [self.view endEditing:YES];
    
    if (self.phoneNumberTextField.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入手机号"];
        return;
    }
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD wb_showError:@"请输入验证码"];
        return;
    }
    if (!self.selected) {
        [MBProgressHUD wb_showError:@"尚未同意《用户协议》"];
        return;
    }
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    dm.userInfo.loginType = FZDJUserInfoLoginTypePhone;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"code"] = self.codeTextField.text;
    parameter[@"ip"] = [NSString getIPAddress:NO];
    parameter[@"machineCode"] = [FXSystemInfo orginalIdfa];
//    parameter[@"machineCode"] =  @"123";
    parameter[@"phone"] = self.phoneNumberTextField.text;
    
    __weak typeof(self) weak_self = self;
    [self.model phoneNumberLogin:parameter success:^(NSDictionary *dict) {
        [weak_self loginSuccess];
    } failure:^(NSError *error) {
        NSLog(@"登录失败");
    }];
}

#pragma mark - ================ 第三方登录 ================
- (void)thirdPartLogin{
    __weak typeof(self) weak_self = self;
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"headImg"] = dm.userInfo.avatarURL;
    parameter[@"ip"] = [NSString getIPAddress:NO];
    
    parameter[@"machineCode"] = [FXSystemInfo orginalIdfa];
    parameter[@"nickName"] = dm.userInfo.nickName;
    parameter[@"sex"] = dm.userInfo.sexInteger == 1 ? @"NAN":@"NV";
    parameter[@"openid"] = dm.userInfo.openid;
    
    NSString *loginType = @"";
    if (dm.userInfo.loginType == FZDJUserInfoLoginTypeQQ) {
        loginType = @"QQ";
    } else if (dm.userInfo.loginType == FZDJUserInfoLoginTypeWechat){
        loginType = @"WX";
    } else if (dm.userInfo.loginType == FZDJUserInfoLoginTypeWeibo){
        loginType = @"WB";
    }
    parameter[@"type"] = loginType;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskOtherlogin];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *userNo = dict[@"body"][@"userNo"];
        dm.userInfo.userNo = userNo;
        [weak_self loginSuccess];
        
    } failure:^(NSError *error) {
        NSLog(@"登录失败");
    }];

}
#pragma mark - ================ 登录成功 ================
- (void)loginSuccess {
    [self invalidateTimer];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccess)]) {
        [self.delegate loginSuccess];
    }
}


@end
