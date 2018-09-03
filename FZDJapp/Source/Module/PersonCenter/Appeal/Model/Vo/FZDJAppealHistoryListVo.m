//
//  FZDJAppealHistoryListVo.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/4.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJAppealHistoryListVo.h"

@implementation FZDJAppealHistoryListVo

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"body" : [FZDJAppealHistoryVo class]};
}

@end
