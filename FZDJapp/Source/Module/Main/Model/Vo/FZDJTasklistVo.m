//
//  FZDJTasklistVo.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJTasklistVo.h"

@implementation FZDJTasklistVo

+ (NSDictionary *)mj_objectClassInArray {
    return @{ @"body" : [FZDJTaskInfoVo class]};
}
@end
