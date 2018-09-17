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

@interface FZDJMyWalletModel : FXBaseModel

@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy) NSString *cashAdvanceDesc;

- (void)loadCashAdvanceDesc:(NSDictionary *)parameterDict
                    success:(void (^)(NSDictionary *))success
                    failure:(void (^)(NSError *))failure;
@end
