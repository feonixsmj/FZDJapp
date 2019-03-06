//
//  FZDJTabBarModel.h
//  FZDJapp
//
//  Created by FZYG on 2019/1/10.
//  Copyright © 2019 FZDJ. All rights reserved.
//


#import "FXBaseModel.h"

@interface FZDJTabBarModel : FXBaseModel

//请求版本号，检查更新
- (void)loadVersion:(NSDictionary *)parameterDict
            success:(void (^)(NSDictionary *dict))success
            failure:(void (^)(NSError *error))failure;
@end


