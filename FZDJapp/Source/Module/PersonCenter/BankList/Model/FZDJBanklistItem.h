//
//  FZDJBanklistItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZDJBankListInfoVO.h"

@interface FZDJBanklistItem : NSObject

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankNumber;
@property (nonatomic, copy) NSString *bgColorHexStr;

@property (nonatomic, strong) FZDJBankListInfoVO *vo;
@end
