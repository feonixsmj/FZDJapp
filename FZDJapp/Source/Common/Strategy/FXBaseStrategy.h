//
//  FXBaseStrategy.h
//  NewsDev
//
//  Created by suminjie on 2018/6/27.
//  Copyright © 2018年 onemt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseStrategy : NSObject

@property (nonatomic, weak) id target;

- (instancetype)initWithTarget:(id) target;
@end
