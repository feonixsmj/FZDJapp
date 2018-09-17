//
//  FZDJCashAdvanceAddCardItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJBankListInfoVO.h"

@interface FZDJCashAdvanceAddCardItem : NSObject

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankDese;

@property (nonatomic, strong) FZDJBankListInfoVO *vo;
@end
