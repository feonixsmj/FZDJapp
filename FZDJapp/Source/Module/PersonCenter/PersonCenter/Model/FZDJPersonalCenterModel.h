//
//  FZDJPersonalCenterModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJPersonalListItem.h"
#import "FZDJPersonalTaskItem.h"
#import "FZDJPersonalInfoItem.h"
#import "FZDJPersonalBlankItem.h"

@interface FZDJPersonalCenterModel : FXBaseModel

- (void)updateData;

//第三方绑定
- (void)thirdBindWithType:(NSDictionary *)parameterDict
                  success:(void (^)(NSDictionary *dict))success
                  failure:(void (^)(NSError *error))failure;

- (void)loadCustomServer:(NSDictionary *)parameterDict
                 success:(void (^)(NSDictionary *dict))success
                 failure:(void (^)(NSError *error))failure;
//请求版本号，检查更新
- (void)loadVersion:(NSDictionary *)parameterDict
            success:(void (^)(NSDictionary *dict))success
            failure:(void (^)(NSError *error))failure;
@end
