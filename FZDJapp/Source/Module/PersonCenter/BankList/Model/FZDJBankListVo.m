//
//  FZDJBankListVo.m
//  FZDJapp
//
//  Created by FZYG on 2018/9/16.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJBankListVo.h"

@implementation FZDJBankListVo
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"body" : [FZDJBankListInfoVO class]};
}
@end
