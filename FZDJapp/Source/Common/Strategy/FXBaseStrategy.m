//
//  FXBaseStrategy.m
//  NewsDev
//
//  Created by FZYG on 2018/6/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseStrategy.h"

@implementation FXBaseStrategy

- (instancetype)initWithTarget:(id)target{
    
    if (self = [super init]) {
        self.target = target;
    }
    
    return self;
}

@end
