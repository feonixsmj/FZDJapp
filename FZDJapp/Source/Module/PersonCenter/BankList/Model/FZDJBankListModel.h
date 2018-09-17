//
//  FZDJBankListModel.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FXBaseModel.h"
#import "FZDJBanklistItem.h"

@interface FZDJBankListModel : FXBaseModel

- (void)deleteBankCardItem:(NSDictionary *)parameterDict
                   success:(void (^)(NSDictionary *))success
                   failure:(void (^)(NSError *))failure;
@end
