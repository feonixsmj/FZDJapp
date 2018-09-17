//
//  FZDJCashAdvanceAmountItem.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJCashAdvanceAmountItem : NSObject

@property (nonatomic, copy) NSString *totalAmount;
@property (nonatomic, copy, readonly) NSString *descStr;

@property (nonatomic, copy) NSString *advanceAmount;
@end
