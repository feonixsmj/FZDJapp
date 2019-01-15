//
//  FZDJMyWalletModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/9.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJPriceItem.h"
#import "FZDJCashItem.h"
#import "FZDJDescItem.h"
#import "FZDJBanklistItem.h"

@interface FZDJMyWalletModel : FXBaseModel

@property (nonatomic, strong) NSArray<FZDJBanklistItem *> *bankList;

@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *cashAdvanceDesc;
@property (nonatomic, strong) NSNumber *validAmount;

- (void)loadCashAdvanceDesc:(NSDictionary *)parameterDict
                    success:(void (^)(NSDictionary *))success
                    failure:(void (^)(NSError *))failure;
@end
