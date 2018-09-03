//
//  FZDJMyTaskListVo.m
//  FZDJapp
//
//  Created by FZYG on 2018/7/30.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FZDJMyTaskListVo.h"

@implementation FZDJMyTaskListVo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"body" : [FZDJMyTaskInfoVO class]};
}
@end
