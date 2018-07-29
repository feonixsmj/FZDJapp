//
//  FXBaseStrategy.h
//  NewsDev
//
//  Created by FZYG on 2018/6/27.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXBaseStrategy : NSObject

@property (nonatomic, weak) id target;

- (instancetype)initWithTarget:(id) target;
@end
