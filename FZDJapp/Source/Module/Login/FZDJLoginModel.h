//
//  FZDJLoginModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/4.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import <ShareSDK/ShareSDK.h>


@interface FZDJLoginModel : FXBaseModel

//获取验证码
- (void)getCodeNumber:(NSDictionary *)parameterDict
              success:(void (^)(NSDictionary *dict))success
              failure:(void (^)(NSError *error))failure;

//第三方登录
- (void)thirdLoginWithType:(SSDKPlatformType )platFormType
                   success:(void (^)(NSDictionary *dict))success
                   failure:(void (^)(NSError *error))failure;

//手机登录
- (void)phoneNumberLogin:(NSDictionary *)parameterDict
                 success:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure;
@end
