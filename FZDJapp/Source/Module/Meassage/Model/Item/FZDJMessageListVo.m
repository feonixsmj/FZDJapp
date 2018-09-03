//
//  FZDJMessageListVo.m
//  FZDJapp
//
//  Created by FZYG on 2018/8/7.
//  Copyright © 2018年 FZDJ. All rights reserved.
//

#import "FZDJMessageListVo.h"

@implementation FZDJMessageListVo

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"body" : [FZDJMessageInfoVo class]};
}
@end
