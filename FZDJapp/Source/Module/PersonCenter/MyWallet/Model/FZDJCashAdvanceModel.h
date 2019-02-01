//
//  FZDJCashAdvanceModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJCashAdvanceAddCardItem.h"
#import "FZDJCashAdvanceAmountItem.h"
#import "FZDJBanklistItem.h"

@interface FZDJCashAdvanceModel : FXBaseModel

@property (nonatomic, strong) NSArray<FZDJBanklistItem *> *bankList;
@property (nonatomic, assign) BOOL isWeixin;
@property (nonatomic, assign) BOOL isZhifubao;

- (void)addVance:(NSDictionary *)parameterDict
         success:(void (^)(NSDictionary *))success
         failure:(void (^)(NSError *))failure;
@end

