//
//  FZDJMainModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/2.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJBannerListVo.h"
#import "NSDate+FXExtention.h"

@interface FZDJMainModel : FXBaseModel

@property (nonatomic, strong) NSArray<FZDJBannerVo *> *bannerArr;

- (void)loadBannerInfo:(NSDictionary *)parameterDict
               success:(void (^)(NSDictionary *))success
               failure:(void (^)(NSError *))failure;


- (void)loadConfigData;

- (void)checkUser:(NSDictionary *)parameterDict
          success:(void (^)(NSDictionary *))success
          failure:(void (^)(NSError *))failure;
@end
