//
//  FZDJBankCardModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/27.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankCardModel.h"
#import "FZDJMainRequest.h"
#import "FZDJBankInfoListVo.h"
#import "FZDJBankOrgVo.h"

@interface FZDJBankCardModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJBankCardModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self wrapperItems];
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)requestProvinceAndCity:(FZDJGetProvinceCityBlock)block{
    __weak typeof(self) weak_self = self;
    self.request.needEncrypt = NO;
    [self loadItem:nil success:^(NSDictionary *dict) {
        if (weak_self.provinceArr.count != 0) {
            NSString *city = weak_self.provinceArr.firstObject;
            NSDictionary *dict2 = @{@"province":city.length>0 ? city : @""};
            [weak_self loadCity:dict2 success:^(NSDictionary *dict) {
                block(self.provinceArr,self.cityArr);
            } failure:^(NSError *error) {
                block(self.provinceArr,nil);
            }];
        }
        
    } failure:^(NSError *error) {
        block(nil,nil);
    }];

    
}

//- (void)requestProvinceAndCity:(FZDJGetProvinceCityBlock)block{
//    __weak typeof(self) weak_self = self;
//
//    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
//    [blockOperation addExecutionBlock:^{
//        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [weak_self loadItem:nil success:^(NSDictionary *dict) {
//                NSLog(@"123");
//            } failure:^(NSError *error) {
//
//            }];
//        });
//
//    }];
//
//    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
//        if (weak_self.provinceArr.count != 0) {
//            NSString *city = weak_self.provinceArr.firstObject;
//            NSDictionary *dict2 = @{@"province":city.length>0 ? city : @""};
//            [weak_self loadCity:dict2 success:^(NSDictionary *dict) {
//                NSLog(@"453");
//            } failure:^(NSError *error) {
//
//            }];
//        }
//    }];
//
//    [blockOperation2 addDependency:blockOperation];
//
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperations:@[blockOperation,blockOperation2] waitUntilFinished:YES];
//
//    block(self.provinceArr,self.cityArr);
//}

- (void)loadItem:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure{
    __weak typeof(self) weak_self = self;
    self.request.needEncrypt = NO;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryProvince];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            if (head && [head[@"respCode"] integerValue] == 0) {
                NSArray *array = dict[@"body"];
                weak_self.provinceArr = array;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weak_self.provinceArr.count > 0) {
                    success(nil);
                } else {
                    failure(nil);
                }
                
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


- (void)loadCity:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure{
    __weak typeof(self) weak_self = self;
    self.request.needEncrypt = NO;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryCity];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            if (head && [head[@"respCode"] integerValue] == 0) {
                NSArray *array = dict[@"body"];
                weak_self.cityArr = array;
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                if (weak_self.cityArr.count > 0) {
                    success(nil);
                } else {
                    failure(nil);
                }
                
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadOrgBankAddress:(NSDictionary *)parameterDict
                   success:(void (^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure {
    __weak typeof(self) weak_self = self;
    self.request.needEncrypt = NO;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryOrgBank];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            if (head && [head[@"respCode"] integerValue] == 0) {
                
                FZDJBankOrgVo *listVo = [FZDJBankOrgVo mj_objectWithKeyValues:responseObject];
                weak_self.bankOrgStrArr = [NSMutableArray arrayWithArray:listVo.body];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weak_self.bankOrgStrArr.count > 0) {
                    success(nil);
                } else {
                    failure(nil);
                }
                
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadBankAddress:(NSDictionary *)parameterDict
                success:(void (^)(NSDictionary *))success
                failure:(void (^)(NSError *))failure{
    __weak typeof(self) weak_self = self;
    self.request.needEncrypt = NO;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryBank];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            if (head && [head[@"respCode"] integerValue] == 0) {
                FZDJBankInfoListVo *listVo = [FZDJBankInfoListVo mj_objectWithKeyValues:responseObject];
                weak_self.bandArr = listVo.body;
                
                NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:50];
                NSMutableArray *muArr2 = [NSMutableArray arrayWithCapacity:50];
                for (FZDJBankInfoVO *vo in listVo.body) {
                    [muArr addObject:vo.bankName];
                    [muArr2 addObject:vo];
                }
                self.bandAddressStrArr = muArr;
                self.bandInfoArr = muArr2;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weak_self.bandArr.count > 0) {
                    success(nil);
                } else {
                    failure(nil);
                }
                
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)bindInfo:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure{
//    __weak typeof(self) weak_self = self;
    self.request.needEncrypt = YES;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiAddUserBank];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dict = responseObject;
            NSDictionary *head = dict[@"head"];
            
            BOOL isSuccess;
            if (head && [head[@"respCode"] integerValue] == 0) {
                isSuccess = YES;
            } else {
                isSuccess = NO;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isSuccess) {
                    success(nil);
                } else {
                    failure(nil);
                }
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)wrapperItems {
    FZDJBankCardIdentityItem *item1 = [FZDJBankCardIdentityItem new];
    item1.title = @"持卡人：";
    item1.placeholder = @"请输入姓名";
    item1.type = FZDJBankCardIdentityItemTypeName;
    
    FZDJBankCardIdentityItem *item2 = [FZDJBankCardIdentityItem new];
    item2.title = @"身份证：";
    item2.placeholder = @"请输入身份证";
    item2.type = FZDJBankCardIdentityItemTypeID;
    
    FZDJBankCardIdentityItem *item3 = [FZDJBankCardIdentityItem new];
    item3.title = @"手机号：";
    item3.placeholder = @"请输入手机号";
    item3.type = FZDJBankCardIdentityItemTypePhoneNumber;
    
    FZDJBankCardIdentityItem *item4 = [FZDJBankCardIdentityItem new];
    item4.title = @"银行卡：";
    item4.placeholder = @"请输入卡号";
    item4.type = FZDJBankCardIdentityItemTypeCardNumber;
    
    
    FZDJBankCardItem *item5 = [FZDJBankCardItem new];
    item5.title = @"开户行省市：";
    item5.contentText = @"请选择";
    item5.type = FZDJBankCardItemTypeProvince;
    
    
    FZDJBankCardItem *item6 = [FZDJBankCardItem new];
    item6.title = @"开户总行：";
    item6.contentText = @"请选择";
    item6.type = FZDJBankCardItemTypeOrgBankName;
    
    FZDJBankCardItem *item7 = [FZDJBankCardItem new];
    item7.title = @"开户支行：";
    item7.contentText = @"请选择";
    item7.type = FZDJBankCardItemTypeBankAddress;
    
    FZDJIDCardItem *item8 = [FZDJIDCardItem new];
    
    FZDJPersonalBlankItem *blankItem = [FZDJPersonalBlankItem new];
    self.items = @[item1,item2,item3,blankItem,item5,item6,item7,item4,blankItem,item8].mutableCopy;
}
@end
