//
//  FZDJMyWalletVO.h
//  FZDJapp
//
//  Created by FZYG on 2018/9/9.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZDJMyWalletVO : NSObject


/**
 总任务奖励金额
 */
@property (nonatomic, strong) NSNumber *totalAmount;
/**
 已提现金额
 */
@property (nonatomic, strong) NSNumber *useAmount;
/**
 未提现金额
 */
@property (nonatomic, strong) NSNumber *validAmount;
@end
