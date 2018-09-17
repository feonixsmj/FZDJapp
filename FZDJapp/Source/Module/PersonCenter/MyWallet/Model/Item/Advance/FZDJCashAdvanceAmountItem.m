//
//  FZDJCashAdvanceAmountItem.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/17.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJCashAdvanceAmountItem.h"

@implementation FZDJCashAdvanceAmountItem

- (void)setTotalAmount:(NSString *)totalAmount{
    _totalAmount =totalAmount;
    
    _descStr = [NSString stringWithFormat:@"可用余额¥%@",totalAmount];
}
@end
