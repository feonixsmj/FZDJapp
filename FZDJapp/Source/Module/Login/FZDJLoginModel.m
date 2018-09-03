//
//  FZDJLoginModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/4.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJLoginModel.h"
#import "FZDJMainRequest.h"

@interface FZDJLoginModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJLoginModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)phoneNumberLogin:(NSDictionary *)parameterDict
                 success:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure{
//    __weak typeof(self) weak_self = self;
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskDologin];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *userNo = dict[@"body"][@"userNo"];
        dm.userInfo.userNo = userNo;
        [dm saveData];
        success(nil);
    } failure:^(NSError *error) {
        failure(error);
        NSLog(@"登录失败");
    }];
}

- (void)getCodeNumber:(NSDictionary *)parameterDict
              success:(void (^)(NSDictionary *dict))success
              failure:(void (^)(NSError *error))failure{
    
    __weak typeof(self) weak_self = self;
    NSMutableDictionary *parameter =
        [NSMutableDictionary dictionaryWithDictionary:parameterDict];
    parameter[@"type"] = @"DL";
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiTaskGetLoginCode];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        NSDictionary *dict = responseObject;
        NSLog(@"%@",dict);
    } failure:^(NSError *error) {
        NSLog(@"登录失败");
    }];
    
}

#pragma mark - ================ 第三方登录 ================
- (void)thirdLoginWithType:(SSDKPlatformType )platFormType
                   success:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure{
    
    FZDJDataModelSingleton *dm = [FZDJDataModelSingleton sharedInstance];
    
    [ShareSDK getUserInfo:platFormType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
         if (state == SSDKResponseStateSuccess){
             
             dm.userInfo.avatarURL = user.icon;
             dm.userInfo.nickName = user.nickname;
             dm.userInfo.openid = user.uid;
             dm.userInfo.sexInteger = 1;
             
             switch (platFormType) {
                 case SSDKPlatformTypeWechat:{
                     NSDictionary *dict = user.rawData;
                     dm.userInfo.sexInteger = [dict[@"sex"] integerValue];
                     dm.userInfo.loginType = FZDJUserInfoLoginTypeWechat;
                     dm.userInfo.weixinNickName = user.nickname;
                 }
                     break;
                 case SSDKPlatformTypeQQ:{
                     dm.userInfo.loginType = FZDJUserInfoLoginTypeQQ;
                     dm.userInfo.qqNickName = user.nickname;
                 }
                     break;
                 case SSDKPlatformTypeSinaWeibo:{
                     dm.userInfo.loginType = FZDJUserInfoLoginTypeWeibo;
                     dm.userInfo.sinaNickName = user.nickname;
                 }
                     break;
                     
                 default:
                     break;
             }
             
             success(nil);
             
         } else {
             failure(error);
         }
         
     }];
}

@end
