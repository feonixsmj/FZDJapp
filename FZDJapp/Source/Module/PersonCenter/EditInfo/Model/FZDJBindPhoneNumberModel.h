//
//  FZDJBindPhoneNumberModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/22.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXBaseModel.h"

@interface FZDJBindPhoneNumberModel : FXBaseModel

//获取验证码
- (void)getCodeNumber:(NSDictionary *)parameterDict
              success:(void (^)(NSDictionary *dict))success
              failure:(void (^)(NSError *error))failure;

//手机登录
- (void)bindPhoneNumber:(NSDictionary *)parameterDict
                success:(void (^)(NSDictionary *dict))success
                failure:(void (^)(NSError *error))failure;

@end


