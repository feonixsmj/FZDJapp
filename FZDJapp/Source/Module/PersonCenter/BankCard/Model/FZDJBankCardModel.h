//
//  FZDJBankCardModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJBankCardItem.h"
#import "FZDJBankCardIdentityItem.h"
#import "FZDJPersonalBlankItem.h"
#import "FZDJBankInfoVO.h"
#import "FZDJIDCardItem.h"

typedef void(^FZDJGetProvinceCityBlock)(NSArray *proviceArr,NSArray *cityArr);

@interface FZDJBankCardModel : FXBaseModel

@property (nonatomic, strong) NSArray *provinceArr;
@property (nonatomic, strong) NSArray *cityArr;
@property (nonatomic, strong) NSArray *bandArr;

@property (nonatomic, strong) NSMutableArray *bankOrgStrArr;

@property (nonatomic, strong) NSArray *bandAddressStrArr;
@property (nonatomic, strong) NSArray *bandInfoArr;

- (void)requestProvinceAndCity:(FZDJGetProvinceCityBlock)block;


/**
 查询城市
 */
- (void)loadCity:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure;
/**
 查询总行
 */
- (void)loadOrgBankAddress:(NSDictionary *)parameterDict
                   success:(void (^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure;
/**
 查询支行地址
 */
- (void)loadBankAddress:(NSDictionary *)parameterDict
                success:(void (^)(NSDictionary *))success
                failure:(void (^)(NSError *))failure;

- (void)bindInfo:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure;
@end
