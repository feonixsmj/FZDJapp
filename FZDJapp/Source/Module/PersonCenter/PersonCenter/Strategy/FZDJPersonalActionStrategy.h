//
//  FZDJPersonalActionStrategy.h
//  FZDJapp
//
//  Created by FZYG on 2018/7/8.
//  Copyright © 2018年 FZYG. All rights reserved.
//

#import "FXBaseStrategy.h"

@interface FZDJPersonalActionStrategy : FXBaseStrategy <FZDJPersonalCellActionProtocol>

- (void)personalCellActionForwarder:(FZDJCellActionType)actionType;
@end
