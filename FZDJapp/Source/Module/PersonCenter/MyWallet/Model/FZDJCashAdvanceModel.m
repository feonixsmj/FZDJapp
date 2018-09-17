//
//  FZDJCashAdvanceModel.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJCashAdvanceModel.h"
#import "FZDJBankListVo.h"
#import "FZDJCashAdvanceModel.h"
#import "FZDJMainRequest.h"

@interface FZDJCashAdvanceModel()
@property (nonatomic, strong) FZDJMainRequest *request;
@end

@implementation FZDJCashAdvanceModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.request = [[FZDJMainRequest alloc] init];
    }
    return self;
}

- (void)loadItem:(NSDictionary *)parameterDict success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    __weak typeof(self) weak_self = self;
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userNo"] = [FZDJDataModelSingleton sharedInstance].userInfo.userNo;
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiQueryMyBank];
    
    [self.request requestPostURL:url parameters:parameter success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            FZDJBankListVo *vo = [FZDJBankListVo mj_objectWithKeyValues:responseObject];
            [weak_self wrapperItem:vo.body];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)wrapperItem:(NSArray *)list{
    NSMutableArray *muArr = [NSMutableArray arrayWithCapacity:1];
    
    for (FZDJBankListInfoVO *vo in list) {
        FZDJBanklistItem *item = [FZDJBanklistItem new];
        item.iconUrl = vo.bankIcon;
        item.bankName = vo.bankName;
        item.bankNumber = vo.bankCardNumber;
        
        if ([vo.bankColor isEqualToString:@"HONG"]) {
            item.bgColorHexStr = @"E55F61";
        } else if ([vo.bankColor isEqualToString:@"LAN"]){
            item.bgColorHexStr = @"3C67A5";
        } else if ([vo.bankColor isEqualToString:@"LV"]){
            item.bgColorHexStr = @"1B9F85";
        } else {//HUANG
            item.bgColorHexStr = @"FDC132";
        }
        
        item.vo = vo;
        [muArr addObject:item];
    }
    
    FZDJBanklistItem *addCarditem = [FZDJBanklistItem new];
    addCarditem.bankName = @"添加银行卡";
    [muArr insertObject:addCarditem atIndex:0];
    
    self.bankList = muArr;
    
    FZDJCashAdvanceAddCardItem *item1 = [FZDJCashAdvanceAddCardItem new];

    FZDJCashAdvanceAmountItem *item2 = [FZDJCashAdvanceAmountItem new];
    
    self.items = [NSMutableArray arrayWithArray:@[item1,item2]];
}

- (void)addVance:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure{
    __weak typeof(self) weak_self = self;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiDomain,kApiUserCashOut];
    
    [self.request requestPostURL:url parameters:parameterDict success:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
